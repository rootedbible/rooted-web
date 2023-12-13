import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooted_web/ui/organizations/widgets/manage_subscription_popup.dart';
import 'package:rooted_web/ui/organizations/widgets/social_tile.dart';
import 'package:rooted_web/ui/widgets/info_tile.dart';

import '../../api/services/organizations_service.dart';
import '../../api/services/users_service.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/organizations/organizations_bloc.dart';
import '../../models/organization_model.dart';
import '../../utils/get_map_string.dart';
import '../widgets/snackbar.dart';
import 'create_organization_screen.dart';
import 'organization_management_screen.dart';

class OrganizationScreen extends StatefulWidget {
  final Organization organization;

  const OrganizationScreen(this.organization, {super.key});

  @override
  State<OrganizationScreen> createState() => _OrganizationScreenState();
}

class _OrganizationScreenState extends State<OrganizationScreen> {
  late Organization organization;

  @override
  void initState() {
    super.initState();
    organization = widget.organization;
  }

  static const String statusAdmin = 'admin';
  static const String statusModerator = 'moderator';
  static const String statusInvited = 'invited';
  static const String statusRequested = 'requested';
  static const String statusMember = 'member';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('@${organization.username}'),
        centerTitle: false,
        actions: organization.status == statusAdmin ||
                organization.status == statusModerator
            ? [
                if ((organization.subscription.userId ==
                        context.read<AuthBloc>().user.uniqueId) ||
                    (organization.status == statusAdmin &&
                        !organization.subscription.isActive))
                  IconButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) =>
                            ManageSubscriptionPopup(organization)),
                    icon: Icon(Icons.auto_awesome),
                    tooltip: 'Manage Subscription',
                  ),
                IconButton(
                  onPressed: () async {
                    final Organization? newOrganization = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CreateOrganizationScreen(organization),
                      ),
                    );
                    if (newOrganization != null) {
                      setState(() {
                        organization = newOrganization;
                      });
                    }
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OrganizationManagementScreen(organization),
                    ),
                  ),
                  icon: const Icon(Icons.group_add),
                ),
              ]
            : null,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => await refreshOrg(),
          child: ListView(
            children: [
              if (organization.status == statusInvited)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("You've been invited!"),
                    ElevatedButton(
                      onPressed: () async {
                        await OrganizationsService().manageInvite(
                          organizationId: organization.uniqueId,
                          accept: false,
                        );
                        setState(() {
                          organization = organization.copyWith(status: null);
                        });
                      },
                      child: const Text('Deny'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await OrganizationsService().manageInvite(
                          organizationId: organization.uniqueId,
                          accept: true,
                        );
                        setState(() {
                          organization =
                              organization.copyWith(status: statusMember);
                        });
                      },
                      child: const Text('Accept'),
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: organization.profileUrl!,
                        width: 96,
                        height: 96,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) {
                          return const Icon(
                            Icons.account_circle,
                            size: 96,
                          );
                        },
                      ),
                    ),
                    InfoTile(
                      '${organization.numMembers}',
                      'Member${organization.numMembers == 1 ? "" : "s"}',
                      context: context,
                      organization: organization.status == statusMember ||
                              organization.status == statusAdmin ||
                              organization.status == statusModerator
                          ? organization
                          : null,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            if (organization.status == 'member' ||
                                organization.status == 'moderator' ||
                                organization.status == 'admin') {
                              await UsersService()
                                  .leaveOrganization(organization.uniqueId);
                              setState(() {
                                organization = organization.copyWith(
                                  numMembers: organization.numMembers - 1,
                                  status: null,
                                );
                              });
                              context
                                  .read<OrganizationsBloc>()
                                  .add(GetMyOrganizations());
                            } else if (organization.status == null &&
                                !organization.isPrivate) {
                              await OrganizationsService().requestToJoin(
                                organization.uniqueId,
                              );
                              setState(() {
                                organization = organization.copyWith(
                                  status: statusRequested,
                                );
                              });
                            }
                          } catch (e) {
                            snackbar(context, 'Error: $e');
                          }
                        },
                        child: Text(
                          organization.status == statusRequested
                              ? 'Requested'
                              : organization.status != null &&
                                      organization.status != statusInvited
                                  ? 'Joined'
                                  : organization.isPrivate
                                      ? 'Invite Only'
                                      : 'Join',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                  right: 16.0,
                  left: 16.0,
                ),
                child: Text(
                  organization.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                  right: 16.0,
                  left: 16.0,
                ),
                child: Text(organization.description ?? ''),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (getMapString(organization) != null)
                      SocialTile(
                        site: getMapString(organization)!,
                        type: 'location',
                      ),
                    if (organization.facebook != null)
                      SocialTile(
                        site: 'Facebook',
                        username: organization.facebook!,
                      ),
                    if (organization.instagram != null)
                      SocialTile(
                        site: 'Instagram',
                        username: organization.instagram!,
                      ),
                    if (organization.x != null)
                      SocialTile(site: 'X', username: organization.x!),
                    if (organization.tiktok != null)
                      SocialTile(
                        site: 'TikTok',
                        username: organization.tiktok!,
                      ),
                    if (organization.website != null)
                      SocialTile(
                        site: organization.website!,
                        type: 'website',
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> refreshOrg() async {
    try {
      final Organization refreshedOrg = await OrganizationsService()
          .getOrganizationById(widget.organization.uniqueId);
      setState(() {
        organization = refreshedOrg;
      });
    } catch (e) {
      debugPrint('Error on refresh org: $e');
      snackbar(context, "Couldn't Refresh Organization!");
    }
  }
}

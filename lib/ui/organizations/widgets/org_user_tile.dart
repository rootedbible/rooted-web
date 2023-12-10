import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../api/services/organizations_service.dart';
import '../../../bloc/organizations/organizations_bloc.dart';
import '../../../models/organization_model.dart';
import '../../../models/user_model.dart';
import '../../widgets/snackbar.dart';
import 'edit_user_popup.dart';

class OrgUserTile extends StatefulWidget {
  final int index;
  final User user;
  final Organization organization;

  const OrgUserTile({
    required this.user,
    required this.organization,
    required this.index,
    super.key,
  });

  @override
  State<OrgUserTile> createState() => _OrgUserTileState();
}

class _OrgUserTileState extends State<OrgUserTile> {
  late User user;
  late Organization organization;
  int index = 0;

  @override
  void initState() {
    super.initState();
    user = widget.user;
    organization = widget.organization;
    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: CachedNetworkImage(
          imageUrl: user.imageUrl,
          height: 32,
          width: 32,
          errorWidget: (_, __, ___) => const Icon(
            Icons.account_circle,
            size: 32,
          ),
        ),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${user.firstName} ${user.lastName} ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildUserStatusIcon(user.orgStatus),
            ],
          ),
          Text(user.username),
        ],
      ),
      trailing: user.orgStatus == 'requested'
          ? _buildRequestActions()
          : organization.status == 'admin'
              ? _buildAdminActions()
              : null,
    );
  }

  Widget _buildUserStatusIcon(String? orgStatus) {
    switch (orgStatus) {
      case 'admin':
        return Icon(
          Icons.admin_panel_settings,
          color: Theme.of(context).colorScheme.primary,
        );
      case 'moderator':
        return Icon(
          Icons.remove_red_eye,
          color: Theme.of(context).colorScheme.secondary,
        );
      case 'member':
        return Icon(
          Icons.account_circle,
          color: Theme.of(context).colorScheme.tertiary,
        );
      case 'invited':
        return Icon(
          Icons.mail,
          color: Theme.of(context).colorScheme.primary,
        );
      case 'requested':
        return Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.primary,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildRequestActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () => _manageRequest(false),
          child: const Text('Deny'),
        ),
        TextButton(
          onPressed: () => _manageRequest(true),
          child: const Text('Accept'),
        ),
      ],
    );
  }

  Widget _buildAdminActions() {
    return IconButton(
      onPressed: () async {
        final status = await showDialog(
          context: context,
          builder: (context) => EditUserPopup(
            orgId: organization.uniqueId,
            status: user.orgStatus!,
            user: user,
          ),
        );
        if (status != null) {
          if (status == 'remove') {
            context.read<OrganizationsBloc>().add(RemoveUser(index: index));
          } else {
            setState(() {
              user = user.copyWith(orgStatus: status);
            });
          }
        }
      },
      icon: const Icon(Icons.edit),
    );
  }

  Future<void> _manageRequest(bool accepted) async {
    try {
      await OrganizationsService().manageRequest(
        accepted: accepted,
        organizationId: organization.uniqueId,
        userId: user.uniqueId,
      );
      context
          .read<OrganizationsBloc>()
          .add(ToggleRequest(user: user, accepted: accepted));
    } catch (e) {
      snackbar(context, 'Error on accept/deny request!');
      rethrow;
    }
  }
}

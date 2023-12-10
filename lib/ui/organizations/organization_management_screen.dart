import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooted_web/ui/organizations/widgets/invite_popup.dart';
import 'package:rooted_web/ui/organizations/widgets/org_user_tile.dart';

import '../../bloc/organizations/organizations_bloc.dart';
import '../../models/organization_model.dart';
import '../../models/user_model.dart';
import '../widgets/divider_line.dart';

class OrganizationManagementScreen extends StatefulWidget {
  final Organization organization;

  const OrganizationManagementScreen(this.organization, {super.key});

  @override
  State<OrganizationManagementScreen> createState() =>
      _OrganizationManagementScreenState();
}

class _OrganizationManagementScreenState
    extends State<OrganizationManagementScreen> {
  late final Organization organization;
  final TextEditingController searchController = TextEditingController();
  String type = 'members';

  @override
  void initState() {
    super.initState();
    organization = widget.organization;
    context
        .read<OrganizationsBloc>()
        .add(GetOrgUsers(uniqueId: organization.uniqueId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrganizationsBloc, OrganizationsState>(
      listener: (context, state) {},
      builder: (context, state) {
        late final List<User> users;
        if (type == 'members') {
          users = context.read<OrganizationsBloc>().memberUsers;
        } else if (type == 'requests') {
          users = context.read<OrganizationsBloc>().requestUsers;
        } else if (type == 'invited') {
          users = context.read<OrganizationsBloc>().invitedUsers;
        } else {
          users = [];
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(organization.name),
            actions: [
              IconButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => OrganizationInvitePopup(organization),
                ),
                icon: const Icon(Icons.forward_to_inbox),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    hintText: 'Search Users Here',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              _buildTypeSelector(),
              const DividerLine(),
              Expanded(
                child: state is OrganizationLoading
                    ? const Center(child: CircularProgressIndicator())
                    : buildUserList(users),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildUserList(List<User> users) {
    return RefreshIndicator(
      onRefresh: () async => context
          .read<OrganizationsBloc>()
          .add(GetOrgUsers(uniqueId: organization.uniqueId)),
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final User user = users[index];
          return OrgUserTile(
            user: user,
            organization: organization,
            index: index,
          );
        },
      ),
    );
  }

  Widget _buildTypeSelector() {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTypeButton('Members', type == 'members'),
          const VerticalDivider(),
          _buildTypeButton('Requests', type == 'requests'),
          const VerticalDivider(),
          _buildTypeButton('Invited', type == 'invited'),
        ],
      ),
    );
  }

  Widget _buildTypeButton(String text, bool isSelected) {
    return SizedBox(
      width: 125,
      child: TextButton(
        onPressed: () {
          setState(() {
            type = text.toLowerCase();
          });
        },
        child: Text(
          text,
          style: isSelected
              ? const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                )
              : null,
        ),
      ),
    );
  }
}

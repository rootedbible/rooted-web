import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooted_web/ui/organizations/widgets/user_tile.dart';

import '../../../bloc/organizations/organizations_bloc.dart';
import '../../../models/organization_model.dart';
import '../../../models/user_model.dart';

class OrganizationUsersScreen extends StatefulWidget {
  final Organization organization;

  const OrganizationUsersScreen(this.organization, {super.key});

  @override
  State<OrganizationUsersScreen> createState() =>
      _OrganizationUsersScreenState();
}

class _OrganizationUsersScreenState extends State<OrganizationUsersScreen> {
  late final Organization organization;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    organization = widget.organization;
    context
        .read<OrganizationsBloc>()
        .add(GetOrgUsers(uniqueId: organization.uniqueId, isWrite: false));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrganizationsBloc, OrganizationsState>(
      listener: (context, state) {
        // TODO: Implement listener if needed
      },
      builder: (context, state) {
        final memberUsers = context.read<OrganizationsBloc>().memberUsers;
        return Scaffold(
          appBar: AppBar(
            title: Text("${organization.username}'s Members"),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Search',
                    hintText: 'Search Member Here',
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: memberUsers.length,
                  itemBuilder: (context, index) {
                    final User user = memberUsers[index];
                    return UserTile(user);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

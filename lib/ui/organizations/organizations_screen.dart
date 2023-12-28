import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooted_web/bloc/auth/auth_bloc.dart';
import 'package:rooted_web/ui/organizations/create_org_screen.dart';
import 'package:rooted_web/ui/organizations/widgets/manage_subscription_popup.dart';
import 'package:rooted_web/ui/organizations/widgets/organization_tile.dart';

import '../../bloc/organizations/organizations_bloc.dart';
import '../../models/user_model.dart';

class OrganizationsScreen extends StatefulWidget {
  final bool isMobile;

  const OrganizationsScreen({required this.isMobile, super.key});

  @override
  State<OrganizationsScreen> createState() => _OrganizationsScreenState();
}

class _OrganizationsScreenState extends State<OrganizationsScreen> {
  late final bool isMobile;

  @override
  void initState() {
    super.initState();
    isMobile = widget.isMobile;
    context.read<OrganizationsBloc>().add(GetMyOrganizations());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrganizationsBloc, OrganizationsState>(
      listener: (context, state) {},
      builder: (context, state) {
        final organizations =
            context.select((OrganizationsBloc bloc) => bloc.organizations);
        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.groups),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Subscriptions and Groups'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateOrgScreen(
                              null,
                            ),
                          ),
                        ),
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),
              if (context.read<AuthBloc>().user.subscription != null)
                _buildIndividual(context.read<AuthBloc>().user),
              Expanded(
                child: state is OrganizationLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : organizations.isEmpty
                        ? const Center(
                            child: Text('No Groups!'),
                          )
                        : RefreshIndicator(
                            onRefresh: () async => context
                                .read<OrganizationsBloc>()
                                .add(GetMyOrganizations()),
                            child: ListView.builder(
                              itemCount: organizations.length,
                              itemBuilder: (context, index) {
                                final organization = organizations[index];
                                return OrganizationTile(organization);
                              },
                            ),
                          ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIndividual(User user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => ManageSubscriptionPopup(user.subscription!, null),
          child: const Text('Manage Individual Subscription'),
        ),
      ],
    );
  }
}

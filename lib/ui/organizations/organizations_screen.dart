import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/organizations/organizations_bloc.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrganizationsBloc, OrganizationsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          // TODO: Implement Drawer here
          drawer: isMobile ? null : null,
          appBar: _buildAppBar(),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Groups & Subscriptions'),

    );
  }
}

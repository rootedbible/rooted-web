import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooted_web/bloc/admin/users/users_bloc.dart';
import 'package:rooted_web/ui/admin/users/widgets/admin_user_tile.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Users',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _searchController,
          ),
        ),
        Expanded(child: ListView.builder(itemCount: context.read<UsersBloc>().users.length, itemBuilder: (context, index) => AdminUserTile(user: context.read<UsersBloc>().users.elementAt(index)))),
      ],),
    );
  }
}

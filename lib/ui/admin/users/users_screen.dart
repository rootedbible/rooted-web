import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:rooted_web/bloc/admin/users/users_bloc.dart";
import "package:rooted_web/ui/admin/users/widgets/admin_user_tile.dart";
import "package:rooted_web/utils/user_download_service.dart";

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  double scrollPosition = 0.0;

  @override
  void initState() {
    _handleSearch();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      scrollPosition = _scrollController.position.pixels;
      _handleSearch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersBloc, UsersState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Users",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  // Download Icon
                  IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () => UserDownloadService.downloadAllUsers(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (_) => _handleSearch(),
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search Users Here",
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => _clearSearch(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: context.read<UsersBloc>().users.length,
                  itemBuilder: (context, index) => AdminUserTile(
                    user: context.read<UsersBloc>().users.elementAt(index),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
    });
    _handleSearch();
  }

  void _handleSearch() {
    context
        .read<UsersBloc>()
        .add(GetUsers(query: _searchController.text.trim()));
  }
}

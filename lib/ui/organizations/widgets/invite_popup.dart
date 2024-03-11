// import 'package:flutter/material.dart';
//
// import '../../../api/services/users_service.dart';
// import '../../../models/organization_model.dart';
// import '../../../models/user_model.dart';
// import 'invite_user_tile.dart';
//
// class OrganizationInvitePopup extends StatefulWidget {
//   final Organization organization;
//
//   const OrganizationInvitePopup(this.organization, {super.key});
//
//   @override
//   State<OrganizationInvitePopup> createState() =>
//       _OrganizationInvitePopupState();
// }
//
// class _OrganizationInvitePopupState extends State<OrganizationInvitePopup> {
//   final TextEditingController searchController = TextEditingController();
//   List<User> users = [];
//
//   @override
//   void initState() {
//     super.initState();
//     getUsers();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       content: SizedBox(
//         height: MediaQuery.of(context).size.height * 0.75,
//         width: MediaQuery.of(context).size.width * 0.9,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Invite Users to ${widget.organization.name}:',
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//             TextFormField(
//               controller: searchController,
//               decoration: const InputDecoration(
//                 hintText: 'Search Users Here',
//                 labelText: 'Search',
//                 prefixIcon: Icon(Icons.search),
//               ),
//               textInputAction: TextInputAction.search,
//               onFieldSubmitted: (_) => getUsers(),
//             ),
//             Expanded(
//               child: buildUserList(),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('Done'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildUserList() {
//     if (users.isEmpty) {
//       return const Center(
//         child: Text('No users found.'),
//       );
//     } else {
//       return ListView.builder(
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           final User user = users[index];
//           return InviteUserTile(user, widget.organization.uniqueId);
//         },
//       );
//     }
//   }
//
//   Future<void> getUsers() async {
//     try {
//       final List<User> tempUsers = (await UsersService()
//               .searchUsers(query: searchController.text, page: 0))
//           .users;
//       setState(() {
//         users = tempUsers;
//       });
//     } catch (e) {
//       debugPrint('Error Searching Users: $e');
//     }
//   }
// }

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../api/services/users_service.dart';
// import '../../../bloc/auth/auth_bloc.dart';
// import '../../../models/user_model.dart';
// import '../../widgets/snackbar.dart';
// import 'other_profile_screen.dart';
//
// class UserTile extends StatefulWidget {
//   final User user;
//
//   const UserTile(this.user, {super.key});
//
//   @override
//   State<UserTile> createState() => _UserTileState();
// }
//
// class _UserTileState extends State<UserTile> {
//   late User user;
//   bool loading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     user = widget.user;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: user.uniqueId == context.read<AuthBloc>().user.uniqueId
//           ? null
//           : () async {
//               User? updatedUser = await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => OtherProfileScreen(user),
//                 ),
//               );
//               if (updatedUser != null) {
//                 setState(() {
//                   user = updatedUser;
//                 });
//               }
//             },
//       leading: ClipOval(
//         child: CachedNetworkImage(
//           imageUrl: user.imageUrl,
//           height: 32,
//           width: 32,
//           errorWidget: (_, __, ___) => const Icon(
//             Icons.account_circle,
//             size: 32,
//           ),
//         ),
//       ),
//       title: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             '${user.firstName} ${user.lastName}',
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(user.username),
//         ],
//       ),
//       trailing: user.uniqueId == context.read<AuthBloc>().user.uniqueId
//           ? null
//           : ElevatedButton(
//               child: loading
//                   ? const SizedBox(
//                       height: 12,
//                       width: 12,
//                       child: CircularProgressIndicator(),
//                     )
//                   : Text(
//                       user.followingStatus == null
//                           ? 'Follow'
//                           : user.followingStatus == 'following'
//                               ? 'Unfollow'
//                               : user.followingStatus == 'requested'
//                                   ? 'Requested'
//                                   : 'Follow',
//                     ),
//               onPressed: () async {
//                 if (!loading) {
//                   try {
//                     setState(() {
//                       loading = true;
//                     });
//                     if (user.followingStatus == 'requested') {
//                       await UsersService().cancelFollowRequest(user.uniqueId);
//                     } else {
//                       await UsersService().toggleFollow(
//                         userId: user.uniqueId,
//                         type: user.followingStatus == null ||
//                                 user.followingStatus == 'follow'
//                             ? 'follow'
//                             : 'unfollow',
//                       );
//                     }
//                     setState(() {
//                       String? newStatus;
//                       int followChange = 0;
//                       if (user.isPublic &&
//                           (user.followingStatus == null ||
//                               user.followingStatus == 'follow')) {
//                         newStatus = 'following';
//                         followChange = 1;
//                       } else if (!user.isPublic &&
//                           (user.followingStatus == null ||
//                               user.followingStatus == 'follow')) {
//                         newStatus = 'requested';
//                       } else {
//                         newStatus = 'follow';
//                         followChange = -1;
//                       }
//                       user = user.copyWith(
//                         followingStatus: newStatus,
//                         followersCount: user.followersCount + followChange,
//                       );
//                       context.read<AuthBloc>().add(RefreshUser());
//                     });
//                   } catch (e) {
//                     snackbar(context, 'Error on request: $e');
//                   }
//                   setState(() {
//                     loading = false;
//                   });
//                 }
//               },
//             ),
//     );
//   }
// }

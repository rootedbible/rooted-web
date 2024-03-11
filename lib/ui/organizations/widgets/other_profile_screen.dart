// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:rooted_web/ui/widgets/info_tile.dart';
//
// import '../../../api/services/users_service.dart';
// import '../../../models/user_model.dart';
// import '../../widgets/divider_line.dart';
// import '../../widgets/snackbar.dart';
//
//
// class OtherProfileScreen extends StatefulWidget {
//   final User user;
//
//   const OtherProfileScreen(this.user, {super.key});
//
//   @override
//   State<OtherProfileScreen> createState() => _OtherProfileScreenState();
// }
//
// class _OtherProfileScreenState extends State<OtherProfileScreen> {
//   late User user;
//   bool loading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     user = widget.user;
//     // if (user.isPublic || user.followStatus == 'following') {
//     //   context.read<ProfileBloc>().add(LoadProfile(user.uniqueId));
//     // }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//         return Scaffold(
//           appBar: AppBar(
//             leading: IconButton(
//               onPressed: () => Navigator.pop(context, user),
//               icon: const Icon(Icons.arrow_back_ios),
//             ),
//             backgroundColor: Theme.of(context).primaryColorLight,
//             centerTitle: false,
//             title: Text(
//               '@${user.username}',
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           body: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     ClipOval(
//                       child: CachedNetworkImage(
//                         imageUrl: user.imageUrl,
//                         width: 96,
//                         height: 96,
//                       ),
//                     ),
//                     Expanded(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               InfoTile(
//                                 '${user.percentageRecorded}%',
//                                 'Recorded',
//                               ),
//                               InfoTile(
//                                 user.followersCount.toString(),
//                                 user.followersCount == 1
//                                     ? 'Follower'
//                                     : 'Followers',
//                               ),
//                               InfoTile(
//                                 user.followingCount.toString(),
//                                 'Following',
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             width: double.infinity,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ElevatedButton(
//                                 onPressed: () async {
//                                   if (!loading) {
//                                     try {
//                                       setState(() {
//                                         loading = true;
//                                       });
//                                       await UsersService().toggleFollow(
//                                         userId: user.uniqueId,
//                                         type: user.followingStatus == null ||
//                                             user.followingStatus == 'follow'
//                                             ? 'follow'
//                                             : 'unfollow',
//                                       );
//                                       setState(() {
//                                         String? newStatus;
//                                         int followChange = 0;
//                                         if (user.isPublic &&
//                                             (user.followingStatus == null ||
//                                                 user.followingStatus ==
//                                                     'follow')) {
//                                           newStatus = 'following';
//                                           followChange = 1;
//                                         } else if (!user.isPublic &&
//                                             (user.followingStatus == null ||
//                                                 user.followingStatus ==
//                                                     'follow')) {
//                                           newStatus = 'requested';
//                                         } else {
//                                           followChange = -1;
//                                           newStatus = 'follow';
//                                         }
//                                         user = user.copyWith(
//                                           followingStatus: newStatus,
//                                           followersCount: user.followersCount +
//                                               followChange,
//                                         );
//                                       });
//                                     } catch (e) {
//                                       snackbar(context, 'Error on request: $e');
//                                     }
//                                     setState(() {
//                                       loading = false;
//                                     });
//                                   }
//                                 },
//                                 child: Text(
//                                   user.followingStatus == 'requested'
//                                       ? 'Requested'
//                                       : user.followingStatus == 'following'
//                                       ? 'Unfollow'
//                                       : 'Follow',
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   bottom: 16.0,
//                   right: 16.0,
//                   left: 16.0,
//                 ),
//                 child: Text(
//                   '${user.firstName} ${user.lastName}',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const DividerLine(),
//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   'Recently Recorded',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18.0,
//                   ),
//                 ),
//               ),
//               // TODO: Reimplement
//               // Expanded(
//               //   child: !user.isPublic && user.followStatus != 'following'
//               //       ? const Center(
//               //     child: Column(
//               //       mainAxisAlignment: MainAxisAlignment.center,
//               //       children: [
//               //         Icon(
//               //           Icons.lock,
//               //           size: 128,
//               //         ),
//               //         Padding(
//               //           padding: EdgeInsets.all(8.0),
//               //           child: Text(
//               //             'This is a Private Account, please request to follow them to listen to their recordings',
//               //             textAlign: TextAlign.center,
//               //             style: TextStyle(fontSize: 24.0),
//               //           ),
//               //         ),
//               //       ],
//               //     ),
//               //   )
//               //       : state is ProfileLoading
//               //       ? const Center(
//               //     child: CircularProgressIndicator(),
//               //   )
//               //       : context.read<ProfileBloc>().recentRecordings.isEmpty
//               //       ? const Center(
//               //     child: Text('No Recordings!'),
//               //   )
//               //       : ListView.builder(
//               //     itemCount: context
//               //         .read<ProfileBloc>()
//               //         .recentRecordings
//               //         .length,
//               //     itemBuilder: (context, index) {
//               //       final RecentRecording recentRecording =
//               //       context
//               //           .read<ProfileBloc>()
//               //           .recentRecordings[index];
//               //       return RecordedTile(
//               //         recentRecording,
//               //         user.username,
//               //       );
//               //     },
//               //   ),
//               // ),
//             ],
//           ),
//
//
//     );
//   }
// }

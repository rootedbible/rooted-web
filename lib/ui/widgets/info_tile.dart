// import 'package:flutter/material.dart';
//
// import '../../models/organization_model.dart';
// import '../organizations/widgets/organization_users_screen.dart';
//
// class InfoTile extends StatelessWidget {
//   final String info;
//   final Organization? organization;
//   final BuildContext? context;
//   final String description;
//
//   const InfoTile(
//       this.info,
//       this.description, {
//         super.key,
//         this.organization,
//         this.context,
//       });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: organization != null
//           ? () => Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => OrganizationUsersScreen(organization!),
//         ),
//       )
//           : null,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               info,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(description),
//           ],
//         ),
//       ),
//     );
//   }
// }

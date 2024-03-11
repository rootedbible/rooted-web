// import 'package:flutter/material.dart';
// import 'package:rooted_web/api/services/subscriptions_service.dart';
// import 'package:rooted_web/models/subscription_model.dart';
// import 'package:rooted_web/ui/widgets/error_dialog.dart';
// import 'package:universal_html/html.dart';
//
// import '../../../models/organization_model.dart';
//
// class ManageSubscriptionPopup extends StatelessWidget {
//   final Subscription subscription;
//   final Organization? organization;
//
//   const ManageSubscriptionPopup(
//     this.subscription,
//     this.organization, {
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       content: SizedBox(
//         width: 350,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Manage Subscription',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 "Subscription ${subscription.isCanceled ? 'Expires' : subscription.isActive ? "Renews" : "Expired"} ${subscription.expirationDateAsString}",
//               ),
//             ),
//             if (!subscription.isActive || subscription.isCanceled)
//               const Text(
//                 'If you renew the subscription before it expires, currently you will not get the remaining time as extra.',
//               ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('Done'),
//                 ),
//                 TextButton(
//                   onPressed: () async {
//                     if (!subscription.isActive || subscription.isCanceled) {
//                       final String url =
//                           await SubscriptionsService().renewSubscription(
//                         subscriptionId: subscription.id,
//                       );
//                       window.location.href = url;
//                     } else {
//                       showDialog(
//                         context: context,
//                         builder: (context) => AlertDialog(
//                           content: SizedBox(
//                             width: 350,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     'Cancel Subscription?',
//                                     style:
//                                         Theme.of(context).textTheme.titleLarge,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     'Your subscription will remain active until ${subscription.expirationDateAsString}',
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       TextButton(
//                                         onPressed: () => Navigator.pop(context),
//                                         child: const Text('Nevermind'),
//                                       ),
//                                       TextButton(
//                                         onPressed: () async {
//                                           await _handleCancel(
//                                             context,
//                                             organization,
//                                             subscription.id,
//                                           );
//                                         },
//                                         child: const Text(
//                                           'Cancel Subscription',
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                   child: Text(
//                     !subscription.isActive || subscription.isCanceled
//                         ? 'Renew Subscription'
//                         : 'Cancel Subscription',
//                     style: TextStyle(
//                       color: !subscription.isActive || subscription.isCanceled
//                           ? null
//                           : Theme.of(context).colorScheme.error,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _handleCancel(
//     BuildContext context,
//     Organization? organization,
//     int subscriptionId,
//   ) async {
//     try {
//       await SubscriptionsService().cancel(subscription.id);
//
//       Organization? newOrg = organization?.copyWith(
//         subscription: organization.subscription.copyWith(isCanceled: true),
//       );
//       Navigator.pop(context, newOrg);
//       Navigator.pop(context, newOrg);
//     } catch (e) {
//       errorDialog(e.toString(), context);
//     }
//   }
// }

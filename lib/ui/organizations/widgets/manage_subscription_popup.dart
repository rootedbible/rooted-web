import 'package:flutter/material.dart';
import 'package:rooted_web/api/services/subscriptions_service.dart';
import 'package:rooted_web/ui/widgets/error_dialog.dart';

import '../../../models/organization_model.dart';

class ManageSubscriptionPopup extends StatelessWidget {
  final Organization organization;

  const ManageSubscriptionPopup(this.organization, {super.key});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(organization.subscription.expiration);
    return AlertDialog(
      content: SizedBox(
        width: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Manage Subscription',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Subscription ${organization.subscription.isCanceled ? 'Expires' : organization.subscription.isActive ? "Renews" : "Expired"} ${dateTime.month}/${dateTime.day}/${dateTime.year}",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Done'),
                ),
                TextButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: SizedBox(
                        width: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Cancel Subscription?',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Your subscription will remain active until ${dateTime.month}/${dateTime.day}/${dateTime.year}',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Nevermind'),
                                  ),
                                  TextButton(
                                    onPressed: () async => await _handleCancel(
                                      context,
                                      organization,
                                    ),
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleCancel(
    BuildContext context,
    Organization organization,
  ) async {
    try {
      await SubscriptionsService().cancel(organization.subscription.id);
      Navigator.pop(context);
      Navigator.pop(context);
      // TODO: Update the stuff
    } catch (e) {
      errorDialog(e.toString(), context);
    }
  }
}

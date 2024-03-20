import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rooted_web/models/admin/referral_model.dart';
import 'package:rooted_web/utils/money_format.dart';

import '../../widgets/snackbar.dart';

class ReferralTile extends StatefulWidget {
  final Referral referral;

  const ReferralTile({required this.referral, super.key});

  @override
  State<ReferralTile> createState() => _ReferralTileState();
}

class _ReferralTileState extends State<ReferralTile> {
  late Referral referral;

  @override
  void initState() {
    super.initState();
    referral = widget.referral;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.church),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            referral.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.group_add),
              Text(': ${referral.totalUsers}'),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.attach_money),
              Text(
                ': \$${referral.generatedRevenue.toMoneyFormat()}',
              ),
            ],
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () async => await Clipboard.setData(
              ClipboardData(text: referral.code),
            ).then((value) => snackbar(context, 'Copied to clipboard!')),
            icon: const Icon(Icons.copy),
          ),
          Text(referral.code),
        ],
      ),
    );
  }
}

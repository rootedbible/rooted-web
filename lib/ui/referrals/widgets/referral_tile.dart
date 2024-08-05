import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:gap/gap.dart";
import "package:rooted_web/const.dart";
import "package:rooted_web/models/admin/referral_model.dart";
import "package:rooted_web/utils/money_format.dart";

import "../../widgets/snackbar.dart";

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
    return Padding(
      padding: const EdgeInsets.all(doublePadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  referral.type == referralUserType
                      ? Icons.person
                      : Icons.church,
                ),
                const Gap(8),
                Text(referral.meta),
              ],
            ),
          ),
          const Gap(doublePadding),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                inforRow(
                  title: "User Count",
                  value: referral.totalUsers.toString(),
                  icon: Icons.add_reaction_outlined,
                ),
                inforRow(
                  title: "Revenue",
                  value: referral.totalRevenue.toMoneyFormat(),
                  icon: Icons.attach_money,
                ),
              ],
            ),
          ),
          const Gap(doublePadding),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                inforRow(
                  title: "Start Date",
                  value: referral.startDate != null
                      ? referral.startDate!.toIso8601String()
                      : "N/A",
                  icon: Icons.date_range,
                ),
                inforRow(
                  title: "End Date",
                  value: referral.endDate != null
                      ? referral.endDate!.toIso8601String()
                      : "N/A",
                  icon: Icons.date_range,
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(" ${referral.code}"),
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: referral.code));
              snackbar(context, "Referral code copied to clipboard");
            },
          ),
        ],
      ),
    );
  }

  Widget inforRow({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(icon),
          Text(
            " $title: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}

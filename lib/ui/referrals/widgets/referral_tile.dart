import 'package:flutter/material.dart';
import 'package:rooted_web/models/admin/referral_model.dart';

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
    return const ListTile();
  }
}

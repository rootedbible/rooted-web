import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooted_web/ui/referrals/widgets/create_referral_dialog.dart';
import 'package:rooted_web/ui/referrals/widgets/referral_tile.dart';
import 'package:rooted_web/ui/widgets/loading_screen.dart';

import '../../bloc/admin/referral/referral_bloc.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  void _handleShowDialog() {
    showDialog(context: context, builder: (context) => const CreateReferralDialog());
  }

  void _handleRefresh() {
    context.read<ReferralBloc>().add(GetReferrals());
  }

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReferralBloc, ReferralState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ReferralsLoading) {
          return const LoadingScreen();
        }
        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => _handleRefresh(),
                      child: const Icon(Icons.refresh),
                    ),
                    const Text(
                      'Referrals',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _handleShowDialog(),
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: context.read<ReferralBloc>().referrals.length,
                  itemBuilder: (context, index) {
                    return ReferralTile(
                      referral: context
                          .read<ReferralBloc>()
                          .referrals
                          .elementAt(index),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

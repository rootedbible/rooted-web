import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/referral/referral_bloc.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {

  void _handleShowDialog() {

  }

  void _handleRefresh() {
    // TODO: get referrals
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
        return Scaffold(
          body: Column(
            children: [
               Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: ()=>_handleRefresh(), child: Icon(Icons.refresh)),
                    Text(
                      'Referrals',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    ElevatedButton(onPressed: ()=>_handleRefresh(), child: Icon(Icons.add)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

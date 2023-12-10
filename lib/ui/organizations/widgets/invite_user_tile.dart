import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/services/organizations_service.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../models/user_model.dart';
import '../../widgets/error_dialog.dart';
import '../../widgets/small_wheel.dart';
import 'other_profile_screen.dart';

class InviteUserTile extends StatefulWidget {
  final User user;
  final int orgId;

  const InviteUserTile(this.user, this.orgId, {super.key});

  @override
  State<InviteUserTile> createState() => _InviteUserTileState();
}

class _InviteUserTileState extends State<InviteUserTile> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  bool loading = false;
  bool invited = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: user.uniqueId == context.read<AuthBloc>().user.uniqueId
          ? null
          : () => _onUserTileTapped(),
      leading: ClipOval(
        child: CachedNetworkImage(
          imageUrl: user.imageUrl,
          height: 32,
          width: 32,
          errorWidget: (_, __, ___) => const Icon(
            Icons.account_circle,
            size: 32,
          ),
        ),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${user.firstName} ${user.lastName}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(user.username),
        ],
      ),
      trailing: TextButton(
        onPressed: loading ? null : () => _onInviteButtonPressed(),
        child: _buildInviteButtonContent(),
      ),
    );
  }

  void _onUserTileTapped() async {
    final updatedUser = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtherProfileScreen(user),
      ),
    );
    if (updatedUser != null) {
      setState(() {
        user = updatedUser;
      });
    }
  }

  void _onInviteButtonPressed() async {
    try {
      setState(() {
        loading = true;
      });
      await OrganizationsService().inviteUser(
        orgId: widget.orgId,
        userId: user.uniqueId,
      );
      setState(() {
        invited = true;
      });
    } catch (e) {
      errorDialog(e.toString(), context);
    }
    setState(() {
      loading = false;
    });
  }

  Widget _buildInviteButtonContent() {
    if (loading) {
      return const SmallWheel();
    } else {
      return Text(invited ? 'Invited' : 'Invite');
    }
  }
}

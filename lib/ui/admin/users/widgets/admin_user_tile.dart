import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rooted_web/api/services/admin_service.dart';
import 'package:rooted_web/ui/admin/reports/other_profile_screen.dart';
import 'package:rooted_web/ui/widgets/error_dialog.dart';
import 'package:rooted_web/ui/widgets/snackbar.dart';

import '../../../../models/user_model.dart';

class AdminUserTile extends StatefulWidget {
  final User user;

  const AdminUserTile({required this.user, super.key});

  @override
  State<AdminUserTile> createState() => _AdminUserTileState();
}

class _AdminUserTileState extends State<AdminUserTile> {
  late User user;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtherProfileScreen(
            user,
          ),
        ),
      ),
      leading: SizedBox(
        width: 32,
        height: 32,
        child: ClipOval(
          child: SizedBox(
            width: 32,
            height: 32,
            child: CachedNetworkImage(
              imageUrl: user.imageUrl,
              fit: BoxFit.cover,
              height: 32,
              width: 32,
            ),
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            user.username,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '${user.firstName} ${user.lastName}',
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (user.hasActiveSubscription)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.payments_rounded),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              tooltip:
                  '${user.enabled ? 'Disable' : 'Enable'} @${user.username}',
              onPressed: () => _handleToggleActive(),
              icon: Icon(user.enabled ? Icons.check : Icons.clear),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleToggleActive() async {
    if (!loading) {
      setState(() {
        loading = true;
      });
      try {
        await AdminService().toggleUserEnabled(
          enableUser: !user.enabled,
          userId: user.uniqueId,
        );
        setState(() {
          user = user.copyWith(enabled: !user.enabled);
          loading = false;
        });
        snackbar(context,
            '${user.username} ${user.enabled ? 'Enabled' : 'Disabled'}!',);
      } catch (e) {
        debugPrint('Error Switching User: $e');
        errorDialog(e.toString(), context);
      }
      setState(() {
        loading = false;
      });
    }
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rooted_web/api/services/admin_service.dart';
import 'package:rooted_web/ui/widgets/error_dialog.dart';

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
      leading: ClipOval(
        child: CachedNetworkImage(
          imageUrl: user.imageUrl,
          height: 64,
          width: 64,
        ),
      ),
      title: Column(
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
        children: [
          if (user.hasActiveSubscription) const Icon(Icons.payments_rounded),
          IconButton(
            onPressed: () => _handleToggleActive(),
            icon: Icon(user.enabled ? Icons.check : Icons.clear),
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
        });
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

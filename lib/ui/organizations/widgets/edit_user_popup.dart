import 'package:flutter/material.dart';

import '../../../api/services/organizations_service.dart';
import '../../../models/user_model.dart';
import '../../widgets/error_dialog.dart';

class EditUserPopup extends StatefulWidget {
  final int orgId;
  final User user;
  final String status;

  const EditUserPopup({super.key, 
    required this.orgId,
    required this.status,
    required this.user,
  });

  @override
  State<EditUserPopup> createState() => _EditUserPopupState();
}

class _EditUserPopupState extends State<EditUserPopup> {
  String _selectedRole = '';
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> roleTexts = {
      'remove':
          'This will remove ${widget.user.username} from the organization. You will need to re-invite them or accept a request for them to re-join',
      'member':
          'This will set ${widget.user.username} as a member, allowing them to record themselves and see other members',
      'moderator':
          'This will set ${widget.user.username} as a moderator, giving them the ability to accept or deny join requests',
      'admin':
          'This will give ${widget.user.username} admin privileges: removing users and editing their permissions and the organization info',
    };

    return AlertDialog(
      content: _buildDialogContent(roleTexts),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            if (!loading) {
              try {
                // if (_selectedRole == 'remove') {
                //   await OrganizationsService().removeUserFromOrganization(
                //     organizationId: widget.orgId,
                //     userId: widget.user.uniqueId,
                //   );
                // } else {
                //   await OrganizationsService().changeOrganizationUserStatus(
                //     organizationId: widget.orgId,
                //     userId: widget.user.uniqueId,
                //     status: _selectedRole,
                //   );
                // }
                Navigator.pop(context, _selectedRole);
                setState(() {
                  loading = false;
                });
              } catch (e) {
                setState(() {
                  loading = false;
                });
                errorDialog(e.toString(), context);
              }
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  Widget _buildDialogContent(Map<String, String> roleTexts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Edit ${widget.user.username}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
        ),
        _buildRoleSelectionButtons(),
        const SizedBox(height: 20),
        Text(
          roleTexts[_selectedRole]!,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRoleSelectionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildRoleIconButton('remove', Icons.delete),
        _buildRoleIconButton('member', Icons.account_circle),
        _buildRoleIconButton('moderator', Icons.remove_red_eye),
        _buildRoleIconButton('admin', Icons.admin_panel_settings),
      ],
    );
  }

  Widget _buildRoleIconButton(String role, IconData iconData) {
    return IconButton(
      onPressed: () => setState(() {
        _selectedRole = role;
      }),
      icon: Icon(
        iconData,
        color: _selectedRole == role
            ? Theme.of(context).colorScheme.primary
            : null,
      ),
    );
  }
}

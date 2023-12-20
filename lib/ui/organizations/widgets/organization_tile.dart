import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rooted_web/const.dart';

import '../../../models/organization_model.dart';
import '../organization_screen.dart';

class OrganizationTile extends StatefulWidget {
  final Organization organization;

  const OrganizationTile(this.organization, {super.key});

  @override
  State<OrganizationTile> createState() => _OrganizationTileState();
}

class _OrganizationTileState extends State<OrganizationTile> {
  late Organization organization;

  @override
  void initState() {
    super.initState();
    organization = widget.organization;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrganizationScreen(organization),
          ),
        ),
        leading: SizedBox(
          height: 64,
          width: 64,
          child: ClipOval(
            child: organization.profileUrl == null ? const Icon(Icons.account_circle, size: 64,): CachedNetworkImage(
              imageUrl: organization.profileUrl!,
              imageBuilder: (context, imageProvider) => Container(
                width: 64.0,
                height: 64.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),

            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              organization.name,
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icons based on organization status
            if (organization.status == 'admin')
              const Icon(Icons.admin_panel_settings),
            if (organization.status == 'moderator')
              const Icon(Icons.visibility),
            if (organization.status == 'member')
              const Icon(Icons.account_circle),
            if (organization.status == 'invited') const Icon(Icons.mail),
            if (organization.status == 'requested') const Icon(Icons.add),

            // Icon based on organization type
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                organization.type == familyType
                    ? Icons.family_restroom
                    : organization.type == coupleType
                        ? Icons.group
                        : Icons.church,
              ),
            ),
            if (organization.subscription.isActive)
              const Icon(
                Icons.check,
                color: Colors.green,
              ),
            if (!organization.subscription.isActive)
              const Icon(
                Icons.clear,
                color: Colors.red,
              ),
          ],
        ),
      ),
    );
  }
}

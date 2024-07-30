import "package:flutter/material.dart";
import "../../../../const.dart";
import "../../../../models/user_model.dart";

class OtherFollowTile extends StatelessWidget {
  const OtherFollowTile({
    super.key,
    required this.user,
    required this.type,
    required this.count,
  });

  final User user;
  final String type;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: GestureDetector(
          child: Container(
            width: 144,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              color: Theme.of(context).colorScheme.primary,
              // box shadow
              boxShadow: const [
                // BoxShadow(
                //   color: Theme.of(context).colorScheme.primary.withOpacity(0.75),
                //   blurRadius: 15,
                //   offset: const Offset(5, 5),
                // ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "$count ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Text(
                  type,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

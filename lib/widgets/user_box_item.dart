import 'package:flutter/material.dart';
import '/constants/constants.dart';

class UserBoxItem extends StatelessWidget {
  const UserBoxItem({
    super.key,
    required this.name,
    required this.child,
  });
  final String name;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
    
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(width: 1,color: primaryColor),
            borderRadius: BorderRadius.circular(8), color: Theme.of(context).colorScheme.onBackground),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
            child
          ],
        ));
  }
}

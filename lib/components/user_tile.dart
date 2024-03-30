import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.username,
    required this.message,
    required this.onTap,
  });

  final String username;
  final String message;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.background,
            ),
            child: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.onBackground,
              size: 30,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                username,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.background,
                    ),
              ),
            ],
          ),
          subtitle: Text(
            message,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
    required this.onPressed
  });
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      onPressed: onPressed,
        child: Row(
      children: [
        const Icon(Icons.logout),
        Text(
          "Logout",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(
          width: 50,
        )
      ],
    ));
  }
}

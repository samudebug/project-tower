import 'package:flutter/material.dart';
import 'package:tower_project/ui/widgets/logout_button.dart';
import 'package:tower_project/ui/widgets/user_card.dart';

class UserMenu extends StatelessWidget {
  const UserMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: [UserCard(), LogoutButton()],
      builder: (context, controller, child) {
        return TextButton(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            child: Icon(
              Icons.person,
              color: Theme.of(context).iconTheme.color,
            ));
      },
    );
  }
}

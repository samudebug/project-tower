import 'package:flutter/material.dart';
import 'package:tower_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:tower_project/setup.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      onPressed: () {
        getIt<AuthBloc>().add(AuthLogout());
      },
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

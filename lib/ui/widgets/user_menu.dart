import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tower_project/setup.dart';
import 'package:tower_project/ui/widgets/logout_button.dart';
import 'package:tower_project/ui/widgets/profile_info/cubit/profile_info_cubit.dart';
import 'package:tower_project/ui/widgets/profile_info/profile_info.dart';
import 'package:tower_project/ui/widgets/user_card.dart';

class UserMenu extends StatelessWidget {
  const UserMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: [
        InkWell(
            onTap: () {
              final cubit = getIt<ProfileInfoCubit>();
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                cubit.saveUser();
                                Navigator.of(context).pop();
                              }, child: Text("Salvar"))
                        ],
                        content: BlocProvider(
                          create: (context) => cubit,
                          child: ProfileInfo(),
                        ),
                      ));
            },
            child: UserCard()),
        LogoutButton()
      ],
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

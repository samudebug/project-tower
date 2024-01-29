import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tower_project/ui/pages/login/cubit/login_cubit.dart';
import 'package:tower_project/ui/pages/login/cubit/login_state.dart';
import 'package:tower_project/ui/pages/signup/signup_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final GlobalKey<FormState> formKey = GlobalKey();
  static const pageName = "login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextFormField(
                        controller: context.read<LoginCubit>().emailController,
                        validator: (value) {
                          if (value != null) {
                            if (RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return null;
                            }
                          }
                          return "Verifique o email";
                        },
                        decoration: const InputDecoration(hintText: "Email"),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextFormField(
                        controller: context.read<LoginCubit>().passwordController,
                        validator: (value) {
                          if (value != null) {
                            if (value.length < 6) {
                              return "É necessário uma senha mais longa";
                            }
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: "Senha"),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          final isFormValid = formKey.currentState?.validate();
                          if (isFormValid != null) {
                            if (isFormValid) {
                              log("Valid form");
                              context.read<LoginCubit>().login();
                            }
                          }
                        },
                        child: Text(
                          "Login",
                          style: Theme.of(context).textTheme.labelLarge,
                        )),
                  ),
                  Padding(padding: const EdgeInsets.all(8.0), child: TextButton(child: Text("Cadastre-se"), onPressed: () {
                    Navigator.of(context).pushNamed(SignupPage.pageName);
                  },),)
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

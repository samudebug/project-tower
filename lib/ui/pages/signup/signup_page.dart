import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tower_project/ui/pages/signup/cubit/signup_cubit.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final GlobalKey<FormState> formKey = GlobalKey();
  static const pageName = "signup";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )),
      body: BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
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
                  "Cadastro",
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(
                    controller: context.read<SignupCubit>().emailController,
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
                    controller:
                        context.read<SignupCubit>().passwordController,
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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(
                    controller:
                        context.read<SignupCubit>().confirmPasswordController,
                    validator: (value) {
                      if (value != null) {
                        if (value.length < 6) {
                          return "É necessário uma senha mais longa";
                        }
                        if (value !=
                            context
                                .read<SignupCubit>()
                                .passwordController
                                .text) {
                          return "As senhas não coincidem";
                        }
                      }
                      return null;
                    },
                    decoration:
                        const InputDecoration(hintText: "Confirme a senha"),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      log("Is being pressed");
                      final isFormValid = formKey.currentState?.validate();
                      if (isFormValid != null) {
                        if (isFormValid) {
                          log("Valid form");
                          context.read<SignupCubit>().signup();
                        }
                      }
                    },
                    child: Text(
                      "Cadastrar",
                      style: Theme.of(context).textTheme.labelLarge,
                    )),
              ),
              if (state.errorMessage != null)
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      state.errorMessage ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: Colors.red),
                    ))
            ],
          )),
        );
      }),
    );
  }
}

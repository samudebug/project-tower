import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_repository/projects_repository.dart';
import 'package:tasks_repository/tasks_repository.dart';
import 'package:tower_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:tower_project/blocs/projects_bloc/projects_bloc.dart';
import 'package:tower_project/setup.dart';
import 'package:tower_project/ui/pages/login/cubit/login_cubit.dart';
import 'package:tower_project/ui/pages/login/login_page.dart';
import 'package:tower_project/ui/pages/project_detail/cubit/project_detail_cubit.dart';
import 'package:tower_project/ui/pages/project_detail/project_detail_page.dart';
import 'package:tower_project/ui/pages/project_form/cubit/project_form_cubit.dart';
import 'package:tower_project/ui/pages/project_form/edit_project_form_page.dart';
import 'package:tower_project/ui/pages/project_form/project_form_page.dart';
import 'package:tower_project/ui/pages/projects/projects_page.dart';
import 'package:tower_project/ui/pages/signup/cubit/signup_cubit.dart';
import 'package:tower_project/ui/pages/signup/signup_page.dart';
import 'package:tower_project/ui/pages/task_detail/cubit/messages_cubit.dart';
import 'package:tower_project/ui/pages/task_detail/cubit/task_detail_cubit.dart';
import 'package:tower_project/ui/pages/task_detail/task_detail_page.dart';

Route<dynamic> onUnknownRoute(RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) {
      log('Unknown route');
      return Scaffold(
        body: Center(
          child: Text(
            "Rota desconhecida",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      );
    },
  );
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginPage.pageName:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => getIt<LoginCubit>(),
                child: LoginPage(),
              ));
    case SignupPage.pageName:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => getIt<SignupCubit>(),
                child: SignupPage(),
              ));
    case ProjectsPage.pageName:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => getIt<ProjectsBloc>()
                  ..add(LoadProjects(
                      userEmail: (getIt<AuthBloc>().state as AuthLogged)
                          .userModel
                          .email)),
                child: ProjectsPage(),
              ));
    case ProjectDetailsPage.pageName:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => getIt<ProjectDetailCubit>()..init((settings.arguments as Project).id!),
                child: ProjectDetailsPage(
                  project: settings.arguments as Project,
                ),
              ));
    case ProjectFormPage.pageName:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => getIt<ProjectFormCubit>(),
                child: ProjectFormPage(),
              ));
    case EditProjectFormPage.pageName:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) =>
              getIt<ProjectFormCubit>()..init(settings.arguments as Project),
          child: EditProjectFormPage(),
        ),
      );
    case TaskDetailPage.pageName:
      return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(providers: [
                BlocProvider(
                    create: (context) => getIt<TaskDetailCubit>()
                      ..init(
                          ((settings.arguments
                              as Map<String, dynamic>)['project'] as Project),
                          (settings.arguments
                              as Map<String, dynamic>)['task'])),
                BlocProvider(
                    create: (context) => getIt<MessagesCubit>()
                      ..init(
                          ((settings.arguments
                                      as Map<String, dynamic>)['project']
                                  as Project)
                              .id!,
                          ((settings.arguments as Map<String, dynamic>)['task']
                                  as Task)
                              .id!))
              ], child: TaskDetailPage()));
    default:
      return MaterialPageRoute(
          builder: (context) => Center(
                child: Text("Rota desconhecida"),
              ));
  }
}

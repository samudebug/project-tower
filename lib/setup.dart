import 'package:auth_repository/auth_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:messages_repository/messages_repository.dart';
import 'package:projects_repository/projects_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:tasks_repository/tasks_repository.dart';
import 'package:tower_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:tower_project/blocs/projects_bloc/projects_bloc.dart';
import 'package:tower_project/firebase_options.dart';
import 'package:tower_project/ui/pages/login/cubit/login_cubit.dart';
import 'package:tower_project/ui/pages/project_detail/cubit/project_detail_cubit.dart';
import 'package:tower_project/ui/pages/project_form/cubit/project_form_cubit.dart';
import 'package:tower_project/ui/pages/signup/cubit/signup_cubit.dart';
import 'package:tower_project/ui/pages/task_detail/cubit/messages_cubit.dart';
import 'package:tower_project/ui/pages/task_detail/cubit/task_detail_cubit.dart';
import 'package:tower_project/ui/widgets/profile_info/cubit/profile_info_cubit.dart';

GetIt get getIt => G;

@protected
GetIt G = GetIt.instance;

abstract class Setup {
  static Future<void> init() async { 
    await initFirebase();
    Future.wait([
      initRepositories(),
      initBlocs(),
      initCubits()
    ]);
  }

  @protected
  @visibleForTesting
  static Future<void> initRepositories() async {
    getIt.registerSingleton<ProjectsRepository>(ProjectsRepository());
    getIt.registerSingleton<StorageRepository>(StorageRepository());
    getIt.registerSingleton<TaskRepository>(TaskRepository());
    getIt.registerSingleton<AuthRepository>(AuthRepository());
    getIt.registerSingleton<MessagesRepository>(MessagesRepository());
  }

  @protected
  @visibleForTesting
  static Future<void> initBlocs() async {
    getIt.registerSingleton<ProjectsBloc>(ProjectsBloc(projectsRepository: getIt()));
    getIt.registerSingleton<AuthBloc>(AuthBloc(authRepository: getIt()));
  }

  @protected
  @visibleForTesting
  static Future<void> initCubits() async {
    getIt.registerFactory<LoginCubit>(() => LoginCubit(authBloc: getIt()));
    getIt.registerFactory<ProjectDetailCubit>(() => ProjectDetailCubit(taskRepository: getIt()));
    getIt.registerFactory<ProjectFormCubit>(() => ProjectFormCubit(projectsBloc: getIt(), storageRepository: getIt(), projectsRepository: getIt()));
    getIt.registerFactory<SignupCubit>(() => SignupCubit(authRepository: getIt(), authBloc: getIt()));
    getIt.registerFactory<TaskDetailCubit>(() => TaskDetailCubit(taskRepository: getIt(), projectsRepository: getIt()));
    getIt.registerFactory<MessagesCubit>(() => MessagesCubit(messagesRepository: getIt()));
    getIt.registerFactory<ProfileInfoCubit>(() => ProfileInfoCubit());
  }

  @protected
  @visibleForTesting
  static Future<void> initFirebase() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  }
}
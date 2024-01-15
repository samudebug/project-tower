part of 'project_detail_cubit.dart';

abstract class ProjectDetailState {}

class ProjectDetailInitial extends ProjectDetailState {}

class ProjectDetailLoading extends ProjectDetailState {}

class ProjectDetailReady extends ProjectDetailState {
  ProjectDetailReady({required this.tasks});
  List<Task> tasks;
}
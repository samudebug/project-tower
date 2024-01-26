import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messages_repository/messages_repository.dart';
import 'package:tower_project/ui/pages/task_detail/cubit/messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit({required this.messagesRepository}) : super(MessagesState(messages: [], projectId: "", taskId: ""));
  MessagesRepository messagesRepository;
  TextEditingController messageController = TextEditingController();
  init(String projectId, String taskId) async {
    final messages = await messagesRepository.fetchMessages(projectId, taskId);
    log("Messages ${messages.length}");
    emit(state.copyWith(messages: messages, projectId: projectId, taskId: taskId));
  }

  saveMessage(Message message) async {
    await messagesRepository.saveMessage(state.projectId, state.taskId, message);
    init(state.projectId, state.taskId);
  }


}
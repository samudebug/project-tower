import 'package:messages_repository/messages_repository.dart';

class MessagesState {
  List<Message> messages;
  String projectId;
  String taskId;
  MessagesState({required this.messages, required this.projectId, required this.taskId});

  MessagesState copyWith({List<Message>? messages, String? projectId, String? taskId}) {
    return MessagesState(messages: messages ?? this.messages, projectId: projectId ?? this.projectId, taskId: taskId ?? this.taskId);
  }
}
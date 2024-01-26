import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messages_repository/src/models/message.dart';

class MessagesRepository {
  Future<List<Message>> fetchMessages(String projectId, String taskId,
      {String? afterId}) async {
    try {
      final query = FirebaseFirestore.instance
          .collection("projects")
          .doc(projectId)
          .collection("tasks")
          .doc(taskId)
          .collection("messages")
          .orderBy("createdAt", descending: true);
      if (afterId != null) {
        final afterSnapshot = await FirebaseFirestore.instance
            .collection("projects")
            .doc(projectId)
            .collection("tasks")
            .doc(taskId)
            .collection("messages")
            .doc(afterId)
            .get();
        query.startAfterDocument(afterSnapshot);
      }
      final result = await query.get();
      return result.docs.map((e) {
        final docData = e.data();
        return Message.fromJson({'id': e.id, ...docData});
      }).toList();
    } catch (e) {
      log("Error while fetching messages", error: e);
      rethrow;
    }
  }

  Future<void> saveMessage(
      String projectId, String taskId, Message message) async {
    try {
      await FirebaseFirestore.instance
          .collection("projects")
          .doc(projectId)
          .collection("tasks")
          .doc(taskId)
          .collection("messages")
          .add(message.toJson());
    } catch (e) {
      log("Error while saving a message", error: e);
      rethrow;
    }
  }
}

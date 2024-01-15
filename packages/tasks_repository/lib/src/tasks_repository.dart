import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks_repository/tasks_repository.dart';

class TaskRepository {
  Future<List<Task>> getTasks(String projectId) async {
    try {
      final CollectionReference<Task> collectionRef = FirebaseFirestore.instance
          .collection("projects")
          .doc(projectId)
          .collection("tasks")
          .withConverter(
              fromFirestore: Task.fromFirestore,
              toFirestore: (Task task, _) => task.toFirestore());
      final result = await collectionRef.orderBy("createdAt", descending: true).get();
      return result.docs.map((e) => e.data()).toList();
    } catch (e) {
      log("Error while fetching tasks", error: e);
      throw e;
    }
  }

  Future<Task> saveTask(String projectId,Task task) async {
    try {
      final CollectionReference<Task> collectionRef = FirebaseFirestore.instance
          .collection("projects")
          .doc(projectId)
          .collection("tasks")
          .withConverter(
              fromFirestore: Task.fromFirestore,
              toFirestore: (Task task, _) => task.toFirestore());
      final result = await collectionRef.add(task);
      return task.copyWith(id: result.id);
    } catch (e) {
      log("Error while saving tasks", error: e);
      throw e;
    }
  }

  Future<Task> updateTask(String projectId, Task task) async {
    try {
            final DocumentReference<Task> documentReference = FirebaseFirestore.instance
          .collection("projects")
          .doc(projectId)
          .collection("tasks")
          .doc(task.id!)
          .withConverter(
              fromFirestore: Task.fromFirestore,
              toFirestore: (Task task, _) => task.toFirestore());
        await documentReference.set(task, SetOptions(merge: true));
      return task;
    } catch (e) {
      log("Error while updating tasks", error: e);
      throw e;
    }
  }
}

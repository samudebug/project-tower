import 'package:flutter/widgets.dart';
import 'package:tasks_repository/tasks_repository.dart';
import 'package:tower_project/ui/widgets/status_chip.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});
  final Task task;
  @override
  Widget build(BuildContext context) {
    return  Row(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TaskStatusChip(status: task.status,),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Flexible(child: Text(task.name)),
      )
    ],);
  }
}
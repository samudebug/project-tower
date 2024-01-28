import 'package:flutter/material.dart';
import 'package:tasks_repository/tasks_repository.dart';

class TaskStatusChip extends StatelessWidget {
  const TaskStatusChip({super.key, required this.status});
  final TaskStatus status;

  Color get color {
    switch (status) {
      case TaskStatus.OPEN:
        return const Color(0xFF552EC5);
      case TaskStatus.WORKING:
        return Color.fromARGB(255, 255, 0, 179);
      case TaskStatus.AWAITING_REVIEW:
        return const Color(0xFFAF2EC5);
      case TaskStatus.IN_REVIEW:
        return const Color(0xFFC5A32E);
      case TaskStatus.APPROVED:
        return const Color(0xFF2EC54F);
      default:
        return const Color(0xFFC52E2E);
    }
  }

  IconData get icon {
    switch (status) {
      case TaskStatus.OPEN:
        return Icons.file_copy;
      case TaskStatus.WORKING:
        return Icons.edit;
      case TaskStatus.AWAITING_REVIEW:
        return Icons.access_time;
      case TaskStatus.IN_REVIEW:
        return Icons.remove_red_eye;
      case TaskStatus.APPROVED:
        return Icons.check;
      default:
        return Icons.clear;
    }
  }

  String get text {
    switch (status) {
      case TaskStatus.OPEN:
        return "Aberta";
      case TaskStatus.WORKING:
        return "Traduzindo";
      case TaskStatus.AWAITING_REVIEW:
        return "Aguardando Revisão";
      case TaskStatus.IN_REVIEW:
        return "Em Revisão";
      case TaskStatus.APPROVED:
        return "Aprovada";
      default:
        return "Fechada";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: color),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(icon),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              text,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          )
        ]),
      ),
    );
  }
}

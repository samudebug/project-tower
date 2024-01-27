import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messages_repository/messages_repository.dart';

class TaskMessage extends StatelessWidget {
  const TaskMessage({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleAvatar(
          backgroundColor: Colors.green,
          backgroundImage: message.avatarUrl.isNotEmpty ? NetworkImage(message.avatarUrl) : null,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(message.userId,
                      style: Theme.of(context).textTheme.labelLarge),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(DateFormat("dd/mm/yyyy HH:MM").format(message.createdAt),
                      style: Theme.of(context).textTheme.labelLarge),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(message.message, maxLines: 3, textAlign: TextAlign.start,),
            )
          ],
        )
      ]),
    );
  }
}

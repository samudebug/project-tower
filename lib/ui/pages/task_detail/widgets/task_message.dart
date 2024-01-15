import 'package:flutter/material.dart';

class TaskMessage extends StatelessWidget {
  const TaskMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const CircleAvatar(
          backgroundColor: Colors.green,
        ),
        Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text("GunsBlazin",
                      style: Theme.of(context).textTheme.labelLarge),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text("Ontem, 16:58",
                      style: Theme.of(context).textTheme.labelLarge),
                )
              ],
            ),
            const Flexible(child: Text("Esta é uma mensagem", maxLines: 3,))
          ],
        )
      ]),
    );
  }
}

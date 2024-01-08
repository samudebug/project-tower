import 'package:flutter/material.dart';

class NameImageForm extends StatelessWidget {
  const NameImageForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              child: Column(
            children: [
              Text(
                "Dê um nome ao projeto",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(decoration: InputDecoration(hintText: "Nome do Projeto")),
              ),
              Spacer()
            ],
          )),
          Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                            width: 300,
                            height: 600,
                            decoration: BoxDecoration(color: Colors.grey[400]),
                            child: Center(child: Text("Escolher Imagem")),
                          ),
              ))
        ],
      ),
    );
  }
}

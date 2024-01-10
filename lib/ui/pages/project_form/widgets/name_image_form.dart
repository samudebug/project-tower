import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tower_project/ui/pages/project_form/cubit/project_form_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                child: TextField(controller: context.read<ProjectFormCubit>().nameController,decoration: InputDecoration(hintText: "Nome do Projeto")),
              ),
              Spacer()
            ],
          )),
          Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
                    if (result != null) {
                      print(result.files.single.path);
                      context.read<ProjectFormCubit>().file = File(result.files.single.path!);
                    }
                  },
                  child: context.read<ProjectFormCubit>().file == null ? Container(
                              width: 300,
                              height: 600,
                              decoration: BoxDecoration(color: Colors.grey[400]),
                              child: Center(child: Text("Escolher Imagem")),
                            ) : Image.file(context.read<ProjectFormCubit>().file!),
                ),
              ))
        ],
      ),
    );
  }
}

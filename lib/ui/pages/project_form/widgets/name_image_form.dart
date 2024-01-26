import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tower_project/ui/pages/project_form/cubit/project_form_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameImageForm extends StatelessWidget {
  const NameImageForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectFormCubit, ProjectFormState>(
        builder: (context, state) {
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
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      controller:
                          context.read<ProjectFormCubit>().nameController,
                      decoration:
                          const InputDecoration(hintText: "Nome do Projeto")),
                ),
                const Spacer()
              ],
            )),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(type: FileType.image);
                  if (result != null) {
                    print(result.files.single.path);
                    context
                        .read<ProjectFormCubit>()
                        .setImage(File(result.files.single.path!));
                  }
                },
                child: state.file != null
                    ? Image.file(
                        state.file!,
                        fit: BoxFit.cover,
                        width: 300,
                        height: 600,
                      )
                    : state.imageUrl != null
                        ? Image.network(
                            state.imageUrl!,
                            fit: BoxFit.cover,
                            width: 300,
                            height: 600,
                          )
                        : Container(
                            width: 300,
                            height: 600,
                            decoration: BoxDecoration(color: Colors.grey[400]),
                            child: const Center(child: Text("Escolher Imagem")),
                          ),
              ),
            ))
          ],
        ),
      );
    });
  }
}

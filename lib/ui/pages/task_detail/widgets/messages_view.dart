import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messages_repository/messages_repository.dart';
import 'package:tower_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:tower_project/setup.dart';
import 'package:tower_project/ui/pages/task_detail/cubit/messages_cubit.dart';
import 'package:tower_project/ui/pages/task_detail/cubit/messages_state.dart';
import 'package:tower_project/ui/pages/task_detail/widgets/task_message.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesCubit, MessagesState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TextField(
            controller: context.read<MessagesCubit>().messageController,
            maxLines: 3,
            onSubmitted: (value) {
              context.read<MessagesCubit>().messageController.clear();
              final message = Message(
                  userId:
                      (getIt<AuthBloc>().state as AuthLogged).userModel.email,
                  avatarUrl: (getIt<AuthBloc>().state as AuthLogged)
                      .userModel
                      .avatarUrl,
                  message: value,
                  attachment: "",
                  createdAt: DateTime.now());
              context.read<MessagesCubit>().saveMessage(message);
            },
            textInputAction: TextInputAction.send,
            decoration:
                const InputDecoration(hintText: "Digite uma mensagem..."),
          ),
          if (state.messages.isNotEmpty)
            Expanded(
              child: ListView.builder(
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: TaskMessage(
                          message: state.messages[index],
                        ),
                      )),
            )
          else
            const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Nenhuma mensagem enviada"),
              ),
            )
        ]),
      );
    });
  }
}

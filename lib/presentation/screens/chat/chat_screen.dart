import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/he_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_fiel_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          //en el modo chill crea un circulo para la foto anexando mi url de mi logo
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://yt3.googleusercontent.com/d29xcBvwgLO_cKa6G-m5kEEywQiEwsRwOylZsyxn591QdLHs9REcFvFZ2hoWXy7-9qZJzPbsKIU=s900-c-k-c0x00ffffff-no-rj'),
          ),
        ),
        title: const Text('Yeak8'),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          Expanded(
              child: ListView.builder(
                  controller: chatProvider.chatScrollController,
                  itemCount: chatProvider.messageList.length,
                  itemBuilder: (context, index) {
                    final message = chatProvider.messageList[index];

                    return (message.fromWho == FromWho.hers)
                        ? HerMessageBubble(message: message)
                        : MyMessageBubble(message: message);
                  })),

          // Caja de Texto de mensajes
          MessageFieldBox(
            // onValue: (value) => chatProvider.sendMessage(value),
            onValue: chatProvider.sendMessage,
          ),
        ]),
      ),
    );
  }
}

import 'package:chat_app/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/chat_model.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
      ),
      child: Consumer<ChatController>(builder: (context, provider, _) {
        return SizedBox(
          height: 736,
          width: double.infinity,
          child: ListView.builder(
            itemBuilder: (context, index) {
              Chat tempChat = provider.getChatsList[index];

              return Card(
                child: ListTile(
                  title: Text(
                    "${tempChat.name}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text("${tempChat.chat}"),
                  leading: const CircleAvatar(
                    radius: 30,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("${tempChat.date}"),
                      Text("${tempChat.time}"),
                    ],
                  ),
                ),
              );
            },
            itemCount: provider.getChatsList.length,
          ),
        );
      }),
    );
  }
}

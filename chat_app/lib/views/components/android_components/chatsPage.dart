import 'dart:io';

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
        top: 2,
        left: 12,
        right: 12,
      ),
      child: Consumer<ChatController>(builder: (context, provider, _) {
        return SizedBox(
          height: 746,
          width: double.infinity,
          child: ListView.builder(
            itemBuilder: (context, index) {
              Chat tempChat = provider.getChatsDataList[index];

              return Card(
                child: ListTile(
                  title: Text(
                    "${tempChat.name}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text("${tempChat.chat}"),
                  leading: CircleAvatar(
                    radius: 30,
                    foregroundImage: (tempChat.image != null)
                        ? FileImage(File(tempChat.image))
                        : null,
                    child: Text(
                      "${tempChat.name?[0].toUpperCase()}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("${tempChat.date}"),
                      Text("${tempChat.time}"),
                    ],
                  ),
                ),
              );
            },
            itemCount: provider.getChatsDataList.length,
          ),
        );
      }),
    );
  }
}

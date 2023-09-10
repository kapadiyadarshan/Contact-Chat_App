import 'dart:io';

import 'package:chat_app/controller/chat_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/chat_model.dart';

class iOScallsPage extends StatelessWidget {
  const iOScallsPage({super.key});

  call({required String phoneNum}) async {
    Uri callUri = Uri(
      scheme: "tel",
      path: phoneNum,
    );

    await launchUrl(callUri);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 12,
        top: 12,
      ),
      child: Consumer<ChatController>(builder: (context, provider, _) {
        return ListView.separated(
          itemBuilder: (context, index) {
            Chat tempChat = provider.getChatsDataList[index];

            return CupertinoListTile(
              padding: const EdgeInsets.all(0),
              leadingSize: 50,
              leading: CircleAvatar(
                radius: 30,
                foregroundImage: (tempChat.image != null)
                    ? FileImage(File(tempChat.image))
                    : null,
              ),
              title: Text(
                "${tempChat.name}",
              ),
              subtitle: Text("${tempChat.phoneNumber}"),
              trailing: IconButton(
                onPressed: () {
                  call(phoneNum: tempChat.phoneNumber!);
                },
                icon: const Icon(
                  CupertinoIcons.phone_fill,
                  size: 28,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(
            thickness: 0.3,
          ),
          itemCount: provider.getChatsDataList.length,
        );
      }),
    );
  }
}

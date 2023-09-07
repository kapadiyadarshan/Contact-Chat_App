import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/chat_controller.dart';
import '../../../model/chat_model.dart';

class iOSchatsPage extends StatelessWidget {
  const iOSchatsPage({super.key});

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

            return GestureDetector(
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      title: const SizedBox(),
                      message: Column(
                        children: [
                          CircleAvatar(
                            radius: 80,
                            foregroundImage: FileImage(
                              File(tempChat.image),
                            ),
                            child: Text(
                              "${tempChat.name?[0].toUpperCase()}",
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            "${tempChat.name}",
                            style: const TextStyle(
                              fontSize: 28,
                              // fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "${tempChat.phoneNumber}",
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            "${tempChat.chat}",
                          ),
                        ],
                      ),
                      actions: [
                        CupertinoActionSheetAction(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: Text("Edit"),
                                  actions: [
                                    CupertinoButton(
                                      child: Text("Done"),
                                      onPressed: () {},
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          isDefaultAction: true,
                          child: const Text("Edit"),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () {},
                        isDestructiveAction: true,
                        child: Text("Delete"),
                      ),
                    );
                  },
                );
              },
              child: CupertinoListTile(
                padding: const EdgeInsets.all(0),
                leadingSize: 50,
                leading: CircleAvatar(
                  radius: 30,
                  foregroundImage: (tempChat.image != null)
                      ? FileImage(File(tempChat.image))
                      : null,
                ),
                title: Text("${tempChat.name}"),
                subtitle: Text("${tempChat.chat}"),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${tempChat.date}",
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      "${tempChat.time}",
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: provider.getChatsDataList.length,
        );
      }),
    );
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/chat_controller.dart';
import '../../../model/chat_model.dart';

class iOSchatsPage extends StatelessWidget {
  iOSchatsPage({super.key});

  GlobalKey<FormState> formKey = GlobalKey();

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
                            await showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: const Text(
                                    "Edit Contact",
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                  content: Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        CircleAvatar(
                                          radius: 60,
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
                                        CupertinoTextFormFieldRow(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter name...";
                                            } else {
                                              return null;
                                            }
                                          },
                                          initialValue: tempChat.name,
                                          keyboardType: TextInputType.name,
                                          textInputAction: TextInputAction.next,
                                          placeholder: "Enter Name",
                                          textAlign: TextAlign.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: CupertinoColors
                                                  .opaqueSeparator,
                                            ),
                                          ),
                                          onChanged: (value) {
                                            tempChat.name = value;
                                          },
                                        ),
                                        CupertinoTextFormFieldRow(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please Phone number...";
                                            } else if (value.length < 10) {
                                              return "Phone Number Must Be Of 10 Digits...";
                                            } else if (value.length > 10) {
                                              return "Phone Number Must Be Of 10 Digits...";
                                            } else {
                                              return null;
                                            }
                                          },
                                          initialValue: tempChat.phoneNumber,
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                          placeholder: "Enter Phone Number",
                                          textAlign: TextAlign.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: CupertinoColors
                                                  .opaqueSeparator,
                                            ),
                                          ),
                                          onChanged: (value) {
                                            tempChat.phoneNumber = value;
                                          },
                                        ),
                                        CupertinoTextFormFieldRow(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter chat conversation...";
                                            } else {
                                              return null;
                                            }
                                          },
                                          initialValue: tempChat.chat,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.done,
                                          placeholder: "Enter Chat",
                                          textAlign: TextAlign.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: CupertinoColors
                                                  .opaqueSeparator,
                                            ),
                                          ),
                                          onChanged: (value) {
                                            tempChat.chat = value;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    CupertinoActionSheetAction(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      isDestructiveAction: true,
                                      child: const Text("Cancel"),
                                    ),
                                    CupertinoActionSheetAction(
                                      onPressed: () {
                                        bool isValidate =
                                            formKey.currentState!.validate();

                                        if (isValidate) {
                                          Navigator.pop(context);

                                          provider.editChat(
                                            index: index,
                                            chat: tempChat,
                                          );
                                        }
                                      },
                                      child: const Text("Done"),
                                    ),
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
                        onPressed: () {
                          provider.deleteChat(index: index);
                          Navigator.pop(context);
                        },
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

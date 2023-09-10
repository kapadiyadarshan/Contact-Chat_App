import 'dart:io';

import 'package:chat_app/controller/chat_controller.dart';
import 'package:chat_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/chat_model.dart';

class ChatsPage extends StatelessWidget {
  ChatsPage({super.key});

  GlobalKey<FormState> formKey = GlobalKey();

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
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 341,
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          child: Column(
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
                                height: 4,
                              ),
                              Text(
                                "${tempChat.name}",
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "${tempChat.chat}",
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context);

                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                            "            Edit Chat",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: MyColor.theme1,
                                            ),
                                          ),
                                          content: Form(
                                            key: formKey,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CircleAvatar(
                                                  radius: 60,
                                                  foregroundImage: FileImage(
                                                    File(tempChat.image),
                                                  ),
                                                  child: Text(
                                                    "${tempChat.name?[0].toUpperCase()}",
                                                    style: const TextStyle(
                                                      fontSize: 48,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 18,
                                                ),
                                                TextFormField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Please enter name...";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  cursorColor: MyColor.theme1,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  initialValue: tempChat.name,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText: "Enter full name",
                                                    label:
                                                        const Text("Full Name"),
                                                    labelStyle: TextStyle(
                                                      color: MyColor.theme1,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    prefixIcon: Icon(
                                                      Icons.person,
                                                      size: 24,
                                                      color: MyColor.theme1,
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                      borderSide: BorderSide(
                                                        color: MyColor.theme1,
                                                        width: 2,
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    tempChat.name = value;
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                TextFormField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Please Phone number...";
                                                    } else if (value.length <
                                                        10) {
                                                      return "Phone Number Must Be Of 10 Digits...";
                                                    } else if (value.length >
                                                        10) {
                                                      return "Phone Number Must Be Of 10 Digits...";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  cursorColor: MyColor.theme1,
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  initialValue:
                                                      tempChat.phoneNumber,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText:
                                                        "Enter phone number",
                                                    label: const Text(
                                                        "Phone Number"),
                                                    labelStyle: TextStyle(
                                                      color: MyColor.theme1,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    prefixIcon: Icon(
                                                      Icons.phone,
                                                      size: 24,
                                                      color: MyColor.theme1,
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                        color: MyColor.theme1,
                                                        width: 2,
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    tempChat.phoneNumber =
                                                        value;
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                TextFormField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Please enter chat conversation...";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  cursorColor: MyColor.theme1,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  initialValue: tempChat.chat,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText:
                                                        "Enter Chat conversation",
                                                    label: const Text(
                                                        "Chat Conversation"),
                                                    labelStyle: TextStyle(
                                                      color: MyColor.theme1,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    prefixIcon: Icon(
                                                      Icons.chat,
                                                      size: 24,
                                                      color: MyColor.theme1,
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                        color: MyColor.theme1,
                                                        width: 2,
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    tempChat.chat = value;
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          actionsAlignment:
                                              MainAxisAlignment.center,
                                          actions: [
                                            TextButton.icon(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(
                                                Icons.cancel_outlined,
                                              ),
                                              style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStatePropertyAll(
                                                  MyColor.theme1,
                                                ),
                                              ),
                                              label: const Text("Cancel"),
                                            ),
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                bool isValidate = formKey
                                                    .currentState!
                                                    .validate();

                                                if (isValidate) {
                                                  Navigator.pop(context);

                                                  provider.editChat(
                                                    index: index,
                                                    chat: tempChat,
                                                  );

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: const Text(
                                                          "Data Update Successfully!!"),
                                                      backgroundColor:
                                                          MyColor.theme1,
                                                      duration: const Duration(
                                                          seconds: 2),
                                                    ),
                                                  );
                                                }
                                              },
                                              icon: const Icon(Icons.done_all),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                  MyColor.theme1,
                                                ),
                                                foregroundColor:
                                                    MaterialStatePropertyAll(
                                                  MyColor.theme3,
                                                ),
                                              ),
                                              label: const Text("Save"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.edit),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                        MyColor.theme1,
                                      ),
                                      foregroundColor: MaterialStatePropertyAll(
                                        MyColor.theme3,
                                      ),
                                    ),
                                    label: const Text("Edit"),
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      provider.deleteChat(index: index);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Data Delete Successfully!!",
                                          ),
                                          backgroundColor: Colors.redAccent,
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.delete_forever),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                        MyColor.theme1,
                                      ),
                                      foregroundColor: MaterialStatePropertyAll(
                                        MyColor.theme3,
                                      ),
                                    ),
                                    label: const Text("Delete"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  title: Text(
                    "${tempChat.name}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    "${tempChat.chat}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: CircleAvatar(
                    radius: 30,
                    foregroundImage: (tempChat.image != null)
                        ? FileImage(File(tempChat.image))
                        : null,
                    child: Text(
                      "${tempChat.name?[0].toUpperCase()}",
                      style: const TextStyle(
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

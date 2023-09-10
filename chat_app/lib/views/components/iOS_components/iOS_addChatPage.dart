import 'dart:io';

import 'package:chat_app/controller/dateTime_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controller/chat_controller.dart';
import '../../../controller/image_controller.dart';
import '../../../model/chat_model.dart';

class iOSAddChatPage extends StatelessWidget {
  iOSAddChatPage({super.key});

  TextEditingController name = TextEditingController();
  TextEditingController phoneNum = TextEditingController();
  TextEditingController chat = TextEditingController();
  String? chatDate = "";
  String? chatTime = "";
  String? image = "";

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100, left: 12, right: 12, bottom: 60),
      child: SizedBox(
        height: 724,
        width: double.infinity,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Consumer<ImageController>(builder: (context, provider, _) {
                  return GestureDetector(
                    onTap: () async {
                      ImagePicker pickImg = ImagePicker();
                      XFile? file;

                      file =
                          await pickImg.pickImage(source: ImageSource.gallery);

                      if (file != null) {
                        Provider.of<ImageController>(context, listen: false)
                            .imageUpdate(file: file.path);

                        image = file.path;
                      }
                    },
                    child: CircleAvatar(
                      radius: 80,
                      foregroundImage: (provider.path != null)
                          ? FileImage(
                              File(provider.path!),
                            )
                          : null,
                      child: const Icon(
                        Icons.add_a_photo_rounded,
                        size: 32,
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  height: 18,
                ),
                CupertinoTextFormFieldRow(
                  controller: name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter full name...";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  placeholder: "Enter Full Name",
                  textAlign: TextAlign.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: CupertinoColors.opaqueSeparator,
                    ),
                  ),
                  onChanged: (value) {
                    name.text = value;
                  },
                ),
                CupertinoTextFormFieldRow(
                  controller: phoneNum,
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
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  placeholder: "Enter Phone Number",
                  textAlign: TextAlign.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: CupertinoColors.opaqueSeparator,
                    ),
                  ),
                  onChanged: (value) {
                    phoneNum.text = value;
                  },
                ),
                CupertinoTextFormFieldRow(
                  controller: chat,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter chat conversation...";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  placeholder: "Enter Chat Conversation",
                  textAlign: TextAlign.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: CupertinoColors.opaqueSeparator,
                    ),
                  ),
                  onChanged: (value) {
                    chat.text = value;
                  },
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                    ),
                    Container(
                      height: 120,
                      width: 182,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: CupertinoColors.opaqueSeparator,
                          width: 0.5,
                        ),
                      ),
                      child: Consumer<DateTimeController>(
                          builder: (context, provider, _) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              (provider.d == null)
                                  ? "Pick Date"
                                  : "${provider.d!.day}-${provider.d!.month}-${provider.d!.year}",
                              style: const TextStyle(
                                // color: MyColor.theme1,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            CupertinoButton(
                              onPressed: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => Container(
                                    height: 240,
                                    width: double.infinity,
                                    color: CupertinoColors.white,
                                    child: CupertinoDatePicker(
                                      backgroundColor: CupertinoColors.white,
                                      // minimumDate: DateTime.now(),
                                      maximumDate: DateTime.now().add(
                                        const Duration(
                                          days: 15,
                                        ),
                                      ),
                                      initialDateTime: provider.d,
                                      mode: CupertinoDatePickerMode.date,
                                      onDateTimeChanged: (DateTime date) {
                                        provider.dateChanged(date: date);
                                        // chatDate = date;
                                        chatDate =
                                            "${DateFormat("MMMd").format(date)}";
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                "Select Date",
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Container(
                      height: 120,
                      width: 182,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: CupertinoColors.opaqueSeparator,
                          width: 0.5,
                        ),
                      ),
                      child: Consumer<DateTimeController>(
                          builder: (context, provider, _) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              (provider.t == null)
                                  ? "Pick Time"
                                  : "${(provider.t!.hour == 0) ? "12" : provider.t!.hour % 12}:${provider.t!.minute.toString().padLeft(2, "0")}\t${(provider.t!.hour >= 12) ? "PM" : "AM"}",
                              style: const TextStyle(
                                // color: MyColor.theme1,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            CupertinoButton(
                              onPressed: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => Container(
                                    height: 240,
                                    width: double.infinity,
                                    color: CupertinoColors.white,
                                    child: CupertinoDatePicker(
                                      backgroundColor: CupertinoColors.white,
                                      initialDateTime: provider.d,
                                      mode: CupertinoDatePickerMode.time,
                                      onDateTimeChanged: (DateTime time) {
                                        provider.timeChanged(
                                          time: TimeOfDay.fromDateTime(time),
                                        );
                                        // t = TimeOfDay.fromDateTime(time);
                                        chatTime =
                                            "${(time.hour == 0) ? "12" : time.hour % 12}:${time.minute.toString().padLeft(2, "0")}\t${(time.hour >= 12) ? "PM" : "AM"}";
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                "Select Time",
                              ),
                            )
                          ],
                        );
                      }),
                    )
                  ],
                ),
                const SizedBox(
                  height: 214,
                ),
                CupertinoButton.filled(
                  child: const Text("SAVE"),
                  onPressed: () {
                    bool isValidate = formKey.currentState!.validate();

                    if (isValidate && chatDate != "" && chatTime != "") {
                      Chat c = Chat(
                        name: name.text,
                        phoneNumber: phoneNum.text,
                        chat: chat.text,
                        date: chatDate,
                        time: chatTime,
                        image: image ?? "",
                      );

                      Provider.of<ChatController>(context, listen: false)
                          .addChat(chat: c);

                      Provider.of<DateTimeController>(context, listen: false)
                          .clearDateAndTime();

                      Provider.of<ImageController>(context, listen: false)
                          .clearImage();

                      name.clear();
                      phoneNum.clear();
                      chat.clear();

                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: const Text("Data Saved Successfully.."),
                            actions: [
                              CupertinoButton(
                                child: const Text("Done"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        },
                      );
                    }
                    ;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

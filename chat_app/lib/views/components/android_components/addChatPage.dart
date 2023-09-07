import 'dart:io';

import 'package:chat_app/controller/chat_controller.dart';
import 'package:chat_app/controller/dateTime_controller.dart';
import 'package:chat_app/controller/image_controller.dart';
import 'package:chat_app/controller/myPage_controller.dart';
import 'package:chat_app/controller/settingPage_controller.dart';
import 'package:chat_app/model/chat_model.dart';
import 'package:chat_app/utils/color_utils.dart';
import 'package:chat_app/views/components/android_components/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddChatPage extends StatelessWidget {
  AddChatPage({super.key});

  String? name = "";
  String? phoneNum = "";
  String? chat = "";
  String? chatDate = "";
  String? chatTime = "";
  String? image = "";

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        height: 724,
        width: double.infinity,
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Consumer<ImageController>(builder: (context, provider, _) {
                return GestureDetector(
                  onTap: () async {
                    ImagePicker pickImg = ImagePicker();
                    XFile? file;

                    file = await pickImg.pickImage(source: ImageSource.gallery);

                    if (file != null) {
                      Provider.of<ImageController>(context, listen: false)
                          .imageUpdate(file: file!.path);

                      image = file!.path;
                    }
                  },
                  child: CircleAvatar(
                    radius: 80,
                    foregroundImage: (provider.path != null)
                        ? FileImage(
                            File(provider.path!),
                          )
                        : null,
                    child: Icon(
                      Icons.add_a_photo_rounded,
                      size: 32,
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 24,
              ),
              //Name
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter name...";
                  } else {
                    return null;
                  }
                },
                cursorColor: MyColor.theme1,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Enter full name",
                  label: const Text("Full Name"),
                  labelStyle: TextStyle(
                    // color: MyColor.theme1,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(
                    Icons.person,
                    size: 24,
                    // color: MyColor.theme1,
                  ),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: MyColor.theme1,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              //Phone number
              TextFormField(
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
                cursorColor: MyColor.theme1,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Enter phone number",
                  label: const Text("Phone Number"),
                  labelStyle: TextStyle(
                    // color: MyColor.theme1,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(
                    Icons.phone,
                    size: 24,
                    // color: MyColor.theme1,
                  ),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: MyColor.theme1,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  phoneNum = value;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              //Chat
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter chat conversation...";
                  } else {
                    return null;
                  }
                },
                cursorColor: MyColor.theme1,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Enter Chat conversation",
                  label: const Text("Chat Conversation"),
                  labelStyle: const TextStyle(
                    // color: MyColor.theme1,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: const Icon(
                    Icons.chat,
                    size: 24,
                    // color: MyColor.theme1,
                  ),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: MyColor.theme1,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  chat = value;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              //Date and Time
              Row(
                children: [
                  Container(
                    height: 120,
                    width: 192,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color:
                            Provider.of<SettingPageController>(context).getTheme
                                ? Colors.white60
                                : Colors.black54,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Consumer<DateTimeController>(
                        builder: (context, provider, _) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            (provider.d == null)
                                ? "Pick Date"
                                : "${provider.d!.day}-${provider.d!.month}-${provider.d!.year}",
                            style: TextStyle(
                              // color: MyColor.theme1,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: provider.d ?? DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                              );

                              if (date != null) {
                                provider.dateChanged(date: date);

                                chatDate =
                                    "${date.day}-${date.month}-${date.year}";

                                chatDate = "${DateFormat("MMMd").format(date)}";
                              }
                            },
                            icon: const Icon(Icons.date_range),
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                MyColor.theme1,
                              ),
                              foregroundColor: MaterialStatePropertyAll(
                                MyColor.theme3,
                              ),
                            ),
                            label: const Text("Select Date"),
                          ),
                        ],
                      );
                    }),
                  ),
                  const Spacer(),
                  Container(
                    height: 120,
                    width: 192,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color:
                            Provider.of<SettingPageController>(context).getTheme
                                ? Colors.white60
                                : Colors.black54,
                      ),
                    ),
                    child: Consumer<DateTimeController>(
                        builder: (context, provider, _) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            (provider.t == null)
                                ? "Pick Time"
                                : "${(provider.t!.hour == 0) ? "12" : provider.t!.hour % 12}:${provider.t!.minute.toString().padLeft(2, "0")}\t${(provider.t!.hour >= 12) ? "PM" : "AM"}",
                            style: TextStyle(
                              // color: MyColor.theme1,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: provider.t ?? TimeOfDay.now(),
                              );

                              if (time != null) {
                                provider.timeChanged(time: time);

                                chatTime =
                                    "${(time.hour == 0) ? "12" : time.hour % 12}:${time.minute.toString().padLeft(2, "0")}\t${(time.hour >= 12) ? "PM" : "AM"}";
                              }
                            },
                            icon: const Icon(Icons.timelapse),
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                MyColor.theme1,
                              ),
                              foregroundColor: MaterialStatePropertyAll(
                                MyColor.theme3,
                              ),
                            ),
                            label: const Text("Select Time"),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  bool isValidate = formKey.currentState!.validate();

                  if (isValidate && chatDate != "" && chatTime != "") {
                    Chat c = Chat(
                      name: name,
                      phoneNumber: phoneNum,
                      chat: chat,
                      date: chatDate,
                      time: chatTime,
                      image: image ?? "",
                    );

                    Provider.of<ChatController>(context, listen: false)
                        .addChat(chat: c);

                    ScaffoldMessenger.of(context).showSnackBar(
                      mySnackBar(
                        content: "Data Saved Successfully!!",
                        myColor: MyColor.theme1,
                      ),
                    );

                    Provider.of<MyPageController>(context, listen: false)
                        .changePage(index: 1);

                    Provider.of<DateTimeController>(context, listen: false)
                        .clearDateAndTime();

                    Provider.of<ImageController>(context, listen: false)
                        .clearImage();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      mySnackBar(
                        content: "Enter Date and Time...!!",
                        myColor: Colors.redAccent,
                      ),
                    );
                  }
                  ;
                },
                child: Container(
                  height: 50,
                  width: 200,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: MyColor.theme1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 20,
                      color: MyColor.theme3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:chat_app/controller/chat_controller.dart';
import 'package:chat_app/controller/dateTime_controller.dart';
import 'package:chat_app/controller/image_controller.dart';
import 'package:chat_app/model/chat_model.dart';
import 'package:chat_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
              Consumer<ImageController>(builder: (context, provider, _) {
                return CircleAvatar(
                  radius: 80,
                  backgroundImage: (provider.file != null)
                      ? FileImage(Provider.of<ImageController>(context).file!)
                      : null,
                );
              }),
              const SizedBox(
                height: 12,
              ),
              //Add Image
              GestureDetector(
                onTap: () async {
                  ImagePicker pickImg = ImagePicker();
                  XFile? file;

                  file = await pickImg.pickImage(source: ImageSource.gallery);

                  if (file != null) {
                    Provider.of<ImageController>(context, listen: false)
                        .imageUpdate(f: file);
                  }
                },
                child: Container(
                  height: 40,
                  width: 120,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: MyColor.theme1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text("Add Image",
                      style: TextStyle(
                        color: MyColor.theme3,
                      )),
                ),
              ),
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
                    color: MyColor.theme1,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(
                    Icons.person,
                    size: 24,
                    color: MyColor.theme1,
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
                    color: MyColor.theme1,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(
                    Icons.phone,
                    size: 24,
                    color: MyColor.theme1,
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
                  labelStyle: TextStyle(
                    color: MyColor.theme1,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(
                    Icons.chat,
                    size: 24,
                    color: MyColor.theme1,
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
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(),
                    ),
                    alignment: Alignment.center,
                    child: Consumer<DateTimeController>(
                        builder: (context, provider, _) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            (provider.d == null)
                                ? "DD/MM/YYYY"
                                : "${provider.d!.day}-${provider.d!.month}-${provider.d!.year}",
                            style: TextStyle(
                              color: MyColor.theme1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
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
                              }
                            },
                            child: const Text("Select Date"),
                          ),
                        ],
                      );
                    }),
                  ),
                  Spacer(),
                  Container(
                    height: 120,
                    width: 192,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(),
                    ),
                    child: Consumer<DateTimeController>(
                        builder: (context, provider, _) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            (provider.t == null)
                                ? "HH:MM"
                                : "${(provider.t!.hour == 0) ? "12" : provider.t!.hour % 12}:${provider.t!.minute.toString().padLeft(2, "0")}\t${(provider.t!.hour >= 12) ? "PM" : "AM"}",
                            style: TextStyle(
                              color: MyColor.theme1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
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
                            child: const Text("Select Time"),
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

                  print(name);
                  print(phoneNum);
                  print(chat);
                  print(chatDate);
                  print(chatTime);

                  if (isValidate) {
                    Chat c = Chat(
                      name: name,
                      phoneNumber: phoneNum,
                      chat: chat,
                      date: chatDate,
                      time: chatTime,
                    );

                    Provider.of<ChatController>(context, listen: false)
                        .addChat(chat: c);
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

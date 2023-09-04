import 'package:chat_app/controller/dateTime_controller.dart';
import 'package:chat_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddChatPage extends StatelessWidget {
  const AddChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 80,
              ),
              const SizedBox(
                height: 12,
              ),
              //Add Image
              Container(
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
                textInputAction: TextInputAction.next,
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
                                : "${provider.t!.hour}:${provider.t!.minute}",
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
                              }
                            },
                            child: const Text("Select Time"),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

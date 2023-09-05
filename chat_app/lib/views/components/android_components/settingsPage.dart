import 'package:chat_app/controller/settingPage_controller.dart';
import 'package:chat_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        height: 724,
        child: Column(
          children: [
            Consumer<SettingPageController>(builder: (context, provider, _) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text(
                        "Profile",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColor.theme1,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: const Text("Update Profile"),
                      leading: Icon(
                        Icons.person,
                        size: 32,
                        color: MyColor.theme1,
                      ),
                      trailing: Consumer<SettingPageController>(
                          builder: (context, provider, _) {
                        return Switch(
                          value: provider.isProfileOn,
                          onChanged: (value) {
                            provider.profileOnOff();
                          },
                        );
                      }),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 60,
                            child: Icon(
                              Icons.add_a_photo_rounded,
                              size: 32,
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
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Enter Name",
                              label: const Text("Name"),
                              labelStyle: TextStyle(
                                color: MyColor.theme1,
                                fontWeight: FontWeight.w500,
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
                            onChanged: (value) {},
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter bio...";
                              } else {
                                return null;
                              }
                            },
                            cursorColor: MyColor.theme1,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Enter Bio",
                              label: const Text("Bio"),
                              labelStyle: TextStyle(
                                color: MyColor.theme1,
                                fontWeight: FontWeight.w500,
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
                            onChanged: (value) {},
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 40,
                                width: 120,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: MyColor.theme1,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "SAVE",
                                  style: TextStyle(
                                    color: MyColor.theme3,
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 120,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: MyColor.theme1,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "CLEAR",
                                  style: TextStyle(
                                    color: MyColor.theme3,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

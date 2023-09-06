import 'dart:io';

import 'package:chat_app/controller/settingPage_controller.dart';
import 'package:chat_app/model/profile_model.dart';
import 'package:chat_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MySettingsPage extends StatelessWidget {
  MySettingsPage({super.key});

  GlobalKey<FormState> formKey = GlobalKey();

  String? name;
  String? bio;
  String? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        height: 724,
        child: Column(
          children: [
            //profile
            Container(
              decoration: BoxDecoration(
                color: MyColor.bgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Consumer<SettingPageController>(
                  builder: (context, provider, _) {
                Profile tempProfile =
                    Provider.of<SettingPageController>(context).getProfile;
                return Column(
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
                      trailing: SwitchTheme(
                        data: SwitchThemeData(
                          thumbColor: MaterialStatePropertyAll(
                            (provider.isProfileOn)
                                ? MyColor.theme3
                                : MyColor.theme1,
                          ),
                          trackColor: MaterialStatePropertyAll(
                            (provider.isProfileOn)
                                ? MyColor.theme1
                                : MyColor.theme3,
                          ),
                          trackOutlineColor:
                              MaterialStatePropertyAll(MyColor.theme1),
                          trackOutlineWidth: const MaterialStatePropertyAll(1),
                        ),
                        child: Switch(
                          value: provider.isProfileOn,
                          onChanged: (value) {
                            provider.profileOnOff();
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: provider.isProfileOn,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        child: Form(
                          key: formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  ImagePicker pickImg = ImagePicker();
                                  XFile? file;

                                  file = await pickImg.pickImage(
                                      source: ImageSource.gallery);

                                  if (file != null) {
                                    image = file.path;

                                    provider.imageUpdate(file: image!);
                                    tempProfile.image = file.path;
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 60,
                                  foregroundImage: FileImage(
                                    File(provider.getProfile.image),
                                  ),
                                  child: const Icon(
                                    Icons.add_a_photo_rounded,
                                    size: 32,
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
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                initialValue: tempProfile.name,
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
                                onChanged: (value) {
                                  name = value;
                                },
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
                                textInputAction: TextInputAction.done,
                                initialValue: tempProfile.bio,
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
                                onChanged: (value) {
                                  bio = value;
                                },
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      bool isValidate =
                                          formKey.currentState!.validate();

                                      if (isValidate) {
                                        provider.profileUpdate(
                                          Name: name!,
                                          Bio: bio!,
                                          MyImage: image!,
                                        );

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                                "Data Saved Successfully!!"),
                                            backgroundColor: MyColor.theme1,
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        );
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
                                      child: Text(
                                        "SAVE",
                                        style: TextStyle(
                                          color: MyColor.theme3,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      provider.profileClear();

                                      provider.imageClear();
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
                                      child: Text(
                                        "CLEAR",
                                        style: TextStyle(
                                          color: MyColor.theme3,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(
              height: 12,
            ),
            //Theme
            Container(
              decoration: BoxDecoration(
                color: MyColor.bgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                title: Text(
                  "Theme",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MyColor.theme1,
                    fontSize: 20,
                  ),
                ),
                subtitle: const Text("Change Theme"),
                leading: Icon(
                  Icons.light_mode,
                  size: 32,
                  color: MyColor.theme1,
                ),
                trailing:
                    Consumer<SettingPageController>(builder: (context, pro, _) {
                  return SwitchTheme(
                    data: SwitchThemeData(
                      thumbColor: MaterialStatePropertyAll(
                        (pro.isDark) ? MyColor.theme3 : MyColor.theme1,
                      ),
                      trackColor: MaterialStatePropertyAll(
                        (pro.isDark) ? MyColor.theme1 : MyColor.theme3,
                      ),
                      trackOutlineColor:
                          MaterialStatePropertyAll(MyColor.theme1),
                      trackOutlineWidth: const MaterialStatePropertyAll(1),
                    ),
                    child: Switch(
                      value: pro.isDark,
                      onChanged: (value) {
                        pro.changeTheme();
                      },
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

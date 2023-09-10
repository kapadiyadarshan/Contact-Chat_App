import 'dart:io';

import 'package:chat_app/controller/settingPage_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../model/profile_model.dart';
import '../../../utils/color_utils.dart';

class iOSsettingsPage extends StatelessWidget {
  iOSsettingsPage({super.key});

  GlobalKey<FormState> formKey = GlobalKey();

  String? name;
  String? bio;
  String? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 100,
        left: 12,
        right: 12,
        bottom: 12,
      ),
      child: Column(
        children: [
          CupertinoListTile(
            title: const Text("Profile"),
            subtitle: const Text("Update Profile"),
            leading: const Icon(
              CupertinoIcons.profile_circled,
              size: 28,
            ),
            trailing: Consumer<SettingPageController>(
                builder: (context, provider, _) {
              return CupertinoSwitch(
                value: provider.getProfileOn,
                onChanged: (value) {
                  provider.profileOnOff();
                },
              );
            }),
          ),
          const SizedBox(
            height: 12,
          ),
          Consumer<SettingPageController>(builder: (context, provider, _) {
            Profile tempProfile =
                Provider.of<SettingPageController>(context).getProfile;

            return Visibility(
              visible: provider.getProfileOn,
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
                        height: 12,
                      ),
                      CupertinoTextFormFieldRow(
                        controller: tempProfile.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "                          Please enter name...";
                          } else {
                            return null;
                          }
                        },
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.center,
                        placeholder: "Enter Name",
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                      CupertinoTextFormFieldRow(
                        controller: tempProfile.bio,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "                            Please enter bio...";
                          } else {
                            return null;
                          }
                        },
                        textInputAction: TextInputAction.done,
                        textAlign: TextAlign.center,
                        placeholder: "Enter Bio",
                        onChanged: (value) {
                          bio = value;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CupertinoButton(
                            child: const Text("SAVE"),
                            onPressed: () {
                              bool isValidate =
                                  formKey.currentState!.validate();

                              if (isValidate) {
                                provider.profileUpdate(
                                  Name: name ?? provider.getProfile.name.text,
                                  Bio: bio ?? provider.getProfile.bio.text,
                                  MyImage: image ?? provider.getProfile.image,
                                );

                                showCupertinoDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: const Text(
                                          "Profile Save Successfully.."),
                                      actions: [
                                        CupertinoButton(
                                          child: const Text("Okay"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          ),
                          CupertinoButton(
                            child: const Text("CLEAR"),
                            onPressed: () {
                              provider.profileClear();

                              provider.imageClear();
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
          const Divider(
            thickness: 0.3,
          ),
          CupertinoListTile(
            title: const Text("Theme"),
            subtitle: const Text("Update theme"),
            leading: const Icon(
              Icons.light_mode,
              size: 28,
            ),
            trailing: Consumer<SettingPageController>(
                builder: (context, provider, _) {
              return CupertinoSwitch(
                value: provider.getTheme,
                onChanged: (value) {
                  provider.changeTheme();
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

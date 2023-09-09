import 'package:chat_app/controller/myPage_controller.dart';
import 'package:chat_app/controller/platform_controller.dart';
import 'package:chat_app/utils/color_utils.dart';
import 'package:chat_app/views/components/android_components/addChatPage.dart';
import 'package:chat_app/views/components/android_components/callsPage.dart';
import 'package:chat_app/views/components/android_components/chatsPage.dart';
import 'package:chat_app/views/components/android_components/settingsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          bool willPop = await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  "Exit !!",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                alignment: Alignment.center,
                content: const Text("Are you sure exit?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text("No"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text("Yes"),
                  ),
                ],
              );
            },
          );
          return willPop;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("Chat App"),
            centerTitle: true,
            elevation: 0,
            actions: [
              Consumer<PlatformController>(builder: (context, provider, _) {
                return SwitchTheme(
                  data: SwitchThemeData(
                    thumbColor: MaterialStatePropertyAll(MyColor.theme1),
                    trackColor: MaterialStatePropertyAll(MyColor.theme3),
                  ),
                  child: Switch(
                    value: provider.isAndroid,
                    onChanged: (value) {
                      provider.changePlatform();
                    },
                  ),
                );
              })
            ],
          ),
          body: Column(
            children: [
              Consumer<MyPageController>(builder: (context, provider, _) {
                return Container(
                  padding: const EdgeInsets.all(4),
                  color: MyColor.theme1,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          provider.changePage(index: 0);
                        },
                        child: Container(
                          height: 40,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: (provider.currentIndex == 0)
                                ? Border.fromBorderSide(
                                    BorderSide(
                                      color: MyColor.theme3,
                                      width: 2,
                                    ),
                                  )
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.add_reaction_outlined,
                            color: MyColor.theme3,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            provider.changePage(index: 1);
                          },
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: (provider.currentIndex == 1)
                                  ? Border.fromBorderSide(
                                      BorderSide(
                                        color: MyColor.theme3,
                                        width: 2,
                                      ),
                                    )
                                  : null,
                            ),
                            child: Text(
                              "CHATS",
                              style: TextStyle(
                                color: MyColor.theme3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            provider.changePage(index: 2);
                          },
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: (provider.currentIndex == 2)
                                  ? Border.fromBorderSide(
                                      BorderSide(
                                          color: MyColor.theme3, width: 2),
                                    )
                                  : null,
                            ),
                            child: Text(
                              "CALLS",
                              style: TextStyle(
                                color: MyColor.theme3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            provider.changePage(index: 3);
                          },
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: (provider.currentIndex == 3)
                                  ? Border.fromBorderSide(
                                      BorderSide(
                                        color: MyColor.theme3,
                                        width: 2,
                                      ),
                                    )
                                  : null,
                            ),
                            child: Text(
                              "SETTINGS",
                              style: TextStyle(
                                color: MyColor.theme3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              IndexedStack(
                index: Provider.of<MyPageController>(context).currentIndex,
                children: [
                  AddChatPage(),
                  ChatsPage(),
                  CallsPage(),
                  MySettingsPage(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

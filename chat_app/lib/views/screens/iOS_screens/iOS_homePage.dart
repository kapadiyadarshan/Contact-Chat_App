import 'package:chat_app/controller/platform_controller.dart';
import 'package:chat_app/views/components/iOS_components/iOS_addChatPage.dart';
import 'package:chat_app/views/components/iOS_components/iOS_callsPage.dart';
import 'package:chat_app/views/components/iOS_components/iOS_chatsPage.dart';
import 'package:chat_app/views/components/iOS_components/iOS_settingsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class iOSHomePage extends StatelessWidget {
  iOSHomePage({super.key});

  List<Widget> components = [
    iOSAddChatPage(),
    iOSchatsPage(),
    const iOScallsPage(),
    iOSsettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool willPop = await showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text("Exit"),
              content: const Text("Are you sure exit?"),
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  isDestructiveAction: true,
                  isDefaultAction: true,
                  child: const Text("No"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  isDefaultAction: true,
                  child: const Text("Yes"),
                ),
              ],
            );
          },
        );
        return willPop;
      },
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text("Chat App"),
          trailing:
              Consumer<PlatformController>(builder: (context, provider, _) {
            return CupertinoSwitch(
              value: provider.getPlatform,
              onChanged: (value) {
                provider.changePlatform();
              },
            );
          }),
        ),
        child: CupertinoTabScaffold(
          tabBuilder: (BuildContext context, int index) {
            return components[index];
          },
          tabBar: CupertinoTabBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person_add),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble_text),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.phone),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

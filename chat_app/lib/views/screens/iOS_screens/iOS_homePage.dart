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
    iOSaddChatPage(),
    iOSchatsPage(),
    iOScallsPage(),
    iOSsettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Home Page"),
        trailing: Consumer<PlatformController>(builder: (context, provider, _) {
          return CupertinoSwitch(
            value: provider.isAndroid,
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
    );
  }
}

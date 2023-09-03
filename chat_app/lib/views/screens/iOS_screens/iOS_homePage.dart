import 'package:chat_app/controller/platform_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class iOSHomePage extends StatelessWidget {
  const iOSHomePage({super.key});

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
      child: Center(),
    );
  }
}

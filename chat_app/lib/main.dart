import 'package:chat_app/controller/chat_controller.dart';
import 'package:chat_app/controller/dateTime_controller.dart';
import 'package:chat_app/controller/image_controller.dart';
import 'package:chat_app/controller/myPage_controller.dart';
import 'package:chat_app/controller/platform_controller.dart';
import 'package:chat_app/controller/settingPage_controller.dart';
import 'package:chat_app/utils/color_utils.dart';
import 'package:chat_app/utils/route_utils.dart';
import 'package:chat_app/views/screens/android_screens/homePage.dart';
import 'package:chat_app/views/screens/iOS_screens/iOS_homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  SharedPreferences preferences = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlatformController(),
        ),
        ChangeNotifierProvider(
          create: (context) => MyPageController(),
        ),
        ChangeNotifierProvider(
          create: (context) => DateTimeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImageController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatController(preferences: preferences),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingPageController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider.of<PlatformController>(context).isAndroid
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              appBarTheme: AppBarTheme(
                backgroundColor: MyColor.theme1,
                foregroundColor: MyColor.theme3,
                titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            initialRoute: AndroidRoute.homePage,
            routes: {
              AndroidRoute.homePage: (context) => HomePage(),
            },
          )
        : CupertinoApp(
            debugShowCheckedModeBanner: false,
            theme: const CupertinoThemeData(
              brightness: Brightness.light,
            ),
            initialRoute: iOSRoute.Homepage,
            routes: {
              iOSRoute.Homepage: (p0) => iOSHomePage(),
            },
          );
  }
}

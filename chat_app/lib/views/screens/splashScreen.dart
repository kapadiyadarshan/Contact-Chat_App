import 'dart:async';

import 'package:chat_app/controller/splashScreen_controller.dart';
import 'package:chat_app/utils/color_utils.dart';
import 'package:chat_app/utils/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  void changeScreen({required BuildContext context}) {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      Navigator.of(context).pushReplacementNamed(AndroidRoute.homePage);
      timer.cancel();

      Provider.of<SplashScreenController>(context, listen: false)
          .isSplashChanged();
    });
  }

  @override
  Widget build(BuildContext context) {
    changeScreen(context: context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("asset/images/splash.jpg"),
                fit: BoxFit.fitHeight,
                opacity: 0.2,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 2,
              ),
              Image.asset(
                "asset/images/chat_logo.png",
                scale: 1,
              ),
              Text(
                "Chat App",
                style: GoogleFonts.lobster(
                  fontSize: 64,
                  color: MyColor.theme1,
                ),
              ),
              const SizedBox(
                height: 140,
              ),
              SpinKitChasingDots(
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyColor.theme1,
                  ),
                ),
              ),
              const Spacer(),
            ],
          )
        ],
      ),
    );
  }
}

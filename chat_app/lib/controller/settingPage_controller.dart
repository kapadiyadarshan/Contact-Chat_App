import 'package:chat_app/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPageController extends ChangeNotifier {
  bool isProfileOn = false;
  bool isDark = false;
  String? path;

  Profile _profile = Profile();

  late SharedPreferences preferences;

  SettingPageController({required this.preferences});

  Profile get getProfile {
    initData();
    return _profile;
  }

  initData() {
    _profile.name = preferences.getString('Pr_name') ?? "";
    _profile.bio = preferences.getString('Pr_bio') ?? "";
    _profile.image = preferences.getString('Pr_image') ?? "";
  }

  setData() {
    preferences.setString("Pr_name", _profile.name!);
    preferences.setString("Pr_bio", _profile.bio!);
    preferences.setString("Pr_image", _profile.image!);

    notifyListeners();
  }

  profileOnOff() {
    isProfileOn = !isProfileOn;
    notifyListeners();
  }

  changeTheme() {
    isDark = !isDark;
    notifyListeners();
  }

  imageUpdate({required String file}) {
    initData();
    _profile.image = file;
    setData();
    // notifyListeners();
  }

  imageClear() {
    _profile.image = "";
    notifyListeners();
  }

  profileUpdate(
      {required String Name, required String Bio, required String MyImage}) {
    initData();
    _profile.name = Name;
    _profile.bio = Bio;
    _profile.image = MyImage;

    // name = Name;
    // bio = Bio;
    // image = MyImage;

    setData();
  }

  profileClear() {
    _profile.name = "";
    _profile.bio = "";
    _profile.image = "";

    setData();
  }
}

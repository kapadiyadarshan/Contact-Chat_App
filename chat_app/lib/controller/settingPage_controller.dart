import 'package:chat_app/model/profile_model.dart';
import 'package:chat_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPageController extends ChangeNotifier {
  bool _isProfileOn = false;
  bool _isDark = false;
  String? path;

  Profile _profile = Profile();

  late SharedPreferences preferences;

  SettingPageController({required this.preferences});

  Profile get getProfile {
    initProfileData();
    return _profile;
  }

  get getTheme {
    _isDark = preferences.getBool("theme") ?? false;
    return _isDark;
  }

  get getProfileOn {
    _isProfileOn = preferences.getBool("profile") ?? false;
    return _isProfileOn;
  }

  initProfileData() {
    _profile.name = preferences.getString('Pr_name') ?? "";
    _profile.bio = preferences.getString('Pr_bio') ?? "";
    _profile.image = preferences.getString('Pr_image') ?? "";
  }

  setProfileData() {
    preferences.setString("Pr_name", _profile.name!);
    preferences.setString("Pr_bio", _profile.bio!);
    preferences.setString("Pr_image", _profile.image!);

    notifyListeners();
  }

  profileOnOff() {
    _isProfileOn = !_isProfileOn;
    preferences.setBool("profile", _isProfileOn);
    notifyListeners();
  }

  changeTheme() {
    _isDark = !_isDark;
    preferences.setBool("theme", _isDark);
    notifyListeners();
  }

  imageUpdate({required String file}) {
    initProfileData();
    _profile.image = file;
    setProfileData();
    // notifyListeners();
  }

  imageClear() {
    _profile.image = "";
    notifyListeners();
  }

  profileUpdate(
      {required String Name, required String Bio, required String MyImage}) {
    initProfileData();
    _profile.name = Name;
    _profile.bio = Bio;
    _profile.image = MyImage;

    // name = Name;
    // bio = Bio;
    // image = MyImage;

    setProfileData();
  }

  profileClear() {
    _profile.name = "";
    _profile.bio = "";
    _profile.image = "";

    setProfileData();
  }
}

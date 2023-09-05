import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/chat_model.dart';

class ChatController extends ChangeNotifier {
  List<Chat> _allChatsDataList = [];

  late SharedPreferences preferences;

  ChatController({required this.preferences});

  List<String> _allNameList = [];
  List<String> _allPhoneNumList = [];
  List<String> _allChatList = [];
  List<String> _allDateList = [];
  List<String> _allTimeList = [];

  String nameKey = "name";
  String phoneNumKey = "phoneNum";
  String chatKey = "chat";
  String dateKey = "date";
  String timeKey = "time";

  List<Chat> get getChatsDataList {
    initData();
    return _allChatsDataList;
  }

  initData() {
    _allNameList = preferences.getStringList(nameKey) ?? [];
    _allPhoneNumList = preferences.getStringList(phoneNumKey) ?? [];
    _allChatList = preferences.getStringList(chatKey) ?? [];
    _allDateList = preferences.getStringList(dateKey) ?? [];
    _allTimeList = preferences.getStringList(timeKey) ?? [];

    _allChatsDataList = List.generate(
      _allNameList.length,
      (index) => Chat(
          name: _allNameList[index],
          phoneNumber: _allPhoneNumList[index],
          chat: _allChatList[index],
          date: _allDateList[index],
          time: _allTimeList[index]),
    );
  }

  setData() {
    preferences
      ..setStringList(nameKey, _allNameList)
      ..setStringList(phoneNumKey, _allPhoneNumList)
      ..setStringList(chatKey, _allChatList)
      ..setStringList(dateKey, _allDateList)
      ..setStringList(timeKey, _allTimeList);

    notifyListeners();
  }

  addChat({required Chat chat}) {
    initData();

    _allChatsDataList.add(chat);

    _allNameList.add(chat.name!);
    _allPhoneNumList.add(chat.phoneNumber!);
    _allChatList.add(chat.chat!);
    _allDateList.add(chat.date!);
    _allTimeList.add(chat.time!);

    setData();
  }
}

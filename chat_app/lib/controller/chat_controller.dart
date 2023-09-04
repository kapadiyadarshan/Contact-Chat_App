import 'package:flutter/material.dart';

import '../model/chat_model.dart';

class ChatController extends ChangeNotifier {
  List<Chat> _allChatsList = [];

  List<Chat> get getChatsList {
    return _allChatsList;
  }

  addChat({required Chat chat}) {
    _allChatsList.add(chat);
    notifyListeners();
  }
}

import 'package:chat_gpt/models/chat_model.dart';
import 'package:flutter/material.dart';

import '../exports/models_export.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMsg({required String msg}) {
    chatList.add(
      ChatModel(
        text: msg,
        index: 0,
      ),
    );
    notifyListeners();
  }

  Future<void> sendMsgAndGetAnswer(
      {required String msg, required String chosedModelid}) async {
    chatList.addAll(await ApiServices.getChatModel(
      message: msg,
      modelId: chosedModelid,
    ));
    notifyListeners();
  }
}

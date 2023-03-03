import 'package:chat_gpt/exports/models_export.dart';
import 'package:flutter/material.dart';

class ModelsProvider with ChangeNotifier {
  String currentModel = 'text-davinci-003';
  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String model) {
    currentModel = model;
    notifyListeners();
  }

  List<AppModel> modelsList = [];

  List<AppModel> get getModels {
    return modelsList;
  }

  Future<List<AppModel>> getAllModels() async {
    modelsList = await ApiServices.getModels();
    return modelsList;
  }
}

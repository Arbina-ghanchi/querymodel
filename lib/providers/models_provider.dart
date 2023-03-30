import 'package:chatgpt/models/model_models.dart';
import 'package:chatgpt/services/api_service.dart';
import 'package:flutter/material.dart';

class modelsprovider with ChangeNotifier {
  String currentModel = "text-davinci-003";

  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelsModel> modelsList = [];

  // String currentModel = "text-davinci-002";

  List<ModelsModel> get getmodelslist {
    return modelsList;
  }

  Future<List<ModelsModel>> getAllModel() async {
    modelsList =await ApiService.getModels();

    return modelsList;
  }
}

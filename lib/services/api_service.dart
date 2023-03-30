import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chatgpt/constant/apiconst.dart';
import 'package:chatgpt/models/chat_model.dart';
import 'package:chatgpt/models/model_models.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse("$Base_url/models"),
        headers: {'Authorization': 'Bearer $Api_key'},
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      // print("jsonResponse $jsonResponse");
      List temp = [];
      for (var value in jsonResponse["data"]) {
        temp.add(value);
        // print("temp ${value["id"]}");
      }
      return ModelsModel.modelFromSnapshot(temp);
    } catch (error) {
      print("error $error");
      rethrow;
    }
  }

  //send message using post
  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      var response = await http.post(
        Uri.parse("$Base_url/completions"),
        headers: {
          'Authorization': 'Bearer $Api_key',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {
            "model": modelId,
            "prompt": message,
            "max_tokens": 100,
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }

      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        // log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
              msg: jsonResponse["choices"][index]["text"], chatIndex: 1),
        );
      }
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}

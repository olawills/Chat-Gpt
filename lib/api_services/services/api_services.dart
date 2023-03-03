import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:chat_gpt/models/chat_model.dart';
import 'package:http/http.dart' as http;
import '../../exports/models_export.dart';

class ApiServices {
  static Future<List<AppModel>> getModels() async {
    var getUrl = Uri.parse('$baseUrl/models');
    try {
      var response =
          await http.get(getUrl, headers: {'Authorization': 'Bearer $apiKey'});

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] $jsonResponse['error']['message']");
        throw HttpException(jsonResponse['error']['message']);
      }
      // print('jsonResponse $jsonResponse');

      List temp = [];
      for (var value in jsonResponse['data']) {
        temp.add(value);
        // log("temp ${value['id']}");
      }
      return AppModel.modelsFromSnapshot(temp);
    } catch (e) {
      log('error $e');
      rethrow;
    }
  }

  static Future<List<ChatModel>> getChatModel({
    required String message,
    required String modelId,
  }) async {
    var getCompletionUrl = Uri.parse('$baseUrl/completions');
    try {
      //log('modelId $modelId');
      var response = await http.post(getCompletionUrl,
          headers: {
            'Authorization': 'Bearer $apiKey',
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "model": modelId,
            "prompt": message,
            "max_tokens": 100,
          }));

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse['choices'].length > 0) {
        chatList = List.generate(
          jsonResponse['choices'].length,
          (index) => ChatModel(
            text: jsonResponse['choices'][index]['text'],
            index: 1,
          ),
        );
      }
      return chatList;
    } catch (e) {
      log('error $e');
      rethrow;
    }
  }
}

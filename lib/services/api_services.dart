import 'dart:convert';
import 'dart:io';
import 'package:chat_gpt/constants/api_constants.dart';
import 'package:chat_gpt/models/chat_model.dart';
import 'package:chat_gpt/models/models_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/models"),
        headers: {'Authorization': 'Bearer $API_KEY'},
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
        if (kDebugMode) {
          print("temp ${value["id"]}");
        }
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      if (kDebugMode) {
        print("error $error");
      }
      rethrow;
    }
  }

  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      var response = await http.post(Uri.parse("$BASE_URL/completions"),
          headers: {
            'Authorization': 'Bearer $API_KEY',
            "Content-Type": "application/json"
          },
          body: jsonEncode(
              {"model": modelId, "prompt": message, "max token": 100}));

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      // print("jsonResponse $jsonResponse");
      List<ChatModel> chatlist = [];
      if (jsonResponse["choices"].lenght > 0) {
        chatlist = List.generate(
          jsonResponse["choices"].lenght,
          (index) => ChatModel(
              msg: jsonResponse["choices"][index]["text"], chatIndex: 1),
        );
      }
      return chatlist;
    } catch (error) {
      if (kDebugMode) {
        print("error $error");
      }
      rethrow;
    }
  }
}

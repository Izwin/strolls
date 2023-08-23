import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strolls/core/error/my_server_exception.dart';
import 'package:strolls/core/network/host_data.dart';
import 'package:strolls/features/chat/data/models/message_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RemoteChatsDataSource {
  Dio dio;

  RemoteChatsDataSource({required this.dio});
  IOWebSocketChannel? channel;

  Future<void> init() async {
    var prefs = await SharedPreferences.getInstance();
    final someToken = prefs.getString("accessToken");
    channel = IOWebSocketChannel.connect(Uri.parse(HostData.SOCKET),
        headers: {"Authorization": 'Bearer $someToken'});
  }

  Future<void> getMessages(
      int strollId,
      Function(List<MessageModel> list) onReceived,
      Function(MessageModel message) onMessageReceived) async {
    await init();

    channel?.stream.listen((message) {
      var jsonResult = jsonDecode(message);
      var type = jsonResult["type"] as String;

      switch (type) {
        case "GET_MESSAGES":
          var messages = (jsonResult["data"] as List<dynamic>)
              .map((e) => MessageModel.fromJson(e))
              .toList();
          onReceived(messages);
          break;

        case "NEW_MESSAGE":
          var message =MessageModel.fromJson(jsonResult["data"]);
          onMessageReceived(message);
          break;
        case "ERROR_GET_MESSAGES":
          _error((){
            channel?.sink
                .add("{\"type\" : \"getMessages\",\"strollId\":\"$strollId\"}");
          });
          break;
        default:
          throw MyServerException(message: "Error");
      }
    });
    channel?.sink
        .add("{\"type\" : \"getMessages\",\"strollId\":\"$strollId\"}");
  }

  Future<void> sendMessage(int strollId, String message) async {
    await init();

    print(                "{\"type\" : \"send\",\"strollId\":\"$strollId\",\"message\":${jsonEncode(message)}}");
    channel?.stream.listen((message) {
      var jsonResult = jsonDecode(message);
      var type = jsonResult["type"] as String;

      switch (type) {
        case "ERROR_NEW_MESSAGE":
          _error((){
            channel?.sink.add(
                "{\"type\" : \"send\",\"strollId\":\"$strollId\",\"message\":${jsonEncode(message)}}");
          });
          break;
        default:
          break;
      }
    });
    channel?.sink.add(
        "{\"type\" : \"send\",\"strollId\":\"$strollId\",\"message\":${jsonEncode(message)}}");
  }

  Future<void> _error(Function tryAgain) async {
    var prefs = await SharedPreferences.getInstance();
    final someToken = prefs.getString("refreshToken");
    if (someToken == null) {
      throw MyServerException(message: "Token error");
    }
    var tokenResponse =
        await dio.post("auth/refresh", data: {"refreshToken": someToken});
    if (tokenResponse.statusCode == 200) {
      String newToken = tokenResponse.data["accessToken"];
      String refreshToken = tokenResponse.data["refreshToken"];

      await prefs.setString("accessToken", newToken);
      await prefs.setString("refreshToken", refreshToken);
      if (newToken != null) {
        channel = IOWebSocketChannel.connect(Uri.parse(HostData.SOCKET),
            headers: {"Authorization": 'Bearer $newToken'});
        tryAgain();
      } else {
        throw MyServerException(message: "Token error");
        return;
      }
    } else {
      throw MyServerException(message: "Token error");
      return;
    }
  }
}

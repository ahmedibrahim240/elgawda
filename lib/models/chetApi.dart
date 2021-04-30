import 'package:elgawda/models/userData.dart';
import 'package:elgawda/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MessageModels {
  final int id;
  final String message;
  final String sender;
  // ignore: non_constant_identifier_names
  final String created_at;

  // ignore: non_constant_identifier_names
  MessageModels({this.id, this.message, this.sender, this.created_at});
}

class ChatApi {
  static Future<List<MessageModels>> fetchAllMyMassege(int id) async {
    List<MessageModels> listOfMessage = [];

    try {
      var response = await http.get(Utils.Chat_URL + '/$id', headers: {
        'x-api-key': User.userToken,
      });
      var jsonData = json.decode(response.body);
      print(jsonData);
      if (response.statusCode == 200) {
        for (var cours in jsonData['data']) {
          MessageModels message = MessageModels(
            id: cours['id'],
            message: cours['message'],
            sender: cours['sender'],
            created_at: cours['created_at'],
          );
          listOfMessage.add(message);
        }
      }
    } catch (e) {
      print('Caht errror');

      print(e);
    }
    return listOfMessage;
  }
}
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/messages_response.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/auth_service.dart';


class ChatService with ChangeNotifier {

  User  userTo;

  Future<List<Message>> getChat( String userId ) async {

    final resp = await http.get('${ Environment.apiURL}/messages/$userId',
      headers: {
        'Contet-Type': 'application/json',
        'x-token': await AuthService.getToken()
      }
    );

    final messageResp = messagesResponseFromJson(resp.body);

    return messageResp.messages;
  }


}
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/global/environment.dart';

class AuthService with ChangeNotifier{

  Future login( String email, String password ) async {

    final data = {
      'email': email,
      'password': password
    };

    final resp = await http.post('${ Environment.apiURL }/login',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    print( resp.body );
  }

}
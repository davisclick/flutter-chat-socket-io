import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/global/environment.dart';

class AuthService with ChangeNotifier{

  User user;
  bool _authenticating = false; 

  bool get authenticating => _authenticating;
  set authenticating( bool value ){
    this._authenticating = value;
    notifyListeners();
  }

  Future login( String email, String password ) async {

    this.authenticating = true;

    print(Environment.apiURL);

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

    if( resp.statusCode == 200 ){
      final loginResponse = loginResponseFromJson( resp.body );
      this.user = loginResponse.user;
    }
    
     this.authenticating = false;
  }

}
import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/global/environment.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier{

  User user;
  bool _authenticating = false; 

  final _storage = new FlutterSecureStorage();

  bool get authenticating => _authenticating;
  set authenticating( bool value ){
    this._authenticating = value;
    notifyListeners();
  }

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

   static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
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

    this.authenticating = false;

    if( resp.statusCode == 200 ){
      final loginResponse = loginResponseFromJson( resp.body );
      this.user = loginResponse.user;
      await this._saveToken(loginResponse.token);

      return true;
    }else{
      return false;
    }
    
  }

  Future <bool> register( String name, String email, String  password ) async {

    this.authenticating = true;

    print(Environment.apiURL);

    final data = {
      'name': name,
      'email': email,
      'password': password
    };

    final resp = await http.post('${ Environment.apiURL }/login/new',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    this.authenticating = false;

    if( resp.statusCode == 200 ){
      final loginResponse = loginResponseFromJson( resp.body );
      this.user = loginResponse.user;
      await this._saveToken(loginResponse.token);

      return true;
    }else{
      return false;
    }
  }

  Future _saveToken( String token ) async {

    return await _storage.write(key: 'token', value: token);
  }

  Future _logout( String token ) async {

    return await _storage.delete(key: 'token');
  }

}


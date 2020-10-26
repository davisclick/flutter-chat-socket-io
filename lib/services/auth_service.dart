
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier{

  Future login( String email, String password ) async {

    final data = {
      'email': email,
      'password': password
    };

    //final resp = http.post(url)
  }

}
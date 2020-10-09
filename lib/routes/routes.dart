import 'package:flutter/cupertino.dart';

import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/loading_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/user_page.dart';


final Map<String, Widget Function( BuildContext )> appRoutes = {

  'user' : ( _ ) => UserPage(),
  'chat' : ( _ ) => ChatPage(),
  'login' : ( _ ) => LoginPage(),
  'register' : ( _ ) => RegisterPage(),
  'loading' : ( _ ) => LoadingPage(),

};

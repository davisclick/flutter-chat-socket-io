
import 'dart:io';

class Environment {

  static String apiURL    = Platform.isAndroid ? 'http://192.168.0.2:3000/api' : 'http://192.168.0.2:3000/api';
  static String socketURL = Platform.isAndroid ? 'http://192.168.0.2:3000' : 'http://192.168.0.2:3000';
  
}
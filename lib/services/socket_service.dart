import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/services/auth_service.dart';

enum ServerStatus{
  Online,
  Offline,
  Connecting
}


class SocketService with ChangeNotifier{

  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get  serverStatus => this._serverStatus;

  IO.Socket get socket => _socket; 
  Function get emit => this._socket.emit;
  
  void connet() async {

    final token = await AuthService.getToken();
    // Dart client
    this._socket  = IO.io( Environment.socketURL,{ //Change for your IP or localhost
      'transports' : ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {
        'x-token': token
      }
    });

    this._socket.on('connect', (_) {
     this._serverStatus = ServerStatus.Online;
     notifyListeners();
    });
    
    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

  }

 void disconnect(){
   this._socket.disconnect();
 }

}
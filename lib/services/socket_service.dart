import 'package:chat_app/global/environment.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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
  
  void connet(){

    // Dart client
    this._socket  = IO.io( Environment.socketURL,{ //Change for your IP or localhost
      'transports' : ['websocket'],
      'autoConnect': true,
      'forceNew': true
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
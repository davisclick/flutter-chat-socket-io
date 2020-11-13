import 'dart:io';
import 'package:chat_app/services/chat_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:provider/provider.dart';


class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  bool _isWriting = false;

  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {

    final chatService = Provider.of<ChatService>(context);
    final user = chatService.userMessage;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text( user.name.substring(0,2), style: TextStyle(fontSize: 12) ),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox( height:3 ),
             Text(user.name, style: TextStyle( color: Colors.black87, fontSize: 12),)
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),

     body: Container(
        child: Column(
          children:<Widget> [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: ( _, i) =>_messages[i],
                itemCount: _messages.length,
                reverse: true,
              ),
            ),
            Divider(
              height:1
            ),
            Container(
              color: Colors.white,
              child: _imputChat(),
            )

          ]
        ),
    )
      
   );
  }

  Widget _imputChat(){

     return SafeArea(
       child: Container(
         margin: EdgeInsets.symmetric( horizontal: 8.0 ),
         child: Row(
           children: [
             Flexible(
               child: TextField(
                 controller: _textController,
                 onSubmitted:_handleSummit, 
                 onChanged: ( String text ){
                  setState(() {
                    _isWriting = text.trim().length > 0 ? true : false;
                  });
                 },
                 decoration: InputDecoration.collapsed(hintText: 'Send Message'),
                 focusNode: _focusNode,

               )
            ),
            Container(
              margin: EdgeInsets.symmetric( horizontal: 4.0 ),
              child: Platform.isIOS ? 
                    CupertinoButton(
                      child: Text('Send'), 
                      onPressed: _isWriting ? () => _handleSummit( _textController.text.trim() ) : null,):

                      Container(
                        margin: EdgeInsets.symmetric( horizontal: 4.0 ),
                        child: IconTheme(
                            data: IconThemeData( color: Colors.blue[400] ),
                            child: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            icon: Icon( Icons.send ) ,
                            onPressed: _isWriting ? () => _handleSummit( _textController.text.trim() ) : null,
                          ),
                        ),

                      )
                    
            )
           ],
         )
       )
    );

   }

   _handleSummit( String text ){

     if( text.length == 0 ) return;
     
     print(text);
     _textController.clear();
     _focusNode.requestFocus();

     final newMessage = new ChatMessage(
       uid: '123',
       text: text,
       animationController: AnimationController(vsync: this, duration: Duration( milliseconds: 400 )),
     );

     _messages.insert(0, newMessage);
    newMessage.animationController.forward();

     setState(() {
        _isWriting = false;
    });
   }

   @override
  void dispose() {
    
    for( ChatMessage message in _messages ){
      message.animationController.dispose();
    }

    super.dispose();
  }
}
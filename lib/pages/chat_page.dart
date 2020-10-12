import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text( 'Te', style: TextStyle(fontSize: 12) ),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox( height:3 ),
             Text('Davis Alvarez', style: TextStyle( color: Colors.black87, fontSize: 12),)
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
                itemBuilder: ( _, i) => Text('$i'),
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
                      onPressed: (){}):
                      Container(
                        margin: EdgeInsets.symmetric( horizontal: 4.0 ),
                        child: IconButton(
                          icon: Icon( Icons.send, color: Colors.blue[400], ) ,
                          onPressed: () {},
                        ),

                      )
                    
            )
           ],
         )
       )
    );

   }

   _handleSummit( String text ){
     print(text);
     _textController.clear();
     _focusNode.requestFocus();
   }
}
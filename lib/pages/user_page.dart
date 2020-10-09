import 'package:flutter/material.dart';

import 'package:chat_app/models/user.dart';

class UserPage extends StatefulWidget {

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  final users = [
    User( uid: '1', name: 'Davis', email: 'test1@gmail.com', online: true),
    User( uid: '2', name: 'Davis', email: 'test2@gmail.com', online: false),
    User( uid: '3', name: 'Davis', email: 'test3@gmail.com', online: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Name', style: TextStyle(color: Colors.black87),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon( Icons.exit_to_app, color: Colors.black87, ), 
          onPressed: () {  },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only( right: 10 ),
            child: Icon( Icons.check_circle, color: Colors.blue[400], ),
            //child: Icon( Icons.check_circle, color: Colors.red, ),

          )
        ],
      ),
      body: ListView.separated(
        physics:  BouncingScrollPhysics(),
        itemBuilder: ( _, i ) => ListTile(
          title: Text( users[i].name ),
          leading: CircleAvatar(
            child: Text( users[i].name.substring( 0, 2 ) ),
          ),
          trailing: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: users[i].online ? Colors.green[300] : Colors.red
            )
          ),
        ),
        separatorBuilder: ( _, i ) => Divider(),
        itemCount: users.length
      )
   );
  }
}
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/users_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat_app/models/user.dart';


class UserPage extends StatefulWidget {

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  final userService = UsersService();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  List<User> users = [];

  @override
  void initState() {
    this._loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context, listen: true);

    final user = authService.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name, style: TextStyle(color: Colors.black87),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon( Icons.exit_to_app, color: Colors.black87, ), 
          onPressed: () {  
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only( right: 10 ),
            child: ( socketService.serverStatus == ServerStatus.Online )
            ? Icon( Icons.check_circle, color: Colors.blue[400], )
            : Icon( Icons.check_circle, color: Colors.red, ),

          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        //onRefresh: _loadUsers(),
        header: WaterDropHeader(
          complete: Icon( Icons.check, color: Colors.blue[400], ),
          waterDropColor: Colors.blue[400],
        ),
        child: _listViewUsers(),
      )
   );
  }

  ListView _listViewUsers() {
    return ListView.separated(
      physics:  BouncingScrollPhysics(),
      itemBuilder: ( _, i ) => _userListTile(users[i]),
      separatorBuilder: ( _, i ) => Divider(),
      itemCount: users.length
    );
  }

  ListTile _userListTile( User user ) {
    return ListTile(
        title: Text( user.name ),
        subtitle: Text( user.email ),
        leading: CircleAvatar(
          child: Text( user.name.substring( 0, 2 ) ),
          backgroundColor: Colors.blue[100],
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: user.online ? Colors.green[300] : Colors.red
          )
        ),
        onTap: (){
          final chatService = Provider.of<ChatService>(context, listen: false);
          chatService.userTo = user;
          Navigator.pushNamed(context, 'chat');
        },
      );
  }

   _loadUsers() async {

    this.users = await userService.getUsers();

    setState(() {});
    // monitor network fetch
    //await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
     _refreshController.refreshCompleted();
  }
  
}
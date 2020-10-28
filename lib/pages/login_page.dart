import 'package:chat_app/helpers/alerts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/custom_imput.dart';
import 'package:chat_app/widgets/blue_button.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Logo(
                    title: 'Messenger',
                  ),
                  _Form(),
                  Labels(
                    route: 'register',
                    title: "You don't have an account?",
                    subTitle: 'Create an account',
                  ),
                  Text('Terms and Conditions', style: TextStyle( fontWeight: FontWeight.w300 ),)
                ]
        ),
            ),
          ),
      )
   );
  }
}



class _Form extends StatefulWidget {
  _Form({Key key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: true);

    return Container(
      margin: EdgeInsets.only( top: 40 ),
      padding: EdgeInsets.symmetric( horizontal: 50 ),
       child: Column(
         children: [
          
          CustomInput(
            icon: Icons.mail_outline,
            placeHolder: 'Email',
            keyboardtype: TextInputType.emailAddress,
            textController: emailController,
            isPassword: false,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeHolder: 'Password',
            textController: passwordController,
            isPassword: true,
          ),
          
          BlueButton(
            text: 'Login',
            onPressed: authService.authenticating ? null : () async {

              FocusScope.of(context).unfocus();

              final loginOk = await authService.login(emailController.text.trim(), passwordController.text.trim());

              if( loginOk ){

              }else{
                showAlert(context, 'Incorrect login', 'Review your credentials');
              }
            },
          ),

         ]
       ),
    );
  }
}


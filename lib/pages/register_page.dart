import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/widgets/custom_imput.dart';
import 'package:chat_app/widgets/blue_button.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {

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
                    title: 'Registry',
                  ),
                  _Form(),
                  Labels(
                    route: 'login',
                    title: 'Do you have an account?',
                    subTitle: 'Login',
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

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only( top: 40 ),
      padding: EdgeInsets.symmetric( horizontal: 50 ),
       child: Column(
         children: [
          
          CustomInput(
            icon: Icons.perm_identity,
            placeHolder: 'Name',
            keyboardtype: TextInputType.text,
            textController: nameController,
          ),
          CustomInput(
            icon: Icons.mail_outline,
            placeHolder: 'Email',
            keyboardtype: TextInputType.emailAddress,
            textController: emailController,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeHolder: 'Password',
            textController: passwordController,
            isPassword: true,
          ),
          
          BlueButton(
            text: 'Registry',
            onPressed: authService.authenticating ? null : () async {
              
              final registryOk = authService.register(nameController.text.trim(), emailController.text.trim(), passwordController.text.trim());
            },
          ),

         ]
       ),
    );
  }
}


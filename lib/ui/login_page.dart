import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prac_http_api/controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _authController=Get.find<AuthController>();
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: ()=>_authController.signInWithGoogle(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/google.png'),
              Text("Click to Sign In")
            ],

          ),
        ),
      )
    );
  }
}

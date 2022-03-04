import 'package:flutter/material.dart';

class LoginController {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  verifInputField(){
    String username = usernameController.text;
    String password = passwordController.text;
    
    return username.isNotEmpty && password.isNotEmpty ;
  }

}
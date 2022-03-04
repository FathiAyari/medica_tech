import 'package:flutter/material.dart';
import 'package:medica_tech/models/user.dart';

import 'app_textfield.dart';

class AddUser extends StatefulWidget {
  final Function(String, String, String, String, int) addNewUser;
  final UserData user;

  AddUser({this.addNewUser, this.user});

  show(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: this,
          );
        });
  }

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController ageController = new TextEditingController();

  TextEditingController nameController = new TextEditingController();

  TextEditingController lastNameController = new TextEditingController();

  TextEditingController loginController = new TextEditingController();

  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    if (this.widget.user != null) {
      ageController.text = this.widget.user.age.toString();
      nameController.text = this.widget.user.name;
      lastNameController.text = this.widget.user.lastname;
      loginController.text = this.widget.user.login;
      passwordController.text = this.widget.user.password;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey[200]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Ajouter un utilisateur"),
              SizedBox(
                height: 30,
              ),
              AppTextField(
                placeholder: "Name",
                controller: nameController,
                colorTheme: Colors.blue,
              ),
              SizedBox(
                height: 10,
              ),
              AppTextField(
                placeholder: "Lastname",
                controller: lastNameController,
                colorTheme: Colors.blue,
              ),
              SizedBox(
                height: 10,
              ),
              AppTextField(
                placeholder: "Age",
                controller: ageController,
                colorTheme: Colors.blue,
              ),
              SizedBox(
                height: 10,
              ),
              AppTextField(
                placeholder: "Login",
                controller: loginController,
                colorTheme: Colors.blue,
              ),
              SizedBox(
                height: 10,
              ),
              AppTextField(
                placeholder: "Password",
                controller: passwordController,
                colorTheme: Colors.blue,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    this.widget.addNewUser(
                        nameController.text,
                        lastNameController.text,
                        loginController.text,
                        passwordController.text,
                        int.parse(ageController.text.toString()));
                  },
                  child: Text("Ajouter"))
            ],
          ),
        ));
  }
}

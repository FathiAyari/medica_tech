import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:medica_tech/Services/auth_services.dart';
import 'package:medica_tech/Services/check_login.dart';
import 'package:medica_tech/utils/constants.dart';
import 'package:medica_tech/widgets/app_button.dart';
import 'package:medica_tech/widgets/app_textfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final PrefService _prefService = PrefService();
  bool loading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/blur_background.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 500,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0x22000000)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 30, top: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/app_logo.png",
                                width: 150),
                            Text("MedicaTech",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: FONT_POPPINS_MEDIUM,
                                    fontSize: 25)),
                            const SizedBox(
                              height: 30,
                            ),
                            Text("Authentification",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: FONT_POPPINS_MEDIUM,
                                    fontSize: 15)),
                            Container(
                              height: 70,
                              child: AppTextField(
                                placeholder: "Email",
                                controller: emailController,
                                colorTheme: Colors.white,
                              ),
                            ),
                            Container(
                              height: 70,
                              child: AppTextField.password(
                                placeholder: "Mot de passe",
                                controller: passwordController,
                                colorTheme: Colors.white,
                                onSubmit: () {
                                  loginUser(context);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            loading
                                ? CircularProgressIndicator()
                                : AppButton(
                                    buttonText: "S'authentifier",
                                    onClickHandler: () {
                                      setState(() {
                                        loading = true;
                                      });
                                      loginUser(context);
                                    },
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  Get.toNamed("/");
                },
                icon: Icon(Icons.arrow_back))
          ],
        ),
      ),
    );
  }

  loginUser(BuildContext appContext) async {
    bool check;
    try {
      check = await Authservices()
          .signIn(emailController.text, passwordController.text);
      if (_formKey.currentState.validate() && check) {
        final FirebaseAuth auth = await FirebaseAuth.instance;
        final User user = await auth.currentUser;
        final uid = user.uid;
        var snapshotDetails =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        await _prefService.createCache({
          "name": snapshotDetails.get("name"),
          "role": snapshotDetails.get("role"),
          "link": snapshotDetails.get("link"),
        });
        if (snapshotDetails["role"] == "patient") {
          Get.toNamed(snapshotDetails["link"]);
        } else if (snapshotDetails["role"] == "medicin") {
          Get.toNamed(snapshotDetails["link"]);
        } else {
          Get.toNamed(snapshotDetails["link"]);
        }
      } else if (!check) {
        setState(() {
          loading = false;
        });
        show(context, loading);
      }
    } catch (e) {}
  }

  show(BuildContext context, bool loading) {
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffe3eaef),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Container(
                          height: size.height * 0.3,
                          width: size.width * 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Votre informations confidentielle sont incorrectes",
                                style: TextStyle(
                                    fontFamily: "Tajawal", fontSize: 20),
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: EdgeInsets.all(15),
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("Ressayer")),
                            ],
                          )),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      )),
                ],
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            );
          });
        });
  }
}

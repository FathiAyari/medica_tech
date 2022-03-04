import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:medica_tech/Services/check_login.dart';
import 'package:medica_tech/patient/folder_details.dart';
import 'package:medica_tech/patient/folder_field.dart';
import 'package:medica_tech/temp/homepage.dart';
import 'package:medica_tech/utils/constants.dart';

class DashbaordScreen extends StatefulWidget {
  @override
  _DashbaordScreenState createState() => _DashbaordScreenState();
}

var userCollection = FirebaseFirestore.instance
    .collection('folders')
    .orderBy("date", descending: true);

class _DashbaordScreenState extends State<DashbaordScreen> {
  bool switcherValue = false;
  String pageTitle = "Screen List";
  TextEditingController folderController = TextEditingController();
  DISPLAYED_SECTION displayedSection = DISPLAYED_SECTION.SCREENS;
  Map items;
  final PrefService _prefService = PrefService();
  void getToken() async {
    await _prefService.readCache().then((value) {
      if (value != null) {
        setState(() {
          items = value;
          print(items);
        });
      } else {
        print("z");
      }
    });
  }

  @override
  void initState() {
    getToken();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.white.withOpacity(0),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 350,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.blue[300],
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Image.asset("assets/images/app_logo.png",
                                width: 120),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => HomePage());
                                  _prefService.removeCache();
                                },
                                child: Text(
                                  "Logout",
                                  style: TextStyle(fontSize: 12),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue[400])),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Get.toNamed("/messages_patient");
                                },
                                label: Text("Messages"),
                                icon: Icon(Icons.message_rounded),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue[400])),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 10,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Votre dossiers medicales",
                                style: TextStyle(fontSize: 40),
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage("assets/images/avatar.png"),
                                  ),
                                  Text(
                                    " Bonjour ${items['name']}",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(15),
                              ),
                              onPressed: () {
                                show(context);
                              },
                              child: Text("Ajouter un dossier")),
                        ],
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: userCollection.snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data.size,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: size.height * 0.01,
                                      right: size.width * 0.1,
                                      left: size.width * 0.03),
                                  child: Container(
                                    height: size.height * 0.2,
                                    decoration: BoxDecoration(
                                        color: snapshot.data.docs[index]
                                                    .get("cnam") ==
                                                "Accepté"
                                            ? Colors.green.withOpacity(0.5)
                                            : Colors.blueAccent
                                                .withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(() => FolderDetails(
                                              folderName:
                                                  "${snapshot.data.docs[index].reference.id}",
                                            ));
                                      },
                                      child: ListTile(
                                        title: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        "Nom: ${snapshot.data.docs[index].reference.id}"),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                                "Etat de dossier chez le CNAM: ${snapshot.data.docs[index].get("cnam")}"),
                                                          ],
                                                        ),
                                                        Text(
                                                            "Etat de dossier chez le medecin: ${snapshot.data.docs[index].get("treatement")}"),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                                child: Text("pas de dossiers pour le moment "));
                          }
                        },
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  show(BuildContext context) {
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
                              const Text(
                                "Tapez le nom de votre dossier ",
                                style: TextStyle(
                                    fontFamily: "Tajawal", fontSize: 20),
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              FolderField(
                                controller: folderController,
                                hintText: "nom de dossier",
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
                                    FirebaseFirestore.instance
                                        .collection('folders')
                                        .doc("${folderController.text}")
                                        .set({
                                      'treatement': 'Aucune',
                                      'cnam': 'Aucune',
                                      'date': DateTime.now()
                                    });
                                    Get.back();
                                    Get.rawSnackbar(
                                      borderRadius: 20,
                                      backgroundColor:
                                          Colors.green.withOpacity(0.9),
                                      titleText: const Text(
                                        "Medica Tech",
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.white),
                                      ),
                                      messageText: Text(
                                        "Dossier ajouté avec succès",
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.white),
                                      ),
                                      icon: Icon(Icons.done_all,
                                          color: Colors.white),
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                    folderController.clear();
                                  },
                                  child: Text("Confirmer")),
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

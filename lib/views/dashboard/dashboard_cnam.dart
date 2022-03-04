import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:medica_tech/Services/check_login.dart';
import 'package:medica_tech/temp/homepage.dart';
import 'package:medica_tech/utils/constants.dart';

class DsashboardCnam extends StatefulWidget {
  @override
  _DashbaordScreenState createState() => _DashbaordScreenState();
}

var userCollection = FirebaseFirestore.instance.collection('folders').where(
      "treatement",
      isNotEqualTo: "Aucune",
    );

class _DashbaordScreenState extends State<DsashboardCnam> {
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
      } else {}
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
                                "Les dossiers medicales",
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
                                    " Bonjour  ${items['name']}",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                                                      Text(
                                                          "Etat de dossier chez le CNAM: ${snapshot.data.docs[index].get("cnam")}"),
                                                      Text(
                                                          "Traitement de dossier chez le medecin: ${snapshot.data.docs[index].get("treatement")}"),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Colors
                                                                .green
                                                                .withOpacity(
                                                                    0.5),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    15),
                                                          ),
                                                          onPressed: () {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "folders")
                                                                .doc(
                                                                    "${snapshot.data.docs[index].reference.id}")
                                                                .update({
                                                              "cnam": "Accepté"
                                                            });
                                                          },
                                                          child: Text(
                                                              "Accepter le dossier")),
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Colors.red
                                                                .withOpacity(
                                                                    0.5),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    15),
                                                          ),
                                                          onPressed: () {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "folders")
                                                                .doc(
                                                                    "${snapshot.data.docs[index].reference.id}")
                                                                .update({
                                                              "cnam": "Refusé"
                                                            });
                                                          },
                                                          child: Text(
                                                              "Refuser le  dossier")),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
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
}

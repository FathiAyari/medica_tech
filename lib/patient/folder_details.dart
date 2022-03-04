import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';
import 'package:medica_tech/Services/check_login.dart';
import 'package:medica_tech/charts/chart.dart';

import 'folder_field.dart';

class FolderDetails extends StatefulWidget {
  final String folderName;
  const FolderDetails({Key key, this.folderName}) : super(key: key);

  @override
  _FolderDetailsState createState() => _FolderDetailsState();
}

class _FolderDetailsState extends State<FolderDetails> {
  TextEditingController mesureController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final PrefService _prefService = PrefService();
  bool looged = false;
  String role = "";
  DateTime dateController;

  getToken() async {
    Map details = await _prefService.readCache().then((value) {
      if (value != null) {
        setState(() {
          looged = true;
          role = value['role'];
        });
      } else {}
    });
    return details;
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "${widget.folderName}",
            style: TextStyle(fontSize: 40, color: Colors.blue),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    width: size.width * 0.5,
                    child: Chart(
                      label: "stauration d'oxygene (SPO2) ",
                      collection: "Spo2",
                      document: "${widget.folderName}",
                    )),
                Container(
                    width: size.width * 0.5,
                    child: Chart(
                      label: "rythme cardiaque (bpm) ",
                      collection: "bpm",
                      document: "${widget.folderName}",
                    )),
              ],
            ),
            Row(
              children: [
                Container(
                    width: size.width * 0.5,
                    child: Chart(
                      label: "tension systolique  (mm/Hg) ",
                      collection: "Systole",
                      document: "${widget.folderName}",
                    )),
                Container(
                    width: size.width * 0.5,
                    child: Chart(
                      label: "tension systolique  (mm/Hg) ",
                      collection: "Diastole",
                      document: "${widget.folderName}",
                    )),
              ],
            ),
          ],
        ),
        floatingActionButton: role == "medicin"
            ? buildSpeedDialMedicin(context)
            : buildSpeedDialPatient(context));
  }

  SpeedDial buildSpeedDialPatient(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      label: Text("Ajouter..."),
      children: [
        SpeedDialChild(
            onTap: () {
              showMesure(context, "bpm/m", "bpm");
            },
            child: Icon(
              Icons.bloodtype,
              color: Colors.blueAccent,
            ),
            label: 'Mesure de  rythme cardiaque'),
        SpeedDialChild(
            onTap: () {
              showMesure(context, "%", "Spo2");
            },
            child: Icon(
              Icons.waterfall_chart,
              color: Colors.blueAccent,
            ),
            label: "Mesure  saturation d'oxygène "),
        SpeedDialChild(
            onTap: () {
              showMesure(context, "mm/Hg", "Systole");
            },
            child: Icon(
              Icons.show_chart,
              color: Colors.blueAccent,
            ),
            label: 'Mesure de tension systolique'),
        SpeedDialChild(
            onTap: () {
              showMesure(context, "mm/Hg", "Diastole");
            },
            child: Icon(
              Icons.show_chart,
              color: Colors.blueAccent,
            ),
            label: 'Mesure de tension diastolique'),
      ],
    );
  }

  SpeedDial buildSpeedDialMedicin(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      label: Text("Ajouter..."),
      children: [
        SpeedDialChild(
            onTap: () {
              showTreatement(context);
            },
            child: Icon(
              Icons.bloodtype,
              color: Colors.blueAccent,
            ),
            label: 'Ajouter une traitement'),
      ],
    );
  }

  showMesure(BuildContext context, String unit, String mesureType) {
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
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Ajouter une  valeur de mesure en ${unit} ",
                                  style: TextStyle(
                                      fontFamily: "Tajawal", fontSize: 20),
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                FolderField(
                                  controller: mesureController,
                                  hintText: "Valuer en ${unit}",
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2022),
                                              lastDate: DateTime(2023))
                                          .then((value) {
                                        setState(() {
                                          dateController = value;
                                        });
                                      });
                                    },
                                    child: Text(dateController == null
                                        ? " Date de mesure"
                                        : DateFormat('yyyy-MM-dd')
                                            .format(dateController))),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: EdgeInsets.all(15),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        FirebaseFirestore.instance
                                            .collection("folders")
                                            .doc("${widget.folderName}")
                                            .collection("${mesureType}")
                                            .add({
                                          'value': int.parse(
                                              "${mesureController.text}"),
                                          'date': dateController
                                        });
                                        Get.back();
                                        Get.rawSnackbar(
                                          borderRadius: 20,
                                          backgroundColor:
                                              Colors.green.withOpacity(0.9),
                                          titleText: const Text(
                                            "Medica Tech",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white),
                                          ),
                                          messageText: Text(
                                            "Mesure  ajouté avec succès",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white),
                                          ),
                                          icon: Icon(Icons.done_all,
                                              color: Colors.white),
                                        );
                                        mesureController.clear();
                                        setState(() {
                                          dateController = null;
                                        });
                                      }
                                    },
                                    child: Text("Confirmer")),
                              ],
                            ),
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

  showTreatement(BuildContext context) {
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
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Ajouter une  Traitement ",
                                  style: TextStyle(
                                      fontFamily: "Tajawal", fontSize: 20),
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                FolderField(
                                  controller: mesureController,
                                  hintText: "Traitement",
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
                                      if (_formKey.currentState.validate()) {
                                        FirebaseFirestore.instance
                                            .collection("folders")
                                            .doc("${widget.folderName}")
                                            .update({
                                          "treatement":
                                              "${mesureController.text}"
                                        });
                                        Get.back();
                                        Get.rawSnackbar(
                                          borderRadius: 20,
                                          backgroundColor:
                                              Colors.green.withOpacity(0.9),
                                          titleText: const Text(
                                            "Medica Tech",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white),
                                          ),
                                          messageText: Text(
                                            "Traitement   ajouté avec succès",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white),
                                          ),
                                          icon: Icon(Icons.done_all,
                                              color: Colors.white),
                                        );
                                        mesureController.clear();
                                        setState(() {
                                          dateController = null;
                                        });
                                      }
                                    },
                                    child: Text("Confirmer")),
                              ],
                            ),
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

import 'dart:html';

import 'package:flutter/material.dart';

import 'app_textfield.dart';

class AddScreen extends StatefulWidget {
  final Function(String, String, String) addNewScreen;
  final Screen screen;

  AddScreen({this.addNewScreen, this.screen});

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
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController nameController = new TextEditingController();

  TextEditingController startDateController = new TextEditingController();

  TextEditingController endDateController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey[200]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Ajouter un screen"),
              SizedBox(
                height: 10,
              ),
              AppTextField(
                placeholder: "Name",
                controller: nameController,
                colorTheme: Colors.blue,
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050),
                          initialDate: DateTime.now())
                      .then((value) {
                    if (value != null) {
                      var date = "${value.year}/${value.month}/${value.day}";
                      TimeOfDay initialTime = TimeOfDay.now();
                      showTimePicker(
                        context: context,
                        initialTime: initialTime,
                      ).then((value) {
                        if (value != null) {
                          startDateController.text =
                              "$date ${value.hour}:${value.minute}";
                        }
                      });
                    }
                  });
                },
                child: AppTextField(
                  placeholder: "Start date",
                  controller: startDateController,
                  colorTheme: Colors.blue,
                  enabled: false,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050),
                          initialDate: DateTime.now())
                      .then((value) {
                    if (value != null) {
                      var date = "${value.year}/${value.month}/${value.day}";
                      TimeOfDay initialTime = TimeOfDay.now();
                      showTimePicker(
                        context: context,
                        initialTime: initialTime,
                      ).then((value) {
                        if (value != null) {
                          endDateController.text =
                              "$date ${value.hour}:${value.minute}";
                        }
                      });
                    }
                  });
                },
                child: AppTextField(
                  placeholder: "End date",
                  controller: endDateController,
                  colorTheme: Colors.blue,
                  enabled: false,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    this.widget.addNewScreen(nameController.text,
                        startDateController.text, endDateController.text);
                  },
                  child: Text("Ajouter"))
            ],
          ),
        ));
  }
}

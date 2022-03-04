import 'package:flutter/material.dart';
import 'package:medica_tech/models/media.dart';

import 'app_textfield.dart';
import 'info_message.dart';

class AddMedia extends StatefulWidget {
  final Function addNewMedia;
  final MediaObject media;

  AddMedia({this.addNewMedia, this.media});

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
  State<AddMedia> createState() => _AddMediaState();
}

class _AddMediaState extends State<AddMedia> {
  TextEditingController linkController = TextEditingController();

  TextEditingController startTimeController = TextEditingController();

  TextEditingController endTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (this.widget.media != null) {
      linkController.text = this.widget.media.mediaLink;
      startTimeController.text = this.widget.media.startTime;
      endTimeController.text = this.widget.media.endTime;
    }
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
              Text("Ajouter une media"),
              SizedBox(
                height: 10,
              ),
              AppTextField(
                placeholder: "Media link",
                controller: linkController,
                colorTheme: Colors.blue,
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  TimeOfDay initialTime = TimeOfDay.now();
                  if (endTimeController.text.isNotEmpty) {
                    initialTime = TimeOfDay(
                        hour: int.parse(endTimeController.text.split(":")[0]),
                        minute:
                            int.parse(endTimeController.text.split(":")[1]));
                  }
                  showTimePicker(
                    context: context,
                    initialTime: initialTime,
                  ).then((value) {
                    if (value != null) {
                      if (endTimeController.text.isNotEmpty) {
                        var endTime = TimeOfDay(
                            hour:
                                int.parse(endTimeController.text.split(":")[0]),
                            minute: int.parse(
                                endTimeController.text.split(":")[1]));
                        var startTime = value;
                        int end = endTime.hour * 60 + endTime.minute;
                        int start = startTime.hour * 60 + startTime.minute;
                        if ((start - end) <= 0) {
                          startTimeController.text =
                              "${value.hour}:${value.minute}";
                        } else {
                          InfoMessage(
                                  message:
                                      "Date debut ne doit pas être supérieure au date fin")
                              .show(context);
                        }
                      } else {
                        startTimeController.text =
                            "${value.hour}:${value.minute}";
                      }
                    }
                  });
                },
                child: AppTextField(
                  placeholder: "Start time",
                  controller: startTimeController,
                  colorTheme: Colors.blue,
                  enabled: false,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  TimeOfDay initialTime = TimeOfDay.now();
                  if (startTimeController.text.isNotEmpty) {
                    initialTime = TimeOfDay(
                        hour: int.parse(startTimeController.text.split(":")[0]),
                        minute:
                            int.parse(startTimeController.text.split(":")[1]));
                  }
                  showTimePicker(
                    context: context,
                    initialTime: initialTime,
                  ).then((value) {
                    if (value != null) {
                      if (startTimeController.text.isNotEmpty) {
                        var startTime = TimeOfDay(
                            hour: int.parse(
                                startTimeController.text.split(":")[0]),
                            minute: int.parse(
                                startTimeController.text.split(":")[1]));
                        var endTime = value;
                        int start = startTime.hour * 60 + startTime.minute;
                        int end = endTime.hour * 60 + endTime.minute;
                        if ((start - end) < 0) {
                          endTimeController.text =
                              "${value.hour}:${value.minute}";
                        } else {
                          InfoMessage(
                                  message:
                                      "Date fin ne doit pas être inferieure au date debut")
                              .show(context);
                        }
                      } else {
                        endTimeController.text =
                            "${value.hour}:${value.minute}";
                      }
                    }
                  });
                },
                child: AppTextField(
                  placeholder: "End time",
                  controller: endTimeController,
                  colorTheme: Colors.blue,
                  enabled: false,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    this.widget.addNewMedia.call(linkController.text,
                        startTimeController.text, endTimeController.text);
                  },
                  child: Text("Ajouter"))
            ],
          ),
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medica_tech/messenger/messenger_patient.dart';

class MessagesPatient extends StatefulWidget {
  const MessagesPatient({Key key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<MessagesPatient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Messages",
            style: TextStyle(color: Colors.blueAccent),
          ),
          centerTitle: true,
        ),
        body: MessengerPatient());
  }
}

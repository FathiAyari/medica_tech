import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medica_tech/messenger/messenger_medicin.dart';

class MessagesMedicin extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<MessagesMedicin> {
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
        body: MessengerMedicin());
  }
}

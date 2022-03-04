import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoMessage extends StatelessWidget {
  final String message;

  InfoMessage({ this.message});

  show(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: this,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(this.message),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Confirmer"))
        ],
      ),
    );
  }
}

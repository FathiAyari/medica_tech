import 'package:flutter/material.dart';

class TabMenuButton extends StatelessWidget {
  final String title;

  TabMenuButton({ this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Center(
        child: Text(this.title),
      ),
    );
  }
}

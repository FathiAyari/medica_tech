import 'package:flutter/material.dart';
import 'package:medica_tech/utils/constants.dart';

class AppLoading extends StatelessWidget {
  show(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: this,
            contentPadding: EdgeInsets.all(0),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            const SizedBox(
              height: 10,
            ),
            Text("Chargement en cours",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: FONT_POPPINS_MEDIUM,
                    fontSize: 15)),
          ],
        ),
      ),
    );
  }
}

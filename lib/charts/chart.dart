import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medica_tech/models/spo2Model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

var snapshot = FirebaseFirestore.instance;

class Chart extends StatefulWidget {
  final String collection;
  final String document;
  final String label;
  Chart({Key key, this.collection, this.label, this.document})
      : super(key: key);
  @override
  _Spo2ChartState createState() => _Spo2ChartState();
}

class _Spo2ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: snapshot
              .collection('folders')
              .doc("${widget.document}")
              .collection("${widget.collection}")
              .orderBy('date')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var test = snapshot.data.docs.toList();
              List<SPo2> result = [];
              for (var test1 in test) {
                result.add(SPo2(
                    value: test1.get('value'),
                    date: (test1.get('date').toDate())));
              }
              return SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                tooltipBehavior: TooltipBehavior(enable: true),
                title: ChartTitle(text: " Courbe de ${widget.label}"),
                legend: Legend(isVisible: true),
                series: <ChartSeries<SPo2, String>>[
                  LineSeries<SPo2, String>(
                      dataSource: result,
                      xValueMapper: (SPo2 SPo2, _) =>
                          SPo2.date.toString().split(" ")[0],
                      yValueMapper: (SPo2 SPo2, _) => SPo2.value,
                      name: "Valeur de ${widget.label}",
                      animationDelay: 50,
                      dataLabelSettings: DataLabelSettings(isVisible: true)),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

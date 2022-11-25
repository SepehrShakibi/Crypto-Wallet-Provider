import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomePageChartMiddle extends StatefulWidget {
  final Color beginChartColor;
  final Color endChartColor;

  final Color beginBleowChartColor;
  final Color endBleowChartColor;
  final String currency;
  final List<double> spotlist;

  const HomePageChartMiddle(
      {Key? key,
      required this.beginChartColor,
      required this.endChartColor,
      required this.beginBleowChartColor,
      required this.endBleowChartColor,
      required this.currency,
      required this.spotlist})
      : super(key: key);

  @override
  State<HomePageChartMiddle> createState() => _HomePageChartMiddleState();
}

class _HomePageChartMiddleState extends State<HomePageChartMiddle> {
  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
      //  lineTouchData: LineTouchData(enabled: false),
      backgroundColor: Colors.transparent,
      borderData: FlBorderData(show: false),
      gridData: FlGridData(show: false
          //drawHorizontalLine: false
          ),
      titlesData: FlTitlesData(show: false),
      // minX: 0,
      minY: widget.spotlist
          .reduce((value, element) => value < element ? value : element),
      maxY: widget.spotlist
          .reduce((value, element) => value > element ? value : element),
      lineBarsData: [
        LineChartBarData(
            spots: [
              FlSpot(0, widget.spotlist[0]),
              FlSpot(1, widget.spotlist[1]),
              FlSpot(2, widget.spotlist[2]),
              FlSpot(3, widget.spotlist[3]),
              FlSpot(4, widget.spotlist[4]),
              FlSpot(5, widget.spotlist[5]),
              FlSpot(6, widget.spotlist[6]),
              FlSpot(7, widget.spotlist[7]),
              FlSpot(8, widget.spotlist[8]),
              FlSpot(9, widget.spotlist[9]),
              FlSpot(10, widget.spotlist[10]),
              FlSpot(11, widget.spotlist[11]),

              // FlSpot(0, 1),
              // FlSpot(1, 2),
              // FlSpot(2, 3),
              // FlSpot(3, 4),
              // FlSpot(4, 5),
              // FlSpot(5, 6),
              // FlSpot(6, 7),
              // FlSpot(7, 8),
              // FlSpot(8, 6),
              // FlSpot(9, 6),
              // FlSpot(10, 7),
              // FlSpot(11, 7),
            ],
            isCurved: true,
            barWidth: 3,
            //  color: Colors.teal,
            gradient: LinearGradient(colors: [
              widget.beginChartColor,
              widget.endChartColor,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            belowBarData: BarAreaData(
                show: true,
                // color: Colors.green.shade500,
                gradient: LinearGradient(colors: [
                  widget.beginBleowChartColor,
                  widget.endBleowChartColor,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            dotData: FlDotData(show: false)),
      ],
    ));
  }
}

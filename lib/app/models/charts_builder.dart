import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pamiw/app/models/each_day_progress.dart';
import 'package:pamiw/main.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class _LineChart extends StatefulWidget {
  const _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  State<_LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<_LineChart> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return LineChart(
      widget.isShowingMainData ? sampleData1 : sampleData1,
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 31,
        maxY: 100,
        minY: 0,
      );

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: 14,
        maxY: 100,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.black.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
      ];

  LineTouchData get lineTouchData2 => const LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 20:
        text = '20%';
        break;
      case 40:
        text = '40%';
        break;
      case 60:
        text = '60%';
        break;
      case 80:
        text = '80%';
        break;
      case 100:
        text = '100%';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 45,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;

    switch (value.toInt()) {
      case 5:
        text = Text(
            DateFormat('d').format(now.subtract(const Duration(days: 25))),
            style: style);
        break;
      case 10:
        text = Text(
            DateFormat('d').format(now.subtract(const Duration(days: 20))),
            style: style);
        break;
      case 15:
        text = Text(
            DateFormat('d').format(now.subtract(const Duration(days: 15))),
            style: style);
        break;
      case 20:
        text = Text(
            DateFormat('d').format(now.subtract(const Duration(days: 10))),
            style: style);
        break;
      case 25:
        text = Text(
            DateFormat('d').format(now.subtract(const Duration(days: 5))),
            style: style);
        break;
      case 30:
        text = Text(DateFormat('d').format(now), style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(width: 4),
          left: BorderSide(),
          right: BorderSide(),
          top: BorderSide(),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: false,
        color: Colors.green,
        barWidth: 6,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: [
          FlSpot(
              1,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 29))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              2,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 28))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              3,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 27))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              4,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 26))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              5,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 25))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              6,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 24))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              7,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 23))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              8,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 22))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              9,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 21))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              10,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 20))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              11,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 19))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              12,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 18))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              13,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 17))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              14,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 16))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              15,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 15))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              16,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 14))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              17,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 13))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              18,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 12))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              19,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 11))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              20,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 10))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              21,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 9))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              22,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 8))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              23,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 7))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              24,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 6))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              25,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 5))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              26,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 4))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              27,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 3))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              28,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 2))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              29,
              eachDayProgress[int.parse(DateFormat('d')
                      .format(now.subtract(const Duration(days: 1))))]
                  .geteachDayProgress.toDouble()),
          FlSpot(
              30,
              eachDayProgress[int.parse(DateFormat('d').format(now))]
                  .geteachDayProgress.toDouble()),
        ],
      );
}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  late bool isShowingMainData;

  @override
  void initState() {
    isShowingMainData = true;
    loadProgressData();
    super.initState();
  }

  Future loadProgressData() async {
    List<EachDayProgress> resProgressList = [];

    Response resProgress;
    Dio dioProgress = Dio();
    resProgress = await dioProgress.get(
        'https://us-central1-pamiw-projekt-529bb.cloudfunctions.net/users/${FirebaseAuth.instance.currentUser!.uid}/eachDayProgress');

    Map<String, dynamic> data = json.decode(resProgress.toString()) ?? [];

    for (var progressData in data['eachDayProgress']) {
      EachDayProgress each = EachDayProgress.fromMap(progressData);
      resProgressList.add(each);
    }
    eachDayProgress = resProgressList;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 4,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 6),
                    child: _LineChart(isShowingMainData: isShowingMainData),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

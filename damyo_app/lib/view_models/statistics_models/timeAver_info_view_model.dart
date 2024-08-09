import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

double UserMax = 20, EveryMax = 50;

LineChartData timeSmokeAver(bool timeCheck) {
  return LineChartData(
    lineTouchData: lineTouchData(),
    gridData: gridData(),
    titlesData: timetitlesData(),
    borderData: curveborderData(),
    lineBarsData: lineBarsData(timeCheck),
    minX: 0,
    maxX: 24,
    maxY: (UserMax == 0 && EveryMax == 0)
        ? 60
        : (UserMax > EveryMax)
            ? UserMax
            : EveryMax,
    minY: 0,
  );
}

LineTouchData lineTouchData() {
  return LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.8),
    ),
  );
}

FlTitlesData timetitlesData() {
  return FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles(),
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
}

List<LineChartBarData> lineBarsData(bool timeCheck) {
  return [
    lineChartBarDataEvery(timeCheck),
    lineChartBarDataUser(timeCheck),
  ];
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 10,
  );
  int text;
  text = value.toInt();
  return Text('$text', style: style, textAlign: TextAlign.center);
}

SideTitles leftTitles() {
  return const SideTitles(
    getTitlesWidget: leftTitleWidgets,
    showTitles: true,
    interval: 10,
    reservedSize: 20,
  );
}

Widget timeLineWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('00시', style: style);
      break;
    case 3:
      text = const Text('03시', style: style);
      break;
    case 6:
      text = const Text('06시', style: style);
      break;
    case 9:
      text = const Text('09시', style: style);
      break;
    case 12:
      text = const Text('12시', style: style);
      break;
    case 15:
      text = const Text('15시', style: style);
      break;
    case 18:
      text = const Text('18시', style: style);
      break;
    case 21:
      text = const Text('21시', style: style);
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

SideTitles bottomTitles() {
  return const SideTitles(
    showTitles: true,
    reservedSize: 30,
    interval: 1,
    getTitlesWidget: timeLineWidgets,
  );
}

FlGridData gridData() {
  return const FlGridData(
    show: true,
    drawHorizontalLine: true,
    horizontalInterval: 10,
    drawVerticalLine: false,
  );
}

FlBorderData curveborderData() {
  return FlBorderData(
    show: true,
    border: const Border(
      bottom: BorderSide(color: Colors.grey, width: 2),
      left: BorderSide(color: Colors.transparent),
      right: BorderSide(color: Colors.transparent),
      top: BorderSide(color: Colors.transparent),
    ),
  );
}

List<dynamic> EveryList = [10.0, 10.0, 10.0, 10.0, 10.0, 10.0];
Map<String, double>? UserList = {};


LineChartBarData lineChartBarDataUser(bool timeCheck) {
  return LineChartBarData(
      isCurved: true,
      preventCurveOverShooting: true,
      gradient: LinearGradient(
        colors: timeCheck
            ? [
                const Color(0xFFD6ECFA),
                const Color(0xFF0099FC),
              ]
            : [
                const Color(0x7FD2D7DD),
                const Color(0x7FD2D7DD),
              ],
      ),
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(9, (index) {
        if (UserList?['${index * 3}'] != null) {
          double? y = UserList!['${index * 3}'];
          return FlSpot(index * 3, y!);
        } else {
          return FlSpot(index * 3, 0);
        }
      }));
}

LineChartBarData lineChartBarDataEvery(bool timeCheck) {
  return LineChartBarData(
      isCurved: true,
      preventCurveOverShooting: true,
      gradient: LinearGradient(
        colors: timeCheck
            ? [
                const Color(0xFFD2D7DD),
                const Color(0xFFD2D7DD),
              ]
            : [
                const Color(0xFFD6ECFA),
                const Color(0xFF0099FC),
              ],
      ),
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(EveryList!.length, (index) {
        return FlSpot(index * 3, EveryList![index]);
      }));
}

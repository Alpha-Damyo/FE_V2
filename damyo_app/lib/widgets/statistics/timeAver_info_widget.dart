import 'package:damyo_app/style.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// 시간대별 평균 흡연량 그래프
Widget timeAverInfo(
    BuildContext context,
    bool timeCheck,
    List<dynamic>? EveryList,
    Map<String, dynamic>? UserList,
    Function(bool) onTimeCheck) {
  return Container(
    width: double.infinity,
    height: 400,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textFormat(
                  text: '시간별 평균 흡연량',
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () => onTimeCheck(true),
                child: textFormat(
                    text: '나',
                    textAlign: TextAlign.right,
                    color: timeCheck
                        ? const Color(0xFF0099FC)
                        : const Color(0xFFD1D6DC),
                    fontSize: 12)),
            TextButton(
                onPressed: () => onTimeCheck(false),
                child: textFormat(
                    text: '전체',
                    textAlign: TextAlign.right,
                    color: timeCheck
                        ? const Color(0xFFD1D6DC)
                        : const Color(0xFF0099FC),
                    fontSize: 12)),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: LineChart(
              timeSmokeAver(timeCheck, EveryList, UserList),
              duration: const Duration(milliseconds: 250),
            ),
          ),
        ),
      ],
    ),
  );
}


LineChartData timeSmokeAver(
    bool timeCheck, List<dynamic>? EveryList, Map<String, dynamic>? UserList) {
  
  double EveryMax = 0, UserMax = 0;
  
  for (int i = 0; i < EveryList!.length; i++) {
    if (EveryList[i] > EveryMax) {
      EveryMax = EveryList[i];
    }
  }

  for (int i = 0; i < 9; i++) {
    if (UserList!['${i * 3}'] != null && (UserList['${i * 3}']! > UserMax)) {
      UserMax = UserList['${i * 3}']!;
    }
  }

  int UptoMax(double val){
    return ((val/10).toInt() + 1)*10;
  }

  return LineChartData(
    lineTouchData: lineTouchData(),
    gridData: gridData(),
    titlesData: timetitlesData(),
    borderData: curveborderData(),
    lineBarsData: lineBarsData(timeCheck, EveryList, UserList),
    minX: 0,
    maxX: 24,
    maxY: (UserMax == 0 && EveryMax == 0)
        ? 40
        : (UserMax > EveryMax)
            ? UptoMax(UserMax) + 20
            : UptoMax(EveryMax) + 20,
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

List<LineChartBarData> lineBarsData(
    bool timeCheck, List<dynamic>? EveryList, Map<String, dynamic>? UserList) {
  return [
    lineChartBarDataEvery(timeCheck, EveryList),
    lineChartBarDataUser(timeCheck, UserList),
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

LineChartBarData lineChartBarDataUser(
    bool timeCheck, Map<String, dynamic>? UserList) {
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

LineChartBarData lineChartBarDataEvery(
    bool timeCheck, List<dynamic>? EveryList) {
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

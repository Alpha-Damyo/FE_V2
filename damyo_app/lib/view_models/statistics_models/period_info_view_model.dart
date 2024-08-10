import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

FlBorderData createBorderData() {
  return FlBorderData(
    show: false,
  );
}

FlGridData createGridData() {
  return const FlGridData(
    show: false,
    drawHorizontalLine: true,
    horizontalInterval: 10,
    drawVerticalLine: false,
  );
}

BarTouchData createPeriodCompare() {
  return BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      getTooltipColor: (group) => Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem: (
        BarChartGroupData group,
        int groupIndex,
        BarChartRodData rod,
        int rodIndex,
      ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          const TextStyle(
            color: Colors.cyan,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );
}

// '일'로 설정했을 때
Widget createDayCompare(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = '월';
      break;
    case 1:
      text = '화';
      break;
    case 2:
      text = '수';
      break;
    case 3:
      text = '목';
      break;
    case 4:
      text = '금';
      break;
    case 5:
      text = '토';
      break;
    case 6:
      text = '일';
      break;
    default:
      text = '';
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 4,
    child: Text(text, style: style),
  );
}

// '주'로 설정했을 때
Widget createWeekCompare(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = '이번주';
      break;
    case 1:
      text = '1주전';
      break;
    case 2:
      text = '2주전';
      break;
    case 3:
      text = '3주전';
      break;
    default:
      text = '';
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 4,
    child: Text(text, style: style),
  );
}

// '월'로 설정했을 때
Widget createMonthCompare(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = '이번달';
      break;
    case 1:
      text = '1달전';
      break;
    case 2:
      text = '2달전';
      break;
    case 3:
      text = '3달전';
      break;
    case 4:
      text = '4달전';
      break;
    case 5:
      text = '5달전';
      break;
    default:
      text = '';
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 4,
    child: Text(text, style: style),
  );
}

SideTitles createLeftTitles() {
  return const SideTitles(
    getTitlesWidget: createLeftTitleWidgets,
    showTitles: false,
    interval: 10,
    reservedSize: 20,
  );
}

Widget createLeftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 10,
  );
  int text = value.toInt();

  return Text('$text', style: style, textAlign: TextAlign.center);
}

FlTitlesData createDayTitlesCompare() {
  return FlTitlesData(
    show: true,
    bottomTitles: const AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: createDayCompare,
      ),
    ),
    leftTitles: AxisTitles(
      sideTitles: createLeftTitles(),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(
        showTitles: false,
        reservedSize: 30,
      ),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );
}

FlTitlesData createWeekTitlesCompare() {
  return FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: createWeekCompare,
      ),
    ),
    leftTitles: AxisTitles(
      sideTitles: createLeftTitles(),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(
        showTitles: false,
        reservedSize: 30,
      ),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );
}

FlTitlesData createMonthTitlesCompare() {
  return FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: createMonthCompare,
      ),
    ),
    leftTitles: AxisTitles(
      sideTitles: createLeftTitles(),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(
        showTitles: false,
        reservedSize: 30,
      ),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );
}

// List<BarChartGroupData> createBarDaysCompare(
//     List<double?>? smokeWeekdayInfo,
//     List<double?>? everyDayWeek,
//     bool compareCheck,
//   ) {
//   return [
//     for (int i = 0; i < smokeWeekdayInfo!.length; i++)
//       createGroupData(i, smokeWeekdayInfo[i] * 1.0, everyDayWeek?[i + 1], compareCheck)
//   ];
// }

// List<BarChartGroupData> createBarWeeksCompare(
//     List<double?>? smokeWeeksInfo,
//     List<double?>? everyWeeks,
//     bool compareCheck,
//   ) {
//   return [
//     for (int i = 0; i < smokeWeeksInfo!.length; i++)
//       createGroupData(i, smokeWeeksInfo[i] * 1.0, everyWeeks?[i + 1], compareCheck)
//   ];
// }

// List<BarChartGroupData> createBarMonthsCompare(
//     List<double?>? smokeMonthsInfo,
//     List<double?>? everyMonths,
//     int nowMonth,
//     bool compareCheck,
//   ) {
//   return [
//     for (int i = 0; i < smokeMonthsInfo!.length; i++)
//       createGroupData(i, smokeMonthsInfo[i] * 1.0, everyMonths?[(nowMonth + 12 - i) % 12], compareCheck)
//   ];
// }

BarChartGroupData createGroupData(
  int x,
  double y1,
  double? y2,
  bool compareCheck,
) {
  return BarChartGroupData(
    barsSpace: 4,
    x: x,
    barRods: [
      BarChartRodData(
        toY: (y1 == 0) ? 0.4 : y1,
        width: 15,
        gradient: (compareCheck) ? createBarsGradientBlue() : createBarsGradientGrey(),
      ),
      BarChartRodData(
        toY: (y2 == 0) ? 0.4 : y2!,
        width: 15,
        gradient: (compareCheck) ? createBarsGradientGrey() : createBarsGradientBlue(),
      ),
    ],
    showingTooltipIndicators: (compareCheck) ? [0] : [1],
  );
}

LinearGradient createBarsGradientBlue() {
  return const LinearGradient(
    colors: [
      Colors.blue,
      Colors.cyan,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
}

LinearGradient createBarsGradientGrey() {
  return const LinearGradient(
    colors: [
      Colors.grey,
      Colors.grey,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
}

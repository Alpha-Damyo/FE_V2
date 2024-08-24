import 'package:damyo_app/view_models/statistics_models/smoke_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:damyo_app/view_models/statistics_models/period_info_view_model.dart';

// 기간별 비교 그래프
Widget periodCompareInfo(
    BuildContext context,
    bool compareCheck,
    String compareType,
    List<bool> isComparetype,
    SmokeViewModel smokeViewModel,
    PeriodInfoViewModel periodInfoViewModel,
    Function(bool) onCompareCheck,
    Function(int) onCompareType) {
  return Container(
    width: double.infinity,
    height: 400,
    child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 25, left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '평균 흡연량 비교하기',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                onCompareCheck(true);
              },
              child: Text(
                '나',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: compareCheck
                      ? const Color(0xFF0099FC)
                      : const Color(0xFFD1D6DC),
                  fontSize: 12,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                onCompareCheck(false);
              },
              child: Text(
                '전체',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: compareCheck
                      ? const Color(0xFFD1D6DC)
                      : const Color(0xFF0099FC),
                  fontSize: 12,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: (compareType == '일')
              ? BarChart(
                  BarChartData(
                    barTouchData: createPeriodCompare(),
                    titlesData: createDayTitlesCompare(),
                    borderData: createBorderData(),
                    barGroups: createBarDaysCompare(
                        smokeViewModel.userDayWeekInfo, periodInfoViewModel.everyDayWeek, compareCheck),
                    gridData: createGridData(),
                    alignment: BarChartAlignment.spaceAround,
                    maxY: roundUpToNearestTen(smokeViewModel.maxD! + 20),
                  ),
                )
              : (compareType == '주')
                  ? BarChart(
                      BarChartData(
                        barTouchData: createPeriodCompare(),
                        titlesData: createWeekTitlesCompare(),
                        borderData: createBorderData(),
                        barGroups: createBarWeeksCompare(
                            smokeViewModel.userWeeksInfo, periodInfoViewModel.everyWeeks, compareCheck),
                        gridData: createGridData(),
                        alignment: BarChartAlignment.spaceAround,
                        maxY: roundUpToNearestTen(smokeViewModel.maxW! + 20),
                      ),
                    )
                  : BarChart(
                      // 월
                      BarChartData(
                        barTouchData: createPeriodCompare(),
                        titlesData: createMonthTitlesCompare(),
                        borderData: createBorderData(),
                        barGroups: createBarMonthsCompare(smokeViewModel.userMonthsInfo,
                            periodInfoViewModel.everyMonths, now.month, compareCheck),
                        gridData: createGridData(),
                        alignment: BarChartAlignment.spaceAround,
                        maxY: roundUpToNearestTen(smokeViewModel.maxM! + 20),
                      ),
                    ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ToggleButtons(
            disabledColor: Colors.white,
            selectedColor: const Color(0xFFEEF1F4),
            fillColor: const Color(0xFFEEF1F4),
            borderRadius: BorderRadius.circular(10),
            renderBorder: false,
            isSelected: isComparetype,
            onPressed: (int index) {
              onCompareType(index);
            },
            children: [
              Container(
                width: 60,
                height: 30,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '일',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 60,
                height: 30,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '주',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 60,
                height: 30,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '월',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

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
    bottomTitles: const AxisTitles(
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
    bottomTitles: const AxisTitles(
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

List<BarChartGroupData> createBarDaysCompare(
    List<dynamic>? smokeWeekdayInfo,
    List<double?>? everyDayWeek,
    bool compareCheck,
  ) {
  return [
    for (int i = 0; i < everyDayWeek!.length; i++)
      createGroupData(i, smokeWeekdayInfo![i] * 1.0, everyDayWeek[i + 1], compareCheck)
  ];
}

List<BarChartGroupData> createBarWeeksCompare(
    List<dynamic>? smokeWeeksInfo,
    List<double?>? everyWeeks,
    bool compareCheck,
  ) {
  return [
    for (int i = 0; i < everyWeeks!.length; i++)
      createGroupData(i, smokeWeeksInfo![i] * 1.0, everyWeeks[i + 1], compareCheck)
  ];
}

List<BarChartGroupData> createBarMonthsCompare(
    List<dynamic>? smokeMonthsInfo,
    List<double?>? everyMonths,
    int nowMonth,
    bool compareCheck,
  ) {
  return [
    for (int i = 0; i < everyMonths!.length; i++)
      createGroupData(i, smokeMonthsInfo![i] * 1.0, everyMonths[(nowMonth + 12 - i) % 12], compareCheck)
  ];
}

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
        gradient: (compareCheck)
            ? createBarsGradientBlue()
            : createBarsGradientGrey(),
      ),
      BarChartRodData(
        toY: (y2 == 0 || y2 == null) ? 0.4 : y2,
        width: 15,
        gradient: (compareCheck)
            ? createBarsGradientGrey()
            : createBarsGradientBlue(),
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

DateTime now = DateTime.now();

double roundUpToNearestTen(double number) {
  return (number + 9) ~/ 10 * 10;
}
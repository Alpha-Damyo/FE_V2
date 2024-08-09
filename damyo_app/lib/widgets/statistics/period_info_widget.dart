import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:damyo_app/view_models/statistics_models/period_info_view_model.dart';

double roundUpToNearestTen(int number) {
  return (number + 9) ~/ 10 * 10;
}

// 기간별 비교 그래프
Widget periodCompareInfo(
    BuildContext context, bool compareCheck, Function(bool) onCompareCheck) {
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
        // Expanded(
        //   child: (compareType == '일')
        //       ? BarChart(
        //           BarChartData(
        //             barTouchData: createPeriodCompare(),
        //             titlesData: createDayTitlesCompare(),
        //             borderData: createBorderData(),
        //             barGroups: createBarDaysCompare(
        //                 smokeWeekdayInfo, everyDayWeek, compareCheck),
        //             gridData: createGridData(),
        //             alignment: BarChartAlignment.spaceAround,
        //             maxY: roundUpToNearestTen(maxWeekday! + 20),
        //           ),
        //         )
        //       : (compareType == '주')
        //           ? BarChart(
        //               BarChartData(
        //                 barTouchData: createPeriodCompare(),
        //                 titlesData: createWeekTitlesCompare(),
        //                 borderData: createBorderData(),
        //                 barGroups: createBarWeeksCompare(
        //                     smokeWeeksInfo, everyWeeks, compareCheck),
        //                 gridData: createGridData(),
        //                 alignment: BarChartAlignment.spaceAround,
        //                 maxY: roundUpToNearestTen(maxWeeks! + 20),
        //               ),
        //             )
        //           : BarChart(
        //               // 월
        //               BarChartData(
        //                 barTouchData: createPeriodCompare(),
        //                 titlesData: createMonthTitlesCompare(),
        //                 borderData: createBorderData(),
        //                 barGroups: createBarMonthsCompare(smokeMonthsInfo,
        //                     everyMonths, now.month, compareCheck),
        //                 gridData: createGridData(),
        //                 alignment: BarChartAlignment.spaceAround,
        //                 maxY: roundUpToNearestTen(maxMonths! + 20),
        //               ),
        //             ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: ToggleButtons(
        //     disabledColor: Colors.white,
        //     selectedColor: const Color(0xFFEEF1F4),
        //     fillColor: const Color(0xFFEEF1F4),
        //     borderRadius: BorderRadius.circular(10),
        //     renderBorder: false,
        //     isSelected: _isComparetype,
        //     onPressed: (int index) {
        //       setState(() {
        //         _isComparetype[index] = true;
        //         for (int i = 0; i < _isComparetype.length; i++) {
        //           if (i != index) {
        //             _isComparetype[i] = false;
        //           }
        //         }
        //         if (_isComparetype[index]) {
        //           switch (index) {
        //             case 0:
        //               compareType = '일';
        //               break;
        //             case 1:
        //               compareType = '주';
        //               break;
        //             case 2:
        //               compareType = '월';
        //               break;
        //             default:
        //               break;
        //           }
        //         }
        //       });
        //     },
        //     children: [
        //       Container(
        //         width: 60,
        //         height: 30,
        //         padding:
        //             const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        //         child: const Row(
        //           mainAxisSize: MainAxisSize.min,
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Text(
        //               '일',
        //               textAlign: TextAlign.right,
        //               style: TextStyle(
        //                 color: Colors.black,
        //                 fontSize: 12,
        //                 fontFamily: 'Pretendard',
        //                 fontWeight: FontWeight.w600,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Container(
        //         width: 60,
        //         height: 30,
        //         padding: const EdgeInsets.symmetric(vertical: 8),
        //         child: const Row(
        //           mainAxisSize: MainAxisSize.min,
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Text(
        //               '주',
        //               textAlign: TextAlign.right,
        //               style: TextStyle(
        //                 color: Colors.black,
        //                 fontSize: 12,
        //                 fontFamily: 'Pretendard',
        //                 fontWeight: FontWeight.w600,
        //                 height: 0,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Container(
        //         width: 60,
        //         height: 30,
        //         padding: const EdgeInsets.symmetric(vertical: 8),
        //         child: const Row(
        //           mainAxisSize: MainAxisSize.min,
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Text(
        //               '월',
        //               textAlign: TextAlign.right,
        //               style: TextStyle(
        //                 color: Colors.black,
        //                 fontSize: 12,
        //                 fontFamily: 'Pretendard',
        //                 fontWeight: FontWeight.w600,
        //                 height: 0,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    ),
  );
}

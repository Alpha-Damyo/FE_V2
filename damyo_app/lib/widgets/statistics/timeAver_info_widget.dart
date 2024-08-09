import 'package:damyo_app/style.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:damyo_app/view_models/statistics_models/timeAver_info_view_model.dart';

// 시간대별 평균 흡연량 그래프
Widget timeAverInfo(
    BuildContext context, bool timeCheck, Function(bool) onTimeCheck) {
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
              timeSmokeAver(timeCheck),
              duration: const Duration(milliseconds: 250),
            ),
          ),
        ),
      ],
    ),
  );
}

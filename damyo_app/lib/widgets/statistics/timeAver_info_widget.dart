import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:damyo_app/view_models/statistics_models/timeAver_info_view_model.dart';

Widget timeAverInfo(
    BuildContext context, bool timeCheck, Function(bool) onTimeCheck) {
  return Container(
    width: double.infinity,
    height: 300,
    child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20, left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '시간별 평균 흡연량',
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
              onPressed: () => onTimeCheck(true),
              child: Text(
                '나',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: timeCheck
                      ? const Color(0xFF0099FC)
                      : const Color(0xFFD1D6DC),
                  fontSize: 12,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () => onTimeCheck(false),
              child: Text(
                '전체',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: timeCheck
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


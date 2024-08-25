// 흡연 확인 위젯
import 'package:damyo_app/style.dart';
import 'package:flutter/material.dart';

Future<bool?> smokingCheckBox(BuildContext context) {
  return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: textFormat(
                text: '흡연 여부', fontSize: 18, fontWeight: FontWeight.w700),
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: textFormat(text: '흡연을 진행하시겠습니까?'),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: textFormat(
                  text: '확인',
                  fontSize: 13,
                  color: const Color(0xFF0099FC),
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: textFormat(
                  text: '취소',
                  fontSize: 13,
                  color: const Color(0xFF0099FC),
                )),
          ],
        );
      });
}

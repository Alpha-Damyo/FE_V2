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
                text: '흡연 완료', fontSize: 20, fontWeight: FontWeight.w700),
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: textFormat(text: '흡연 데이터를 추가합니다', fontSize: 18),
          ),
          actions: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pop(false);
                },
                child: Ink(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    child: Text('취소',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary)))),
            InkWell(
                onTap: () {
                  Navigator.of(context).pop(true);
                },
                child: Ink(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    child: Text('확인',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary)))),
          ],
        );
      });
}

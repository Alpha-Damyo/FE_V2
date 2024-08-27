import 'package:damyo_app/style.dart';
import 'package:flutter/material.dart';

Future<bool?> resetCheck(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: textFormat(
            text: "흡연 데이터 초기화", fontSize: 20, fontWeight: FontWeight.w700),
        content: textFormat(text: "흡연 데이터를 초기화 시키겠습니까?", fontSize: 18),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop(false);
            },
            child: Ink(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: Text(
                  '취소',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                )),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop(true);
            },
            child: Ink(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: Text('확인',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary))),
          ),
        ],
      );
    },
  );
}

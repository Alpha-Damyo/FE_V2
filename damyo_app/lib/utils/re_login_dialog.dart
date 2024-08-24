import 'package:damyo_app/style.dart';
import 'package:damyo_app/view/setting/login/login_view.dart';
import 'package:flutter/material.dart';

void reLogin(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: textFormat(
            text: "로그인이 필요합니다.\n로그인을 진행해주세요.",
            fontSize: 20,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
            },
            child: const Text('확인'),
          ),
        ],
      );
    },
  );
}

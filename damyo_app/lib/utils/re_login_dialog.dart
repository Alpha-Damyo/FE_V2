import 'package:damyo_app/style.dart';
import 'package:damyo_app/view/setting/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void reLogin(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Padding(
          padding: const EdgeInsets.all(6.0),
          child: textFormat(
              text: "로그인 필요 서비스", fontSize: 18, fontWeight: FontWeight.w700),
        ),
        content: Padding(
          padding: const EdgeInsets.all(6.0),
          child: textFormat(text: "로그인을 진행해주세요."),
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
              Navigator.of(context).pop();
              Future.delayed(Duration.zero, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              });
            },
            child: const Text('확인'),
          ),
        ],
      );
    },
  );
}

import 'package:damyo_app/style.dart';
import 'package:damyo_app/view/setting/login/login_view.dart';
import 'package:flutter/material.dart';

void reLogin(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: textFormat(
            text: "로그인 필요 서비스", fontSize: 20, fontWeight: FontWeight.w700),
        content: textFormat(text: "로그인을 진행해주세요.", fontSize: 18),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
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
              Navigator.of(context).pop();
              Future.delayed(Duration.zero, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              });
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

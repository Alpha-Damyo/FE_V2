import "package:damyo_app/view/login/login_view.dart";
import "package:flutter/material.dart";
import "package:damyo_app/style.dart";

// 로그인 버튼
Widget loginBtn(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    },
    child: Container(
      width: 360,
      height: 60,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textFormat(
                  text: '로그인 / 회원가입',
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
              const SizedBox(height: 6),
              textFormat(
                text: '담요와 함께 바른 문화를 만들어봐요 ! ',
                color: Color(0xFF6E767F),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// 설정 탭 박스
Widget toolBax(BuildContext context) {
  return InkWell(
    onTap: () {},
  );
}

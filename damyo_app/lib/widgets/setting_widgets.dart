import "package:damyo_app/view/login/login_view.dart";
import "package:flutter/material.dart";
import "package:damyo_app/style.dart";

// 로그인 버튼
Widget loginBtn(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 50.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      },
      child: Container(
        width: double.infinity,
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
    ),
  );
}

// 설정 탭 박스
Widget toolBax(BuildContext context, String name) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 30,
          child: InkWell(
            onTap: () {},
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: textFormat(
                  text: name,
                  color: Color(0xFF262B32),
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          decoration: const ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: Color(0xFFEEF1F4),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

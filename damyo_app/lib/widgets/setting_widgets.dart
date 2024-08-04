import "package:flutter/material.dart";

// 로그인 버튼
Widget loginBtn(BuildContext context) {
  return InkWell(
    onTap: () {
      print('push');
    },
    child: Container(
      width: 360,
      height: 70,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '로그인/회원가입 하러 가기',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          )
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

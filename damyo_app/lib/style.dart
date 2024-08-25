import 'package:flutter/material.dart';

Text textFormat({
  required String text,
  double fontSize = 14,
  Color? color = Colors.black,
  FontWeight fontWeight = FontWeight.w500,
  TextOverflow? textOverflow = TextOverflow.ellipsis,
  TextAlign? textAlign = TextAlign.start,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontSize,
      fontFamily: 'Pretendard',
      fontWeight: fontWeight,
      color: color,
    ),
    textScaler: TextScaler.noScaling,
    overflow: textOverflow,
    textAlign: textAlign,
  );
}

Text appbarTitleFormat({
  required String text,
  double fontSize = 20,
  Color? color = Colors.black,
  FontWeight fontWeight = FontWeight.w600,
  TextOverflow? textOverflow = TextOverflow.ellipsis,
  TextAlign? textAlign = TextAlign.start,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontSize,
      fontFamily: 'Pretendard',
      fontWeight: fontWeight,
      color: color,
    ),
    textScaler: TextScaler.noScaling,
    overflow: textOverflow,
    textAlign: textAlign,
  );
}

// 버튼 그림자
BoxShadow btnBoxShadow() {
  return BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 0,
    blurRadius: 2.0,
    offset: const Offset(0, 3), // changes position of shadow
  );
}

// 그림자가 적용된 Inkwell의 부모
Widget shadowMaterial(BuildContext context, double borderRadius, Widget child) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        btnBoxShadow(),
      ],
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: Material(
      color: Colors.transparent,
      child: child,
    ),
  );
}

// 그림자가 없는 Inkwell의 부모
Widget normalMaterial(BuildContext context, double borderRadius, Widget child) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: Material(
      color: Colors.transparent,
      child: child,
    ),
  );
}

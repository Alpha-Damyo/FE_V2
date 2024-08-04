import 'package:flutter/material.dart';

Text textFormat({
  required String text,
  double fontSize = 14,
  Color? color = Colors.black,
  FontWeight fontWeight = FontWeight.normal,
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

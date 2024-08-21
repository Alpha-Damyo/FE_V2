import 'package:flutter/material.dart';

Widget reportSaName(BuildContext context, String name) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: name,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const TextSpan(
          text: "에 대해\n제안해주세요!",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

import "package:damyo_app/style.dart";
import "package:flutter/material.dart";
import "package:damyo_app/services/naverlogin_service.dart";

Widget naverLoginBtn(BuildContext context) {
  return InkWell(
    onTap: signInWithNaver,
    borderRadius: BorderRadius.circular(41),
    child: Container(
      width: 337,
      height: 55,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFF00C73C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(41),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 24,
                height: 24,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Color(0xFFF9E000)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage("https://via.placeholder.com/28x28"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              textFormat(
                text: '네이버로 계속하기',
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

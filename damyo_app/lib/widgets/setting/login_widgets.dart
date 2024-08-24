import "package:damyo_app/icon/damyo_icon_icons.dart";
import "package:damyo_app/services/login_service.dart";
import "package:damyo_app/style.dart";
import "package:damyo_app/utils/initialized_db.dart";
import "package:damyo_app/view_models/login_models/is_login_view_model.dart";
import "package:damyo_app/view_models/login_models/token_view_model.dart";
import "package:damyo_app/view_models/login_models/user_info_view_model.dart";
import "package:flutter/material.dart";

Widget naverLoginBtn(BuildContext context, IsloginViewModel isloginViewModel,
    TokenViewModel tokenViewModel, UserInfoViewModel userInfoViewModel) {
  return InkWell(
    onTap: () async {
      if (await LoginService.signInWithNaver(
          isloginViewModel, tokenViewModel, userInfoViewModel)) {
        await initializedDB(context);
        Navigator.pop(context);
      }
    },
    borderRadius: BorderRadius.circular(41),
    child: Container(
      width: 337,
      height: 55,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF00C73C),
        borderRadius: BorderRadius.circular(41),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            DamyoIcon.naver,
            size: 14,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          textFormat(
            text: '네이버로 계속하기',
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    ),
  );
}

Widget googleLoginBtn(BuildContext context, IsloginViewModel isloginViewModel,
    TokenViewModel tokenViewModel, UserInfoViewModel userInfoViewModel) {
  return InkWell(
    borderRadius: BorderRadius.circular(41),
    onTap: () async {
      if (await LoginService.signInWithGoogle(
          isloginViewModel, tokenViewModel, userInfoViewModel)) {
        await initializedDB(context);
        Navigator.pop(context);
      }
    },
    child: Ink(
      width: 337,
      height: 55,
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Theme.of(context).colorScheme.onSecondaryContainer,
        //   width: 1.5,
        // ),
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        borderRadius: BorderRadius.circular(41),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            DamyoIcon.google,
            size: 20,
          ),
          const SizedBox(width: 10),
          textFormat(text: "구글로 계속하기", fontWeight: FontWeight.w700),
        ],
      ),
    ),
  );
}

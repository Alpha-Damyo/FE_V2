import "package:damyo_app/services/google_login_service.dart";
import "package:damyo_app/style.dart";
import "package:damyo_app/view/setting/login/signup/signup_view.dart";
import "package:damyo_app/view_models/login_models/islogin_view_model.dart";
import "package:damyo_app/view_models/login_models/token_view_model.dart";
import "package:damyo_app/view_models/login_models/user_info_view_model.dart";
import "package:flutter/material.dart";
import "package:damyo_app/services/naverlogin_service.dart";

Widget naverLoginBtn(BuildContext context, IsloginViewModel isloginViewModel,
    TokenViewModel tokenViewModel, UserInfoViewModel userInfoViewModel) {
  return InkWell(
    onTap: () async {
      int val = await signInWithNaver(isloginViewModel, tokenViewModel, userInfoViewModel);
      switch (val) {
        case 0:
          // 로그인 완료
          Navigator.pop(context);
          break;
        case 1:
          // 회원 가입 필요
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignupView()),
          );
          break;
        case 2:
          // 토큰 재발급 필요
          break;
        default:
      }
    },
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
                decoration: const BoxDecoration(color: Color(0xFFF9E000)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
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

Widget googleLoginBtn(BuildContext context, IsloginViewModel isloginViewModel,
    TokenViewModel tokenViewModel, UserInfoViewModel userInfoViewModel) {
  return InkWell(
    borderRadius: BorderRadius.circular(41),
    onTap: () async {
      // Todo: 구글로 로그인 구현
      int val = await signInWithGoogle(isloginViewModel, tokenViewModel);
      switch (val) {
        case 0:
          // 로그인 완료
          Navigator.pop(context);
          break;
        case 1:
          // 회원 가입 필요
          break;
        case 2:
          // 토큰 재발급 필요
          break;
        default:
      }
    },
    child: Ink(
      width: 337,
      height: 55,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        borderRadius: BorderRadius.circular(41),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.g_mobiledata, size: 30),
          textFormat(text: "구글로 계속하기", fontWeight: FontWeight.w700),
        ],
      ),
    ),
  );
}

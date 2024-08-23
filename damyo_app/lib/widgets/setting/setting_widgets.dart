import "package:damyo_app/view/setting/contribution/contribution_view.dart";
import "package:damyo_app/view/setting/login/login_view.dart";
import "package:damyo_app/view_models/login_models/is_login_view_model.dart";
import "package:damyo_app/view_models/login_models/token_view_model.dart";
import "package:damyo_app/view_models/login_models/user_info_view_model.dart";
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
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textFormat(
                  text: '로그인 / 회원가입',
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
              const SizedBox(height: 6),
              textFormat(
                text: '담요와 함께 바른 문화를 만들어봐요 ! ',
                color: const Color(0xFF6E767F),
              ),
            ],
          ),
          const Icon(Icons.keyboard_arrow_right, size: 30),
        ],
      ),
    ),
  );
}

// 사용자 기본 정보
Widget userProfile(BuildContext context, IsloginViewModel isloginViewModel,
    TokenViewModel tokenViewModel, UserInfoViewModel userInfoViewModel) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(15),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 84,
                  height: 84,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: Image.network(
                      userInfoViewModel.userInfoModel.profileUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textFormat(
                      text: userInfoViewModel.userInfoModel.name,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color(0xFFDEDEDE)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '바른 문화 기여도: ${userInfoViewModel.userInfoModel.contribution}점',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                print(isloginViewModel.isLogin);
              },
              icon: const Icon(Icons.keyboard_arrow_right),
              iconSize: 30,
            ),
          ],
        ),
        const SizedBox(height: 20),
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            tokenViewModel.deleteToken();
            isloginViewModel.logout();
          },
          child: Ink(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF1F4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
                alignment: Alignment.center,
                child: textFormat(text: "로그아웃", fontWeight: FontWeight.w700)),
          ),
        ),
      ],
    ),
  );
}

// 기여도 버튼
Widget contributionBtn(BuildContext context, String name) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ContributionView()));
    },
    child: Ink(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1.5, color: Colors.grey))),
        child: textFormat(
          text: name,
          color: const Color(0xFF262B32),
          fontSize: 16,
        ),
      ),
    ),
  );
}

// 설정 탭 박스
Widget toolBax(BuildContext context, String name) {
  return InkWell(
    onTap: () {},
    child: Ink(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1.5, color: Colors.grey))),
        child: textFormat(
          text: name,
          color: const Color(0xFF262B32),
          fontSize: 16,
        ),
      ),
    ),
  );
}

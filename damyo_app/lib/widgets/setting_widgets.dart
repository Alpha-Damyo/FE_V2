import "package:damyo_app/view/setting/login/login_view.dart";
import "package:damyo_app/view_models/login_models/islogin_view_model.dart";
import "package:damyo_app/view_models/login_models/user_info_view_model.dart";
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

// 사용자 기본 정보
Widget userProfile(BuildContext context, IsloginViewModel isloginViewModel,
    UserInfoViewModel userInfoViewModel) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 50.0),
    child: InkWell(
        onTap: () {},
        child: Container(
          // width: 390.w,
          // height: 189.h,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                              color: Color(0xFFDEDEDE), shape: BoxShape.circle),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 84,
                                height: 84,
                                // decoration: BoxDecoration(
                                //   image: DecorationImage(
                                //     image:
                                //         NetworkImage('no'),
                                //     fit: BoxFit.fill,
                                //   ),
                                // ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 15),
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
                            SizedBox(height: 6),
                            Container(
                              padding: EdgeInsets.symmetric(
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
                                    '바른 문화 기여도: 0점',
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
                    SizedBox(width: 70),
                    IconButton(
                        onPressed: () {
                          print(isloginViewModel.isloginModel.isLogin);
                        },
                        icon: const Icon(Icons.keyboard_arrow_right)),
                    SizedBox(width: 10),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 358,
                padding: EdgeInsets.symmetric(horizontal: 55, vertical: 12),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFFEEF1F4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    isloginViewModel.logout();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      '로그아웃',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
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

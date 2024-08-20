import 'package:damyo_app/view_models/login_models/islogin_view_model.dart';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';

Future<int> checkLoginState(Map<String, dynamic> userInfo,
    IsloginViewModel isloginViewModel, TokenViewModel tokenViewModel) async {
  if (userInfo['code'] == "A102") {
    // 회원 가입 필요
    return 1;
  } else if (userInfo['code'] == "A103") {
    // 토큰 재발급 필요
    return 2;
  } else {
    // 로그인 성공, 토큰 저장
    tokenViewModel.setToken(userInfo['accessToken'], userInfo['refreshToken']);
    isloginViewModel.login();

    return 0;
  }
}

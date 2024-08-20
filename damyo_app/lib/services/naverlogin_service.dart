import 'package:damyo_app/services/login_state_check.dart';
import 'package:damyo_app/view_models/login_models/islogin_view_model.dart';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';
import 'package:damyo_app/view_models/login_models/user_info_view_model.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:damyo_app/services/login_service.dart';

Future<int> signInWithNaver(
    IsloginViewModel isloginViewModel, TokenViewModel tokenViewModel, UserInfoViewModel userInfoViewModel) async {
  NaverLoginResult naverUser = await FlutterNaverLogin.logIn();
  NaverAccessToken naverToken = await FlutterNaverLogin.currentAccessToken;
  Map<String, dynamic> userInfo;

  // print('name = ${naverUser.account.name}');
  // print('email = ${naverUser.account.email}');
  // print('id = ${naverUser.account.id}');

  // print(naverToken);

  userInfo = await login({
    "token": naverToken.accessToken,
  }, "naver");

  userInfoViewModel.setName(naverUser.account.name);

  return await checkLoginState(userInfo, isloginViewModel, tokenViewModel);
}

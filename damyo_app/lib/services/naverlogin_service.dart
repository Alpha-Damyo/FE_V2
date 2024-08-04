import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:damyo_app/services/login_service.dart';

Future<void> signInWithNaver() async {
    NaverLoginResult naverUser = await FlutterNaverLogin.logIn();
    NaverAccessToken naverToken = await FlutterNaverLogin.currentAccessToken;
    Map<String, dynamic> userInfo;

    print('name = ${naverUser.account.name}');
    print('email = ${naverUser.account.email}');
    print('id = ${naverUser.account.id}');

    print(naverToken);

    userInfo = await login({
      "token": naverToken.accessToken,
    }, "naver");
}


import 'dart:convert';
import 'package:damyo_app/services/user_service.dart';
import 'package:damyo_app/view_models/login_models/is_login_view_model.dart';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';
import 'package:damyo_app/view_models/login_models/user_info_view_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static final baseUrl = dotenv.get('BASE_URL');

  static Future<bool> signInWithNaver(
    IsloginViewModel isloginViewModel,
    TokenViewModel tokenViewModel,
    UserInfoViewModel userInfoViewModel,
  ) async {
    // NaverLoginResult naverUser = await FlutterNaverLogin.logIn();
    NaverAccessToken naverToken = await FlutterNaverLogin.currentAccessToken;

    if (!naverToken.isValid()) {
      return false;
    }

    if (await login(
      {
        "token": naverToken.accessToken,
      },
      "naver",
      tokenViewModel,
      isloginViewModel,
      userInfoViewModel,
    )) {
      return true;
    }
    return false;
  }

  static Future<bool> signInWithGoogle(
    IsloginViewModel isloginViewModel,
    TokenViewModel tokenViewModel,
    UserInfoViewModel userInfoViewModel,
  ) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return false;
    }

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;

    // google accesstoken 받아오기
    String googleAccessToken =
        googleSignInAuthentication.accessToken.toString();

    if (await login(
      {
        "token": googleAccessToken,
      },
      "google",
      tokenViewModel,
      isloginViewModel,
      userInfoViewModel,
    )) {
      return true;
    }

    return false;
  }

  static Future<bool> login(
    Map<String, String> loginInfo,
    String provider,
    TokenViewModel tokenViewModel,
    IsloginViewModel isLoginViewModel,
    UserInfoViewModel userInfoViewModel,
  ) async {
    final baseUrl = dotenv.get('BASE_URL');
    var url = Uri.parse('$baseUrl/auth/login/$provider');

    var body = json.encode(loginInfo);
    String token = loginInfo['token']!;

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );

    var responseDecode = jsonDecode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      tokenViewModel.setToken(
          responseDecode['accessToken'], responseDecode['refreshToken']);
      isLoginViewModel.login();
      List<dynamic> userInfo = await UserService.getUserInfo(tokenViewModel);
      userInfoViewModel.updateUserInfoModel(userInfo[1]);
      return true;
    }
    return false;
  }
}

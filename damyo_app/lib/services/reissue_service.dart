import 'dart:convert';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<bool> reissueService(TokenViewModel tokenViewModel) async {
  final baseUrl = dotenv.get('BASE_URL');

  // AT가 만료되어 reissue 진행
  var url = Uri.parse('$baseUrl/auth/reissue');

  String? rt = tokenViewModel.tokenModel.refreshToken;
  if (rt == null) {
    // 재 로그인 필요
    return false;
  }

  var response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({'refreshToken': rt}),
  );

  var responseDecode = jsonDecode(utf8.decode(response.bodyBytes));
  if (response.statusCode == 200) {
    if (responseDecode['code'] == "A108") {
      return false;
    }
    tokenViewModel.setToken(
        responseDecode['accessToken'], responseDecode['refreshToken']);
    return true;
  } else {
    // 재 로그인 필요
    return false;
  }
}

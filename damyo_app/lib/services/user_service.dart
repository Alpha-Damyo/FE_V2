import 'dart:convert';
import 'package:damyo_app/models/user/user_info_model.dart';
import 'package:damyo_app/services/reissue_service.dart';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserService {
  static final baseUrl = dotenv.get('BASE_URL');

  static Future<List<dynamic>> getUserInfo(
      TokenViewModel tokenViewModel) async {
    final baseUrl = dotenv.get('BASE_URL');
    var url = Uri.parse('$baseUrl/user/info');

    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokenViewModel.tokenModel.accessToken}',
      },
    );

    var responseDecode = jsonDecode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return [true, UserInfoModel.fromJson(responseDecode)];
    }
    // AT가 만료된 경우
    else if (responseDecode["code"] == "A103") {
      // reissue에 성공한 경우
      if (await reissueService(tokenViewModel)) {
        var response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${tokenViewModel.tokenModel.accessToken}',
          },
        );

        var responseDecode = jsonDecode(utf8.decode(response.bodyBytes));
        if (response.statusCode == 200) {
          return [true, UserInfoModel.fromJson(responseDecode)];
        } else {
          throw Exception(response.statusCode);
        }
      }
      // reissue에 실패한 경우
      else {
        // RT 만료: 로그인 페이지로 이동
        return [false, false];
      }
    } else {
      throw Exception(response.statusCode);
    }
  }
}

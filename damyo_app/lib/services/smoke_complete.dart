import 'package:damyo_app/services/reissue_service.dart';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

FlutterSecureStorage storage = FlutterSecureStorage();

Future<String> smokeComplete(BuildContext context, String id) async {
  final baseUrl = dotenv.get('BASE_URL');
  String? token = await storage.read(key: 'accessToken');

  var url = Uri.parse('$baseUrl/data/postData?areaId=$id');
  var headers = {
    "Authorization": 'Bearer $token',
  };

  var response = await http.post(url, headers: headers);

  if (response.statusCode == 200) {
    return "success";
  } else {
    var responseDecode = jsonDecode(utf8.decode(response.bodyBytes));

    if (responseDecode['A103']) {
      if (await reissueService(
          Provider.of<TokenViewModel>(context, listen: false))) {
        var response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Provider.of<TokenViewModel>(context, listen: false).tokenModel.accessToken}',
          },
        );

        if (response.statusCode == 200) {
          return "success";
        } else {
          throw Exception(response.statusCode);
        }
      }
      // reissue 실패
      else {
          // RT 만료: 로그인 페이지로 이동
          return "re_login";
      }
    } else {
      throw Exception(response.statusCode);
    }
  }
}

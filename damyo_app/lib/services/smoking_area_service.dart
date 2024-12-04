import 'dart:convert';

import 'package:damyo_app/models/smoking_area/sa_basic_model.dart';
import 'package:damyo_app/models/smoking_area/sa_detail_model.dart';
import 'package:damyo_app/models/smoking_area/sa_inform_model.dart';
import 'package:damyo_app/models/smoking_area/sa_report_model.dart';
import 'package:damyo_app/models/smoking_area/sa_review_model.dart';
import 'package:damyo_app/models/smoking_area/sa_search_model.dart';
import 'package:damyo_app/services/reissue_service.dart';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class SmokingAreaService {
  static final baseUrl = dotenv.get('BASE_URL');

  // 흡연구역 태그 검색
  static Future<List<SaBasicModel>> searchSmokingAreaByTag(
      SaSearchModel saSearchModel) async {
    var url = Uri.parse("$baseUrl/area/locateSearch");
    var body = json.encode(saSearchModel.toJson());

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    var responseDecode = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      List<SaBasicModel> smokingAreas = [];
      List<dynamic> results = responseDecode['smokingAreas'];
      for (int i = 0; i < results.length; i++) {
        smokingAreas.add(SaBasicModel.fromJson(results[i]));
      }
      return smokingAreas;
    } else {
      throw Exception("Fail to Search");
    }
  }

  // 흡연구역 areaId 검색
  static Future<SaBasicModel> serachSmokingAreaByAreaId(String areaId) async {
    final baseUrl = dotenv.get('BASE_URL');
    var url = Uri.parse('$baseUrl/area/summary/$areaId');

    var response = await http.get(url);

    var responseDecode = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return SaBasicModel.fromJson(responseDecode);
    } else {
      throw Exception("fail search");
    }
  }

  // 흡연구역 이름 검색
  static Future<List<SaBasicModel>> searchSmokingAreaByName(String name) async {
    var url = Uri.parse("$baseUrl/area/querySearch");
    var body = json.encode({
      "word": name,
      "status": null,
      "opened": null,
      "closed": null,
      "indoor": null,
      "outdoor": null,
    });

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    var responseDecode = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      List<SaBasicModel> smokingAreas = [];
      List<dynamic> results = responseDecode['smokingAreas'];
      for (int i = 0; i < results.length; i++) {
        smokingAreas.add(SaBasicModel.fromJson(results[i]));
      }
      return smokingAreas;
    } else {
      throw Exception("Fail to Search");
    }
  }

  // 흡연구역 상세정보
  static Future<SaDetailModel> getDetailSmokingArea(String areaId) async {
    final baseUrl = dotenv.get('BASE_URL');
    var url = Uri.parse('$baseUrl/area/details/$areaId');

    var response = await http.get(url);
    var responseDecode = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return SaDetailModel.fromJson(responseDecode);
    } else {
      throw Exception("Fail to Get Detail");
    }
  }

  // 흡연구역 제보
  static Future<bool> informSmokingArea(
      bool isLogin,
      TokenViewModel tokenViewModel,
      XFile? image,
      SaInformModel saInformModel) async {
    final baseUrl = dotenv.get('BASE_URL');
    var url = Uri.parse('$baseUrl/area/postArea');

    var request = http.MultipartRequest('POST', url);

    // 토큰 추가
    if (isLogin) {
      request.headers['Authorization'] =
          'Bearer ${tokenViewModel.tokenModel.accessToken}';
    }

    // 이미지 추가
    if (image != null) {
      var multipartFile = await http.MultipartFile.fromPath(
        'imgFile',
        image.path,
        filename: 'image.png',
      );
      request.files.add(multipartFile);
    }

    // 데이터 추가
    var data = saInformModel.toJson();
    List<int> jsonData = utf8.encode(jsonEncode(data));
    request.files.add(http.MultipartFile.fromBytes(
      'areaRequest',
      jsonData,
      contentType: MediaType(
        'application',
        'json',
        {'charset': 'utf-8'},
      ),
    ));

    var response = await request.send();
    var jsonBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      debugPrint(jsonBody);
      return true;
    } else {
      debugPrint(jsonBody);
      return false;
    }
  }

  // 흡연구역 리뷰
  static Future<String> reviewSmokingArea(XFile? image,
      SaReviewModel saReviewModel, TokenViewModel tokenViewModel) async {
    final baseUrl = dotenv.get('BASE_URL');
    var url = Uri.parse('$baseUrl/info/postInfo');

    var request = http.MultipartRequest('POST', url);

    // 토큰 추가
    request.headers['Authorization'] =
        'Bearer ${tokenViewModel.tokenModel.accessToken}';

    // 이미지 추가
    if (image != null) {
      var multipartFile = await http.MultipartFile.fromPath(
        'imgFile',
        image.path,
        filename: 'image.png',
      );
      request.files.add(multipartFile);
    }

    // 데이터 추가
    var data = saReviewModel.toJson();
    List<int> jsonData = utf8.encode(jsonEncode(data));
    request.files.add(http.MultipartFile.fromBytes(
      'updateInfoRequest',
      jsonData,
      contentType: MediaType(
        'application',
        'json',
        {'charset': 'utf-8'},
      ),
    ));

    var response = await request.send();
    var jsonBody = await response.stream.bytesToString();
    var responseBody = json.decode(jsonBody);

    if (response.statusCode == 200) {
      return "success";
    }
    // AT가 만료된 경우
    else if (responseBody["code"] == "A103") {
      // reissue에 성공한 경우
      if (await reissueService(tokenViewModel)) {
        // 토큰 수정
        request.headers['Authorization'] =
            'Bearer ${tokenViewModel.tokenModel.accessToken}';

        var response = await request.send();

        if (response.statusCode == 200) {
          return "success";
        } else {
          throw Exception(response.statusCode);
        }
      }
      // reissue에 실패한 경우
      else {
        // RT 만료: 로그인 페이지로 이동
        return "re_login";
      }
    } else {
      return "fail";
    }
  }

  // 흡연구역 신고
  static Future<String> reportSmokingArea(SaReportModel saReportModel,
      String areaId, TokenViewModel tokenViewModel) async {
    final baseUrl = dotenv.get('BASE_URL');
    var url = Uri.parse('$baseUrl/user/report/$areaId');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokenViewModel.tokenModel.accessToken}',
    };
    var body = json.encode(saReportModel.toJson());

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    var responseDecode = jsonDecode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return "success";
    }
    // 이미 신고한 구역인 경우
    else if (responseDecode["code"] == "SA102") {
      return "already_reported";
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

        if (response.statusCode == 200) {
          return "success";
        } else {
          throw Exception(response.statusCode);
        }
      }
      // reissue에 실패한 경우
      else {
        // RT 만료: 로그인 페이지로 이동
        return "re_login";
      }
    } else {
      throw Exception(response.statusCode);
    }
  }
}

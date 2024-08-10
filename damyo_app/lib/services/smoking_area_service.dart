import 'dart:convert';
import 'dart:io';

import 'package:damyo_app/models/smoking_area/sa_basic_model.dart';
import 'package:damyo_app/models/smoking_area/sa_detail_model.dart';
import 'package:damyo_app/models/smoking_area/sa_inform_model.dart';
import 'package:damyo_app/models/smoking_area/sa_review_model.dart';
import 'package:damyo_app/models/smoking_area/sa_search_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class SmokingAreaService {
  static final baseUrl = dotenv.get('BASE_URL');

  static Future<List<SaBasicModel>> searchSmokingArea(
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

  static Future<bool> informSmokingArea(
      XFile? image, SaInformModel saInformModel) async {
    final baseUrl = dotenv.get('BASE_URL');
    var url = Uri.parse('$baseUrl/area/postArea');

    var request = http.MultipartRequest('POST', url);

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

  static Future<bool> reviewSmokingArea(
      XFile? image, SaReviewModel saReviewModel) async {
    final baseUrl = dotenv.get('BASE_URL');
    var url = Uri.parse('$baseUrl/info/postInfo');

    var request = http.MultipartRequest('POST', url);

    // 토큰 추가
    String token = "";
    request.headers['Authorization'] = 'Bearer $token';

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
    debugPrint(data["areaId"]);
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

    if (response.statusCode == 200) {
      debugPrint(jsonBody);
      return true;
    } else {
      debugPrint(jsonBody);
      return false;
    }
  }
}

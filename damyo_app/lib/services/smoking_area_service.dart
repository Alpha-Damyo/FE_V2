import 'dart:convert';

import 'package:damyo_app/models/smoking_area/sa_basic_model.dart';
import 'package:damyo_app/models/smoking_area/sa_search_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

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
      throw Exception("Fail Search");
    }
  }
}

import 'dart:convert';
import 'package:damyo_app/models/statistics_info/stat_date_model.dart';
import 'package:damyo_app/models/statistics_info/stat_region_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

FlutterSecureStorage storage = const FlutterSecureStorage();

Future<statDateModel> getDateStatics() async {
  final baseUrl = dotenv.get('BASE_URL');
  String? token = await storage.read(key: 'accessToken');

  var url = Uri.parse('$baseUrl/data/dateStatics');
  var headers = {
    "Authorization": 'Bearer $token',
  };

  var response = await http.get(url, headers: headers);

  final Map<String, dynamic> jsonMap =
      jsonDecode(utf8.decode(response.bodyBytes));

  if (response.statusCode == 200) {
    return statDateModel.fromJson(jsonMap);
  } else {
    throw jsonMap;
  }
}

Future<statRegionModel> getRegionStatics() async {
  final baseUrl = dotenv.get('BASE_URL');
  String? token = await storage.read(key: 'accessToken');

  var url = Uri.parse('$baseUrl/data/regionStatics');
  var headers = {
    "Authorization": 'Bearer $token',
  };

  var response = await http.get(url, headers: headers);

  final Map<String, dynamic> jsonMap =
      jsonDecode(utf8.decode(response.bodyBytes));

  if (response.statusCode == 200) {
    return statRegionModel.fromJson(jsonMap);
  } else {
    throw jsonMap['code'];
  }
}

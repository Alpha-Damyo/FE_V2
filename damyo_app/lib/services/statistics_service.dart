import 'dart:convert';
import 'package:damyo_app/models/statistics_info/stat_date_model.dart';
import 'package:damyo_app/models/statistics_info/stat_region_model.dart';
import 'package:damyo_app/services/reissue_service.dart';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

FlutterSecureStorage storage = const FlutterSecureStorage();

Future<statDateModel> getDateStatics(BuildContext context) async {
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
    if(await reissueService(Provider.of<TokenViewModel>(context, listen: false))){
      return getDateStatics(context);
    }
    else{
      throw Exception();
    }
  }
}

Future<statRegionModel> getRegionStatics(BuildContext context) async {
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
    if(await reissueService(Provider.of<TokenViewModel>(context, listen: false))){
      return getRegionStatics(context);
    }
    else{
      throw Exception();
    }
  }
}

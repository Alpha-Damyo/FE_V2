import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> login(
    Map<String, String> loginInfo, String provider) async {
  final baseUrl = dotenv.get('BASE_URL');
  var url =
      Uri.parse('$baseUrl/auth/login/$provider?token=${loginInfo['token']}');

  var body = json.encode(loginInfo);

  var response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: body,
  );

  var responseDecode = jsonDecode(utf8.decode(response.bodyBytes));

  if (response.statusCode == 200 || response.statusCode == 404) {
    print(responseDecode);
    return responseDecode;
  } else {
    print(responseDecode);
    throw '${response.statusCode}';
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:damyo_app/models/user/user_info_model.dart';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';
import 'package:damyo_app/view_models/login_models/user_info_view_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

Future<String?> putUserUpdateName(
    TokenViewModel tokenViewModel, String name, UserInfoViewModel userInfoViewModel) async {
  final baseUrl = dotenv.get('BASE_URL');

  var token = tokenViewModel.tokenModel.accessToken;
  var url = Uri.parse('$baseUrl/user/update/name?name=$name');

  var headers = {
    "Authorization": 'Bearer $token',
  };

  var response = await http.put(url, headers: headers);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    final Map<String, dynamic> responseDecode =
        jsonDecode(utf8.decode(response.bodyBytes));
    throw responseDecode['code'];
  }
}

Future<String?> putUserUpdateProfile(
    TokenViewModel tokenViewModel, UserInfoViewModel userInfoViewModel, XFile profileImage) async {
  final baseUrl = dotenv.get('BASE_URL');

  var token = tokenViewModel.tokenModel.accessToken;
  var url = Uri.parse('$baseUrl/user/update/profile');
  var request = http.MultipartRequest('PUT', url);

  // 파일 추가
  var imageFile = File(profileImage.path);
  var stream = http.ByteStream(imageFile.openRead());
  var length = await imageFile.length();
  var multipartFile = http.MultipartFile(
    'image',
    stream,
    length,
    filename: '${userInfoViewModel.userInfoModel.name}.png',
  );

  // 파일 추가
  request.files.add(multipartFile);

  // 필요한 다른 데이터 추가
  request.headers['Authorization'] = 'Bearer $token';
  request.fields['key'] = 'value'; // 필요한 다른 필드 추가

  // 요청 보내기
  var response = await request.send();
  var jsonBody = await response.stream.bytesToString();

  if (response.statusCode == 200) {
    return jsonBody;
  } else {
    final Map<String, dynamic> responseDecode = jsonDecode(jsonBody);
        
    throw responseDecode['code'];
  }
}

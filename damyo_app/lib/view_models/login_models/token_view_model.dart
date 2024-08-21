import 'package:damyo_app/models/login/token_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenViewModel extends ChangeNotifier {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  final TokenModel _tokenModel = TokenModel();

  TokenModel get tokenModel => _tokenModel;

  void setToken(String accessToken, String refreshToken){
    _tokenModel.accessToken = accessToken;
    _tokenModel.refreshToken = refreshToken;
    storage.write(key: 'accessToken', value: accessToken);
    storage.write(key: 'refreshToken', value: refreshToken);
    notifyListeners();
  }

  void updateAccessToken(String accessToken){
    _tokenModel.accessToken = accessToken;
    storage.delete(key: 'accessToken');
    storage.write(key: 'accessToken', value: accessToken);
    notifyListeners();
  }

  void updateRefreshToken(String refreshToken){
    _tokenModel.refreshToken = refreshToken;
    storage.delete(key: 'refreshToken');
    storage.write(key: 'refreshToken', value: refreshToken);
    notifyListeners();
  }

}

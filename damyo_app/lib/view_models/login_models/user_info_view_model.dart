import 'package:damyo_app/models/user/user_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserInfoViewModel extends ChangeNotifier {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  UserInfoModel _userInfoModel = UserInfoModel("홍길동", "profile-url", 0, 0, 0);
  UserInfoModel get userInfoModel => _userInfoModel;

  updateUserInfoModel(UserInfoModel model) {
    _userInfoModel = model;
    notifyListeners();
  }
}

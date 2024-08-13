import 'package:damyo_app/models/login/user_info_model.dart';
import 'package:flutter/material.dart';

class UserInfoViewModel extends ChangeNotifier {
  
  final UserInfoModel _userInfoModel = UserInfoModel();
  
  UserInfoModel get userInfoModel => _userInfoModel;

  void setName(String name) {
    _userInfoModel.name = name;
    notifyListeners();
  }

  void setNickname(String nickname) {
    _userInfoModel.nickname = nickname;
    notifyListeners();
  }

  void setAge(int age) {
    _userInfoModel.age = age;
    notifyListeners();
  }

  void setContribution(int contribution) {
    _userInfoModel.contribution = contribution;
    notifyListeners();
  }

  void setGender(bool gender) {
    _userInfoModel.gender = gender;
    notifyListeners();
  }
}

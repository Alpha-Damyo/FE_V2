import 'package:damyo_app/models/login/user_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserInfoViewModel extends ChangeNotifier {
  
  FlutterSecureStorage storage = const FlutterSecureStorage();
  
  final UserInfoModel _userInfoModel = UserInfoModel(name: '홍길동');
  
  UserInfoModel get userInfoModel => _userInfoModel;

  void setName(String name) {
    _userInfoModel.name = name;
    storage.write(key: 'name', value: name);
    notifyListeners();
  }

  void setNickname(String nickname) {
    _userInfoModel.nickname = nickname;
    storage.write(key: 'nickname', value: nickname);
    notifyListeners();
  }

  void setAge(int age) {
    _userInfoModel.age = age;
    storage.write(key: 'age', value: age.toString());
    notifyListeners();
  }

  void setContribution(int contribution) {
    _userInfoModel.contribution = contribution;
    storage.write(key: 'contribution', value: contribution.toString());
    notifyListeners();
  }

  void setGender(bool gender) {
    _userInfoModel.gender = gender;
    storage.write(key: 'gender', value: gender.toString());
    notifyListeners();
  }

  void resetInfo(){
    storage.deleteAll();
    notifyListeners();
  }
}

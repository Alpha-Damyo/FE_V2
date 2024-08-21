import 'package:damyo_app/models/login/islogin_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class IsloginViewModel extends ChangeNotifier {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  final IsloginModel _isloginModel = IsloginModel(isLogin: false);
  
  IsloginModel get isloginModel => _isloginModel;

  void login() {
    _isloginModel.isLogin = true;
    storage.write(key: 'loginState', value: 'true');
    notifyListeners();
  }

  void logout() {
    _isloginModel.isLogin = false;
    storage.write(key: 'loginState', value: 'false');
    notifyListeners();
  }
}

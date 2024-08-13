import 'package:damyo_app/models/login/islogin_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

class IsloginViewModel extends ChangeNotifier {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  final IsloginModel _isloginModel =
      IsloginModel(isLogin: false, isFirst: true);
  
  IsloginModel get isloginModel => _isloginModel;

  void login() {
    _isloginModel.isLogin = true;
    notifyListeners();
  }

  void logout() async {
    _isloginModel.isLogin = false;
    await storage.deleteAll();
    notifyListeners();
  }

  void checkFirst() async {
    _isloginModel.isFirst = false;
    notifyListeners();
  }
}

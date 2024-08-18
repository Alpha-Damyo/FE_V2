import 'package:damyo_app/models/login/islogin_model.dart';
import 'package:flutter/material.dart';

class IsloginViewModel extends ChangeNotifier {
  
  final IsloginModel _isloginModel = IsloginModel(isLogin: false);
  
  IsloginModel get isloginModel => _isloginModel;

  void login() {
    _isloginModel.isLogin = true;
    notifyListeners();
  }

  void logout() async {
    _isloginModel.isLogin = false;
    notifyListeners();
  }
}

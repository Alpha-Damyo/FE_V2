import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class IsloginViewModel extends ChangeNotifier {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  bool _isLogin = false;
  bool get isLogin => _isLogin;

  void login() {
    _isLogin = true;
    storage.write(key: 'loginState', value: 'true');
    notifyListeners();
  }

  void logout() {
    _isLogin = false;
    storage.write(key: 'loginState', value: 'false');
    notifyListeners();
  }
}

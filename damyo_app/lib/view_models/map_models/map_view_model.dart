// 제보 버튼을 관리해주는 provider
import 'package:flutter/material.dart';

class MapViewModel extends ChangeNotifier {
  bool _informBtnVisible = false;
  bool get informBtnVisible => _informBtnVisible;

  changeInformBtnVisible() {
    _informBtnVisible = !_informBtnVisible;
    notifyListeners();
  }
}

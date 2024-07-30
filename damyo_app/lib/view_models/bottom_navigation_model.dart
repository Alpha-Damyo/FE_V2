import 'package:flutter/material.dart';

class BottomNavigationModel extends ChangeNotifier {
  int _curPage = 0;
  int get curPage => _curPage;

  setCurPage(int index) {
    _curPage = index;
    notifyListeners();
  }
}

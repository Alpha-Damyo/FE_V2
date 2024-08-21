import 'package:flutter/material.dart';

class BottomNavigationModel extends ChangeNotifier {
  int _curPage = 0;
  int get curPage => _curPage;

  setCurPage(int index) {
    _curPage = index;
    notifyListeners();
  }

  int _searchPage = 0;
  int get searchPage => _searchPage;
  setSearchPage(int index) {
    _searchPage = index;
    notifyListeners();
  }
}

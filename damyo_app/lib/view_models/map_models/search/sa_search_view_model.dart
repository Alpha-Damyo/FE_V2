import 'dart:convert';
import 'dart:core';

import 'package:damyo_app/models/smoking_area/sa_basic_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SaSearchViewModel extends ChangeNotifier {
  // 상태
  // 0: 검색 없음, 최근 검색어 보여줌
  // 1: 검색 진행 중, 로딩
  // 2: 검색 완료, 검색 결과 보여줌
  int _searchState = 0;
  int get searchState => _searchState;

  setSearchState(int val) {
    _searchState = val;
    notifyListeners();
  }

  // 흡연구역 검색 결과
  List<SaBasicModel> _searchedSaList = [];
  List<SaBasicModel> get searchedSaList => _searchedSaList;

  setSearchedSaList(List<SaBasicModel> newList) {
    _searchedSaList = newList;
    notifyListeners();
  }

  // 최근검색어 rhksfus
  bool _updateRecentWords = false;
  bool get updateRecentWords => _updateRecentWords;

  List<String> _recentSearchWords = [];
  List<String> get recentSearchWords => _recentSearchWords;
  List<String> _recentSearchDates = [];
  List<String> get recentSearchDates => _recentSearchDates;

  readRecentSearchWords() async {
    if (_updateRecentWords == false) {
      FlutterSecureStorage storage = const FlutterSecureStorage();
      String? strWords = await storage.read(key: "recentSearchWords");
      if (strWords == null) {
        _recentSearchWords = [];
      } else {
        _recentSearchWords = jsonDecode(strWords).map((item) {
          return item
              .map((key, value) => MapEntry(key.toString(), value.toString()));
        }).toList();
      }
      String? strDates = await storage.read(key: "recentSearchDates");
      if (strDates == null) {
        _recentSearchDates = [];
      } else {
        _recentSearchDates = jsonDecode(strDates).map((item) {
          return item
              .map((key, value) => MapEntry(key.toString(), value.toString()));
        }).toList();
      }

      _updateRecentWords = true;
    }
  }

  updateRecentSearchWord(String word) async {
    if (_recentSearchWords.contains(word)) {}
    _recentSearchWords.add(word);
    _recentSearchDates.add(DateTime.now().toString().substring(5, 10));
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.write(
        key: "recentSearchWords", value: jsonEncode(_recentSearchWords));
    await storage.write(
        key: "recentSearchDates", value: jsonEncode(_recentSearchDates));

    notifyListeners();
  }

  // TextEditingController
  final TextEditingController _searchWordController = TextEditingController();
  TextEditingController get searchWordController => _searchWordController;
}

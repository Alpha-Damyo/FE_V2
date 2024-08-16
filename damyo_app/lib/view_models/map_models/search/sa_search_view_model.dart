import 'package:damyo_app/models/smoking_area/sa_basic_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  // 흡연구역 검색 내역
  List<SaBasicModel> _searchedSaList = [];
  List<SaBasicModel> get searchedSaList => _searchedSaList;

  setSearchedSaList(List<SaBasicModel> newList) {
    _searchedSaList = newList;
    notifyListeners();
  }

  // TextEditingController
  final TextEditingController _saNameController = TextEditingController();
  TextEditingController get saNameController => _saNameController;
}

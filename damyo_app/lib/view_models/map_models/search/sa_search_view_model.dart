import 'dart:convert';
import 'dart:core';

import 'package:damyo_app/icon/damyo_icon_icons.dart';
import 'package:damyo_app/models/smoking_area/sa_basic_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
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

  setSearchedSaList(BuildContext context, List<SaBasicModel> newList) async {
    // 검색된 리스트 반영
    _searchedSaList = newList;
    // 지도에도 반영하여 마커 추가
    _naverMapController.clearOverlays();
    Widget basicIcon = const Icon(
      Icons.location_on,
      color: Colors.red,
      size: 40,
    );

    for (int i = 0; i < newList.length; i++) {
      final iconImage = await NOverlayImage.fromWidget(
          widget: Column(
            children: [
              basicIcon,
              const SizedBox(height: 5),
              Stack(
                children: [
                  Text(
                    // 디바이스의 글자 스케일 등을 처리할 때 이용
                    _searchedSaList[i].name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      foreground: Paint()
                        ..color = Colors.white
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2,
                    ),
                    // 텍스트의 오버플로우 처리가 있을 경우 동시에 적용
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(_searchedSaList[i].name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black,
                      )),
                ],
              )
            ],
          ),
          size: const Size(140, 70),
          context: context);

      final NMarker marker = NMarker(
        id: _searchedSaList[i].areaId,
        position: NLatLng(
          _searchedSaList[i].latitude,
          _searchedSaList[i].longitude,
        ),
        icon: iconImage,
      );

      marker.setOnTapListener((overlay) {
        updateSearchSelectedSa(_searchedSaList[i]);
      });
      // marker.setZIndex(i);
      marker.setMinZoom(12);
      marker.setIsMinZoomInclusive(true);
      marker.setIsMaxZoomInclusive(false);
      _naverMapController.addOverlay(marker);

      // final onMarkerInfoWindow = NInfoWindow.onMarker(
      //   id: marker.info.id,
      //   text: _searchedSaList[i].name,
      // );
      // marker.openInfoWindow(onMarkerInfoWindow);

      // final infoWindow = NInfoWindow.onMarker(
      //     id: marker.info.id, text: _searchedSaList[i].name);
      // _naverMapController.addOverlay(infoWindow);
    }
    notifyListeners();
  }

  // 최근검색어 관련
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
        _recentSearchWords = List<String>.from(jsonDecode(strWords));
      }
      String? strDates = await storage.read(key: "recentSearchDates");
      if (strDates == null) {
        _recentSearchDates = [];
      } else {
        _recentSearchDates = List<String>.from(jsonDecode(strDates));
      }

      _updateRecentWords = true;
    }
  }

  updateRecentSearchWord(String word) async {
    if (_recentSearchWords.contains(word)) {
      int idx = _recentSearchWords.indexOf(word);
      _recentSearchWords.removeAt(idx);
      _recentSearchDates.removeAt(idx);
      _recentSearchWords.insert(0, word);
      _recentSearchDates.insert(0, DateTime.now().toString().substring(5, 10));
    } else {
      _recentSearchWords.insert(0, word);
      _recentSearchDates.insert(0, DateTime.now().toString().substring(5, 10));
    }
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.write(
        key: "recentSearchWords", value: jsonEncode(_recentSearchWords));
    await storage.write(
        key: "recentSearchDates", value: jsonEncode(_recentSearchDates));
    notifyListeners();
  }

  deleteRecentSearchWord(int index) async {
    _recentSearchWords.removeAt(index);
    _recentSearchDates.removeAt(index);
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

  // 지도에서 검색된 흡연구역을 보여줌
  SaBasicModel _searchSelectedSa =
      SaBasicModel("null", "null", 37.5666, 126.979, "null", 0);
  SaBasicModel get searchSelectedSa => _searchSelectedSa;

  updateSearchSelectedSa(SaBasicModel sa) {
    _searchSelectedSa = sa;
    notifyListeners();
  }

  late NaverMapController _naverMapController;
  updateNaverMapController(NaverMapController controller) {
    _naverMapController = controller;
  }

  moveMapCamera() {
    _naverMapController.updateCamera(
      NCameraUpdate.scrollAndZoomTo(
        target:
            NLatLng(_searchSelectedSa.latitude, _searchSelectedSa.longitude),
        zoom: 15,
      ),
    );
  }
}

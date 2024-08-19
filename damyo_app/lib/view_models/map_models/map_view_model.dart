// 제보 버튼을 관리해주는 provider
import 'package:damyo_app/models/smoking_area/sa_basic_model.dart';
import 'package:damyo_app/models/smoking_area/sa_search_model.dart';
import 'package:damyo_app/services/favorites_service.dart';
import 'package:damyo_app/services/smoking_area_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class MapViewModel extends ChangeNotifier {
  // 흡연구역 목록
  List<SaBasicModel> _smokingAreas = [];
  List<SaBasicModel> get smokingAreas => _smokingAreas;

  // 흡연구역 검색 모델
  final SaSearchModel _saSearchModel = SaSearchModel(
    latitude: 37.5666,
    longitude: 126.979,
    range: 0.005,
  );
  SaSearchModel get saSearchModel => _saSearchModel;

  updateSaSearchModel(double lat, double lng) {
    _saSearchModel.latitude = lat;
    _saSearchModel.longitude = lng;
    _saSearchModel.opened = null;
    _saSearchModel.closed = null;
    _saSearchModel.indoor = null;
    _saSearchModel.outdoor = null;
    switch (tagIndex) {
      case 0:
        _saSearchModel.opened = true;
      case 1:
        _saSearchModel.closed = true;
      case 2:
        _saSearchModel.outdoor = true;
      case 3:
        _saSearchModel.indoor = true;
    }
    notifyListeners();
  }

  // 태그 (개방, 폐쇄, 실외, 실내) 관리
  int _tagIndex = -1;
  int get tagIndex => _tagIndex;
  updateTagIndex(index) {
    _researchBtnVisible = false;
    if (_tagIndex == index) {
      _tagIndex = -1;
    } else {
      _tagIndex = index;
    }
    notifyListeners();
  }

  // 흡연구역 정보 카드
  bool _showSmokingAreaCard = false;
  SaBasicModel _smokingAreaCardInfo =
      SaBasicModel("-1", "null", 0, 0, "null", 0);

  bool get showSmokingAreaCard => _showSmokingAreaCard;
  SaBasicModel get smokingAreaCardInfo => _smokingAreaCardInfo;

  // 흡연구역 업데이트
  updateSmokingAreas(NaverMapController mapController) async {
    _smokingAreas =
        await SmokingAreaService.searchSmokingAreaByTag(_saSearchModel);
    mapController.clearOverlays();
    for (int i = 0; i < _smokingAreas.length; i++) {
      final NMarker marker = NMarker(
        id: _smokingAreas[i].areaId,
        position: NLatLng(
          _smokingAreas[i].latitude,
          _smokingAreas[i].longitude,
        ),
      );
      marker.setOnTapListener((overlay) {
        _smokingAreaCardInfo = _smokingAreas[i];
        _showSmokingAreaCard = true;
        notifyListeners();
      });

      mapController.addOverlay(marker);
    }
    notifyListeners();
  }

  closeSmokingAreaCard() {
    _showSmokingAreaCard = false;
    notifyListeners();
  }

  // 지도 카메라 이동 여부 관리 (이 위치에서 재탐색 버튼 보여주기용)
  bool _researchBtnVisible = false;
  bool get researchBtnVisible => _researchBtnVisible;

  trueResearchBtnVisible() {
    _researchBtnVisible = true;
    notifyListeners();
  }

  falseResearchBtnVisible() {
    _researchBtnVisible = false;
    notifyListeners();
  }

  // 제보 버튼
  bool _informBtnVisible = false;
  bool get informBtnVisible => _informBtnVisible;

  changeInformBtnVisible() {
    _informBtnVisible = !_informBtnVisible;
    notifyListeners();
  }

  // 즐겨찾기
  final List<dynamic> _favoritesList = [];
  List<dynamic> get favoritesList => _favoritesList;

  loadFavorites() {
    FavoritesService.loadFavorites();
    notifyListeners();
  }

  addFavoritesList(String listName) {
    _favoritesList.add([listName, []]);
    notifyListeners();
  }

  addFavoritesElement(int index) {
    _favoritesList[index][1].add(smokingAreaCardInfo.areaId);
  }
}

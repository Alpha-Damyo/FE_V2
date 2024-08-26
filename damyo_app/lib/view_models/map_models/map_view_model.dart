// 제보 버튼을 관리해주는 provider
import 'package:damyo_app/models/smoking_area/sa_basic_model.dart';
import 'package:damyo_app/models/smoking_area/sa_search_model.dart';
import 'package:damyo_app/services/favorites_service.dart';
import 'package:damyo_app/services/smoking_area_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

double curLat = 37.5666;
double curLng = 126.979;

class MapViewModel extends ChangeNotifier {
  // 흡연구역 컨트롤러
  late NaverMapController mapController;
  // 흡연구역 목록
  List<SaBasicModel> _smokingAreas = [];
  List<SaBasicModel> get smokingAreas => _smokingAreas;

  double get getCurLat => curLat;
  double get getCurLng => curLng;

  // 현재 위치 받아오기
  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      curLat = position.latitude;
      curLng = position.longitude;
    } catch (e) {
      Fluttertoast.showToast(msg: "현재 위치를 불러올 수 없습니다");
    }
    notifyListeners();
  }

  // 흡연구역 검색 모델
  final SaSearchModel _saSearchModel = SaSearchModel(
    latitude: 37.5666,
    longitude: 126.979,
    range: 0.05,
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
  updateSmokingAreas(BuildContext context) async {
    _smokingAreas =
        await SmokingAreaService.searchSmokingAreaByTag(_saSearchModel);
    mapController.clearOverlays();

    const iconImage =
        NOverlayImage.fromAssetImage("assets/icons/map/marker.png");

    for (int i = 0; i < _smokingAreas.length; i++) {
      final NMarker marker = NMarker(
        id: _smokingAreas[i].areaId,
        position: NLatLng(
          _smokingAreas[i].latitude,
          _smokingAreas[i].longitude,
        ),
        icon: iconImage,
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
    // print("truetruetruetruetruetruetruetrue");
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
  List<dynamic> _favoritesList = [];
  List<dynamic> get favoritesList => _favoritesList;

  loadFavorites() async {
    _favoritesList = await FavoritesService.loadFavorites();
    if (_favoritesList.isEmpty) {
      _favoritesList.add(['기본', [], []]);
    }
    notifyListeners();
  }

  addFavoritesList(String listName) {
    _favoritesList.add([listName, [], []]);
    notifyListeners();
  }

  removeFavoritesList(int index) {
    _favoritesList.removeAt(index);
    notifyListeners();
  }

  addFavoritesElement(int index, String areaId, String name) {
    _favoritesList[index][1].add(areaId);
    _favoritesList[index][2].add(name);
  }

  removeFavoritesElement(int listIndex, int elementIndex) {
    _favoritesList[listIndex][1].removeAt(elementIndex);
    _favoritesList[listIndex][2].removeAt(elementIndex);
  }

  changeSmokingAreaCardInfo(SaBasicModel model) {
    _smokingAreaCardInfo = model;
    notifyListeners();
  }

  // 장소 이동
  moveCamera(double lat, double lng) {
    mapController.updateCamera(
      NCameraUpdate.scrollAndZoomTo(
        target: NLatLng(lat, lng),
        zoom: 15,
      ),
    );
    notifyListeners();
  }

  // 즐겨찾기에서 장소를 고른 경우
  tapFavoritesSa(BuildContext context, SaBasicModel sa) async {
    _showSmokingAreaCard = true;
    _smokingAreaCardInfo = sa;

    mapController.clearOverlays();

    const iconImage =
        NOverlayImage.fromAssetImage("assets/icons/map/marker.png");

    final NMarker marker = NMarker(
      id: _smokingAreaCardInfo.areaId,
      position: NLatLng(
        _smokingAreaCardInfo.latitude,
        _smokingAreaCardInfo.longitude,
      ),
      icon: iconImage,
    );
    marker.setOnTapListener((overlay) {
      _showSmokingAreaCard = true;
      notifyListeners();
    });

    mapController.addOverlay(marker);

    mapController.updateCamera(
      NCameraUpdate.scrollAndZoomTo(
        target: NLatLng(
            _smokingAreaCardInfo.latitude, _smokingAreaCardInfo.longitude),
        zoom: 15,
      ),
    );
    notifyListeners();
  }
}

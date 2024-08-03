// 제보 버튼을 관리해주는 provider
import 'package:damyo_app/models/smoking_area/sa_basic_model.dart';
import 'package:damyo_app/models/smoking_area/sa_search_model.dart';
import 'package:damyo_app/services/smoking_area_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class MapViewModel extends ChangeNotifier {
  // 흡연구역 목록
  List<SaBasicModel> _smokingAreas = [];
  List<SaBasicModel> get smokingAreas => _smokingAreas;

  // 흡연구역 정보 카드
  bool _showSmokingAreaCard = false;
  late SaBasicModel _smokingAreaCardInfo;

  bool get showSmokingAreaCard => _showSmokingAreaCard;
  SaBasicModel get smokingAreawCardInfo => _smokingAreaCardInfo;

  // 흡연구역 업데이트
  updateSmokingAreas(
      SaSearchModel saSearchModel, NaverMapController mapController) async {
    _smokingAreas = await SmokingAreaService.searchSmokingArea(saSearchModel);
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
      });

      mapController.addOverlay(marker);
    }
    notifyListeners();
  }

  closeSmokingAreaCard() {
    _showSmokingAreaCard = false;
  }

  // 제보 버튼
  bool _informBtnVisible = false;
  bool get informBtnVisible => _informBtnVisible;

  changeInformBtnVisible() {
    _informBtnVisible = !_informBtnVisible;
    notifyListeners();
  }
}

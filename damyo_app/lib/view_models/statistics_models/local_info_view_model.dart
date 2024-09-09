import 'package:damyo_app/models/smoking_area/sa_basic_model.dart';
import 'package:damyo_app/models/statistics_info/stat_region_model.dart';
import 'package:damyo_app/services/statistics_service.dart';
import 'package:damyo_app/services/smoking_area_service.dart';
import 'package:flutter/material.dart';

class LocalInfoViewModel extends ChangeNotifier {
  LocalInfoViewModel();

  List<dynamic>? _guList = [];
  List<dynamic>? _areaList = [];
  List<dynamic>? _areaInfo = [];

  List<dynamic>? get guList => _guList;
  List<dynamic>? get areaList => _areaList;
  List<dynamic>? get areaInfo => _areaInfo;

  Future<void> fetchLocalDB() async {
    List<SaBasicModel>? area = [];

    StatRegionModel? region;

    region = await getRegionStatics();

    _areaList = region.areaTop;
    _guList = [];
    List<dynamic>? gulist = region.allRegion;

    if (_areaList != null) {
      for (int i = 0; i < _areaList!.length; i++) {
        if (i >= 3) {
          break;
        }
        SaBasicModel popArea =
            await SmokingAreaService.serachSmokingAreaByAreaId(
                _areaList![i].keys.first);
        area.add(popArea);
      }
    }

    // null 체크를 api에서 받아올 때 진행
    for (int i = 0; i < gulist.length; i++) {
      if (i >= 3) {
        break;
      }
      _guList?.add(gulist[i]);
    }
  
    _areaInfo = area;

    notifyListeners();
  }
}

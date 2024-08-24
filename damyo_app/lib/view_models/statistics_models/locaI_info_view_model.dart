import 'package:damyo_app/database/smoke_data.dart';
import 'package:damyo_app/models/smoking_area/sa_basic_model.dart';
import 'package:damyo_app/models/statistics_info/stat_region_model.dart';
import 'package:damyo_app/services/statistics_service.dart';
import 'package:damyo_app/services/smoking_area_service.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class LocalInfoViewModel extends ChangeNotifier {
  LocalInfoViewModel();

  List<dynamic>? _GuList = [];
  List<dynamic>? _areaList = [];
  List<dynamic>? _areaInfo = [];

  List<dynamic>? get GuList => _GuList;
  List<dynamic>? get areaList => _areaList;
  List<dynamic>? get areaInfo => _areaInfo;

  Future<void> fetchLocalDB() async {
    List<SaBasicModel>? area = [];

    statRegionModel? Region;

    Region = await getRegionStatics();

    _areaList = Region.areaTop;
    _GuList = [];
    List<dynamic>? _gulist = Region.allRegion;

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

    if (_gulist != null) {
      for (int i = 0; i < _gulist.length; i++) {
        if (i >= 3) {
          break;
        }
        _GuList?.add(_gulist[i]);
      }
    }
    
    _areaInfo = area;

    notifyListeners();
  }
}

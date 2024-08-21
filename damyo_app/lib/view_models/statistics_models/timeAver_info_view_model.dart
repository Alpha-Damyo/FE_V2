import 'package:damyo_app/database/smoke_data.dart';
import 'package:damyo_app/models/statistics_info/stat_date_model.dart';
import 'package:damyo_app/services/statistics_service.dart';
import 'package:flutter/material.dart';

class TimeaverInfoViewModel extends ChangeNotifier {
  TimeaverInfoViewModel();

  Map<String,dynamic>? _userTimeInfo;
  List<dynamic>? _everyTimeInfo = [];

  Map<String,dynamic>? get userTimeInfo => _userTimeInfo;
  List<dynamic>? get everyTimeInfo => _everyTimeInfo;

  Future<void> fetchTimeDB(SmokeDatabase userDB)async{
    statDateModel dateModel;
    
    dateModel = await getDateStatics();
    
    _everyTimeInfo = dateModel.time;
    _userTimeInfo = await userDB.getThreeHourlyAverages();

    notifyListeners();
  }
}
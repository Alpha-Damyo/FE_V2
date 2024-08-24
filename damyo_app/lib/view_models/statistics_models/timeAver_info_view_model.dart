import 'package:damyo_app/database/smoke_data.dart';
import 'package:damyo_app/models/statistics_info/stat_date_model.dart';
import 'package:damyo_app/services/statistics_service.dart';
import 'package:flutter/material.dart';

class TimeaverInfoViewModel extends ChangeNotifier {
  TimeaverInfoViewModel();

  List<dynamic>? _everyTimeInfo = [];

  List<dynamic>? get everyTimeInfo => _everyTimeInfo;

  Future<void> fetchTimeDB(BuildContext context) async {
    statDateModel dateModel;

    dateModel = await getDateStatics(context);

    _everyTimeInfo = dateModel.time;

    notifyListeners();
  }
}

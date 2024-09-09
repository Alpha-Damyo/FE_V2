import 'package:damyo_app/models/statistics_info/stat_date_model.dart';
import 'package:damyo_app/services/statistics_service.dart';
import 'package:flutter/material.dart';

class PeriodInfoViewModel extends ChangeNotifier {
  PeriodInfoViewModel();

  List<double>? _everyDayWeek, _everyWeeks, _everyMonths;

  List<double>? get everyDayWeek => _everyDayWeek;
  List<double>? get everyWeeks => _everyWeeks;
  List<double>? get everyMonths => _everyMonths;

  Future<void> fetchPeriodEveryDB() async {
    StatDateModel dateModel;

    dateModel = await getDateStatics();

    _everyDayWeek = dateModel.dayWeek.cast<double>();
    _everyWeeks = dateModel.weeks.cast<double>();
    _everyMonths = dateModel.months.cast<double>();

    notifyListeners();
  }

  
}

import 'package:damyo_app/database/smoke_data.dart';
import 'package:flutter/material.dart';

class SmokeViewModel extends ChangeNotifier {
  SmokeViewModel();

  DateTime now = DateTime.now();

  List<String> weekOrder = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  List<dynamic> _smokePlace = [];
  Map<String, dynamic>? _userTimeInfo;
  late List<dynamic> _userWeekdayInfo, _userWeeksInfo, _userMonthsInfo;
  double? _maxD, _maxW, _maxM;
  int? _cntDay, _cntWeek, _cntMonth;

  List<dynamic> get smokePlace => _smokePlace;
  
  Map<String, dynamic>? get userTimeInfo => _userTimeInfo;

  List<dynamic> get userDayWeekInfo => _userWeekdayInfo;
  List<dynamic> get userWeeksInfo => _userWeeksInfo;
  List<dynamic> get userMonthsInfo => _userMonthsInfo;

  double? get maxD => _maxD;
  double? get maxW => _maxW;
  double? get maxM => _maxM;

  int? get cntDay => _cntDay;
  int? get cntWeek => _cntWeek;
  int? get cntMonth => _cntMonth;

  Future<void> fetchSmokeDB(SmokeDatabase userDB) async {
    _smokePlace = await userDB.getSmokeInfoGroupedByColumn('id');
    _userTimeInfo = await userDB.getThreeHourlyAverages();

    double maxD = 0, maxW = 0, maxM = 0;

    List<dynamic> smokeCountsD = List.filled(7, 0);
    List<dynamic> smokeCountsW = List.filled(4, 0);
    List<dynamic> smokeCountsM = List.filled(6, 0);

    final startDateD = now.subtract(Duration(days: 6));
    final dataInRangeD =
        await userDB.getSmokeInfoInWeekDayRange(startDateD, now);

    for (var item in dataInRangeD) {
      int index = weekOrder.indexOf(item['weekday']);
      if (index != -1) {
        smokeCountsD[index] = item['count'];
        if (maxD < item['count']) {
          maxD = item['count'] * 1.0;
        }
      }
    }

    for (int i = 0; i < 4; i++) {
      final startDateW = now.subtract(Duration(days: 6 + (7 * i)));
      final endDateW = now.subtract(Duration(days: 7 * i));
      final dateInRangeW =
          await userDB.getSmokeInfoInWeeksRange(startDateW, endDateW);
      smokeCountsW[i] = dateInRangeW.first['count'];
      if (maxW < dateInRangeW.first['count']) {
        maxW = dateInRangeW.first['count'] * 1.0;
      }
    }

    for (int i = 0; i < 6; i++) {
      final startDateM = now.subtract(Duration(days: 27 + (28 * i)));
      final endDateM = now.subtract(Duration(days: 28 * i));
      final dateInRangeM =
          await userDB.getSmokeInfoInWeeksRange(startDateM, endDateM);
      smokeCountsM[i] = dateInRangeM.first['count'];
      if (maxM < dateInRangeM.first['count']) {
        maxM = dateInRangeM.first['count'] * 1.0;
      }
    }

    _userWeekdayInfo = smokeCountsD;
    _userWeeksInfo = smokeCountsW;
    _userMonthsInfo = smokeCountsM;

    _maxD = maxD;
    _maxW = maxW;
    _maxM = maxM;

    final dateInRangeD = await userDB.getSmokeInfoInWeeksRange(now, now);
    
    final startDateW = now.subtract(const Duration(days: 6));
    final dateInRangeW = await userDB.getSmokeInfoInWeeksRange(startDateW, now);

    final startDateM = now.subtract(const Duration(days: 27));
    final dateInRangeM = await userDB.getSmokeInfoInWeeksRange(startDateM, now);
    
    _cntDay = dateInRangeD.first['count'];
    _cntWeek = dateInRangeW.first['count'];
    _cntMonth = dateInRangeM.first['count'];

    notifyListeners();
  }
}

import 'package:damyo_app/database/smoke_data.dart';
import 'package:flutter/material.dart';

class SmokeViewModel extends ChangeNotifier {
  SmokeViewModel();

  List<dynamic> _smokePlace = [];

  List<dynamic> get smokePlace => _smokePlace;

  Future<void> fetchSmokeDB(SmokeDatabase userDB) async {
    _smokePlace = await userDB.getSmokeInfoGroupedByColumn('id');
    notifyListeners();
  }
}
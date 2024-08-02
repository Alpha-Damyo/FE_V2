import 'package:flutter/material.dart';

class SmokingAreaModel extends ChangeNotifier {
  List<String> _smokingAreas = [];
  List<String> get smokingAreas => _smokingAreas;

  updateSmokingAreas(double lat, double lng) {
    _smokingAreas = [];
    notifyListeners();
  }
}

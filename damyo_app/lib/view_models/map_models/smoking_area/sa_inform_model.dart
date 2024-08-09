import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SaInformModel extends ChangeNotifier {
  // 제보 이미지
  XFile? _informImage;
  XFile? get informImage => _informImage;

  setInformImage(XFile xFile) {
    _informImage = xFile;
    notifyListeners();
  }

  // 제보 별점
  double _starValue = 0.0;
  double get starValue => _starValue;

  setStarValue(double val) {
    _starValue = val;
    _canInform = true;
    notifyListeners();
  }

  // 제보하기 버튼 활성화
  bool _canInform = false;
  bool get canReview => _canInform;

  resetAll() {
    _informImage = null;
    _starValue = 0;
    _canInform = false;
  }
}

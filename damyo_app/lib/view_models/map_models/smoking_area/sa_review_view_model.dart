import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SaReviewViewModel extends ChangeNotifier {
  // 리뷰 이미지
  XFile? _reviewImage;
  XFile? get reviewImage => _reviewImage;

  setReviewImage(XFile xFile) {
    _reviewImage = xFile;
    notifyListeners();
  }

  // 리뷰 별점
  double _starValue = 0.0;
  double get starValue => _starValue;

  setStarValue(double val) {
    _starValue = val;
    _canReview = true;
    notifyListeners();
  }

  // 리뷰 완료 버튼 활성화
  bool _canReview = false;
  bool get canReview => _canReview;

  resetAll() {
    _reviewImage = null;
    _starValue = 0;
    _canReview = false;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  updateIsLoading(bool b) {
    _isLoading = b;
    notifyListeners();
  }
}

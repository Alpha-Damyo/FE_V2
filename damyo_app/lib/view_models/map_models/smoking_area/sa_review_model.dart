import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SaReviewModel extends ChangeNotifier {
  XFile? _reviewImage;
  XFile? get reviewImage => _reviewImage;

  setReviewImage(XFile xfile) {
    _reviewImage = xfile;
    notifyListeners();
  }

  resetReviewImage() {
    _reviewImage = null;
  }
}

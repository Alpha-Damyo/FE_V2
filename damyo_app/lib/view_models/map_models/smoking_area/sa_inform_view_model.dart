import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class SaInformViewModel extends ChangeNotifier {
  // TextEditingController
  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final TextEditingController _descriptionController = TextEditingController();
  TextEditingController get descriptionController => _descriptionController;

  // 제보 이미지
  XFile? _informImage;
  XFile? get informImage => _informImage;

  setInformImage(XFile xFile) {
    _informImage = xFile;
    notifyListeners();
  }

  // 제보 주소
  String _address = "";
  String get address => _address;

  setAddress(String val) {
    _address = val;
  }

  // 제보 별점
  double _starValue = 0;
  double get starValue => _starValue;

  setStarValue(double val) {
    _starValue = val;
    checkCanInform();
    notifyListeners();
  }

  // 제보 실내/실외, 개방/폐쇄
  bool _inside = false;
  bool get inside => _inside;
  bool _outside = false;
  bool get outside => _outside;
  bool _open = false;
  bool get open => _open;
  bool _close = false;
  bool get close => _close;

  setInOut(int index) {
    _inside = (index == 0);
    _outside = (index == 1);
    checkCanInform();
    notifyListeners();
  }

  setOpenClose(int index) {
    _open = (index == 0);
    _close = (index == 1);
    checkCanInform();
    notifyListeners();
  }

  // 제보하기 버튼 활성화
  bool _canInform = false;
  bool get canInform => _canInform;

  void checkCanInform() {
    if (_nameController.text.isEmpty) {
      _canInform = false;
    } else if (_starValue == 0) {
      _canInform = false;
    } else if (!(_inside || _outside)) {
      _canInform = false;
    } else if (!(_open || _close)) {
      _canInform = false;
    } else {
      _canInform = true;
    }
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  updateIsLoading(bool b) {
    _isLoading = b;
    notifyListeners();
  }

  resetAll() {
    _nameController.clear();
    _descriptionController.clear();
    _informImage = null;
    _starValue = 0;
    _canInform = false;
  }
}

import 'package:permission_handler/permission_handler.dart';

// 갤러리 권한 요청
Future<void> getPhotoPermission() async {
  await Permission.photos.request();
}

// 갤러리 권한 조회
Future<bool> checkPhotoPermission() async {
  var status = await Permission.photos.isGranted;
  if (status == true) {
    return Future.value(true);
  } else {
    
    return Future.value(false);
  }
}

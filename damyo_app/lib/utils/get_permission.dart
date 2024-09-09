import 'package:damyo_app/style.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

// 처음 앱을 실행할 때의 상태 -> denied, 우리가 앱 설정을 열어야할 상황 -> permanently denied
// index로 상태 관리
// 0 - 처음, 1 - 전체 허용, 2 - 제한(부모), 3 - 제한(부분 허용)
// 4 - permanentlyDenied, 5 - 알람 관련(얘는 잘 모르겠음), default - error
// 안드로이드는 제한적 허용을 하면 denied 상태 - request 보내기 , 두 번 이상 don't allow 시 permanentlyDenied
// ios는 제한적 허용이 limited - 일단 이때는 기능을 사용할 수 있게, 거부하면 permanentlyDenied - 설정을 열도록

// 갤러리 권한 확인 및 요청
Future<bool> getPhotoPermission(BuildContext context) async {
  PermissionStatus status = await Permission.photos.status;
  // print(status);

  switch (status.index) {
    // 최초 물음
    case 0:
      return requestPhotoPermission();
    // 전체 허용 경우
    case 1:
      return true;
    // 제한적 허용 경우
    case 3:
      return true;
    // permanently Denied
    case 4:
      return noticePermission(context, '갤러리');
    default:
      UnimplementedError();
      return false;
  }
}

// 카메라 권한 확인 및 요청
Future<bool> getCameraPermission(BuildContext context) async {
  PermissionStatus status = await Permission.camera.status;
  // print(status);

  switch (status.index) {
    // 최초 물음
    case 0:
      return requestCameraPermission();
    // 전체 허용 경우
    case 1:
      return true;
    // 제한적 허용 경우
    case 3:
      return true;
    // permanently Denied
    case 4:
      return noticePermission(context, '카메라');
    default:
      UnimplementedError();
      return false;
  }
}

// 갤러리 권한 요청
Future<bool> requestPhotoPermission() async {
  if (await Permission.photos.request() == PermissionStatus.granted) {
    return true;
  } else {
    return false;
  }
}

// 카메라 권한 요청
Future<bool> requestCameraPermission() async {
  if (await Permission.camera.request() == PermissionStatus.granted) {
    return true;
  } else {
    return false;
  }
}

// 권한 설정 알림창
bool noticePermission(BuildContext context, String type) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: textFormat(text: '$type 권한 설정이 필요합니다.', fontSize: 16),
          actions: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Ink(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    child: Text('취소',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary)))),
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  openAppSettings();
                },
                child: Ink(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    child: Text('확인',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary)))),
          ],
        );
      });
  return false;
}

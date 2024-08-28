import 'package:damyo_app/style.dart';
import 'package:damyo_app/utils/get_permission.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Widget nameUpdateBox(
    BuildContext context, TextEditingController nameController) {
  return Expanded(
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: Text(
                '이름',
                style: TextStyle(
                  color: Color(0xFF262B32),
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
              ),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFE4E7EA)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: TextField(
                controller: nameController,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// 이미지를 가져오는 함수
Future<XFile?> getImage(ImagePicker imagePicker) async {
  final XFile? pickedFile =
      await imagePicker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    return pickedFile;
  }
  return null;
}

Widget profileUpdateSelectBtn(ImagePicker imagePicker, Function setImg) {
  return Positioned(
    top: 65,
    left: 65,
    child: IconButton(
      onPressed: () async {
        if (await checkPhotoPermission() == false) {
          await openAppSettings();
        } else {
          XFile? imgfile = await getImage(imagePicker);
          setImg(imgfile);
        }
      },
      icon: Image.asset(
        'assets/icons/setting/updateprofile/camera.png',
        fit: BoxFit.fill,
      ),
    ),
  );
}

Future<void> showErrorLog(BuildContext context, String log) {
  return showModalBottomSheet(
    context: context,
    builder: (dialog) {
      return Container(
        width: 390,
        height: 170,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, top: 43.0, bottom: 36.0),
              child: textFormat(
                text: log, // 전달받은 에러 로그를 출력
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0099FC),
                    fixedSize: const Size(350, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(dialog).pop();
                  },
                  child: textFormat(
                    text: '닫기',
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

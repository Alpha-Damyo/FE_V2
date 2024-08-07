import 'dart:io';

import 'package:damyo_app/style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Widget imageSelector(BuildContext context, ImagePicker imagePicker,
    XFile? image, Function setImage) {
  return InkWell(
    borderRadius: BorderRadius.circular(10),
    child: Container(
      width: double.infinity,
      height: 200,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: imageGetter(image),
    ),
    onTap: () {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('카메라에서 선택'),
                  onTap: () {
                    getImage(ImageSource.camera, imagePicker, image, setImage);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('갤러리에서 선택'),
                  onTap: () {
                    getImage(ImageSource.gallery, imagePicker, image, setImage);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

// 이미지를 가져오는 함수
Future getImage(ImageSource imageSource, ImagePicker imagePicker, XFile? image,
    Function setImage) async {
  final XFile? pickedFile = await imagePicker.pickImage(source: imageSource);
  if (pickedFile != null) {
    setImage(XFile(pickedFile.path));
  }
}

// 이미지를 입력받는 위젯
Widget imageGetter(XFile? image) {
  return image != null
      ? Container(
          alignment: Alignment.center,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Image.file(
            File(image.path),
          ),
        )
      : Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xffeef1f5),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.camera_alt_rounded,
                size: 60,
                color: Color(0xffa9afb7),
              ),
              textFormat(
                text: '사진을 추가해주세요! (선택)',
                color: const Color(0xff464D57),
                fontSize: 12,
              ),
            ],
          ),
        );
}

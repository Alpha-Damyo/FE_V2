import 'dart:io';

import 'package:damyo_app/style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Widget imageSelector(BuildContext context, ImagePicker imagePicker,
    XFile? image, Function setImage) {
  return InkWell(
    borderRadius: BorderRadius.circular(16),
    child: imageGetter(context, image),
    onTap: () {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: textFormat(text: "카메라에서 선택", fontSize: 16),
                  onTap: () {
                    getImage(ImageSource.camera, imagePicker, image, setImage);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: textFormat(text: "갤러리에서 선택", fontSize: 16),
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

// 이미지를 띄우는 컨테이너
Widget imageGetter(BuildContext context, XFile? image) {
  return Container(
    width: double.infinity,
    height: 200,
    decoration: BoxDecoration(
      color: image == null
          ? Theme.of(context).colorScheme.secondaryContainer
          : Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
    ),
    child: image == null
        ? Column(
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
          )
        : Image.file(File(image.path)),
  );
}

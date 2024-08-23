import 'dart:io';
import 'package:damyo_app/services/userprofile_update_service.dart';
import 'package:damyo_app/style.dart';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';
import 'package:damyo_app/view_models/login_models/user_info_view_model.dart';
import 'package:damyo_app/widgets/setting/updateprofile_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

final ImagePicker picker = ImagePicker();

class UpdateprofileView extends StatefulWidget {
  const UpdateprofileView({super.key});

  @override
  State<UpdateprofileView> createState() => _UpdateprofileViewState();
}

class _UpdateprofileViewState extends State<UpdateprofileView> {
  final TextEditingController _nameController = TextEditingController();
  XFile? _profileImage;

  // 이미지를 가져오는 함수
  Future<XFile?> getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      return pickedFile;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserInfoViewModel, TokenViewModel>(
        builder: (context, userInfoViewModel, tokenViewModel, child) {
      return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            '프로필 수정',
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () async {
                  bool photoUpdateSuccess = true;
                  bool nameUpdateSuccess = true;

                  if (_profileImage != null) {
                    try {
                      await putUserUpdateProfile(
                          tokenViewModel, userInfoViewModel, _profileImage!);
                    } catch (e) {
                      // 사진 변경 오류 처리
                      photoUpdateSuccess = false;
                      switch (e.toString()) {
                        case 'G103':
                          showErrorLog(context, "서버에 문제가 발생했습니다.");
                          break;
                        default:
                          showErrorLog(context, "재로그인이 필요합니다.");
                          break;
                      }
                    }
                  }

                  if (!_isFieldEmpty(_nameController)) {
                    try {
                      await putUserUpdateName(tokenViewModel,
                          _nameController.text, userInfoViewModel);
                    } catch (e) {
                      // 이름 변경 오류 처리
                      nameUpdateSuccess = false;
                      switch (e.toString()) {
                        case 'G103':
                          showErrorLog(context, "서버에 문제가 발생했습니다.");
                          break;
                        case 'U102':
                          showErrorLog(context, "중복된 이름입니다.");
                          break;
                        default:
                          showErrorLog(context, "재로그인이 필요합니다.");
                          break;
                      }
                    }
                  }

                  if (photoUpdateSuccess && nameUpdateSuccess) {
                    Navigator.pop(context);
                  }
                },
                child: textFormat(text: '완료', fontSize: 13)),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Stack(children: [
                Container(
                  width: 110,
                  height: 110,
                  padding: const EdgeInsets.only(bottom: 1),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFFDEDEDE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(56),
                    ),
                  ),
                  child: userInfoViewModel.userInfoModel.profileUrl == null
                      ? Image.asset(
                          'assets/icons/setting/updateprofile/defalut.png')
                      : _profileImage == null
                          ? Image.network(
                              userInfoViewModel.userInfoModel.profileUrl!)
                          : Image.file(
                              File(_profileImage!.path),
                            ),
                ),
                profileUpdateSelectBtn(getImage, (img) {
                  setState(() {
                    if (img != null) {
                      _profileImage = img;
                    } else {
                      _profileImage = null;
                    }
                  });
                }),
              ]),
              nameUpdateBox(context, _nameController),
            ],
          ),
        ),
      );
    });
  }
}

bool _isFieldEmpty(TextEditingController controller) {
  return controller.text.trim().isEmpty;
}

import 'package:damyo_app/view_models/login_models/islogin_view_model.dart';
import 'package:damyo_app/view_models/login_models/user_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:damyo_app/widgets/setting_widgets.dart';
import 'package:provider/provider.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<IsloginViewModel, UserInfoViewModel>(
        builder: (context, isloginViewModel, userInfoViewModel, child) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(isloginViewModel.isloginModel.isLogin)
              userProfile(context, isloginViewModel, userInfoViewModel)
            else
              loginBtn(context),
            toolBax(context, '즐겨찾기 관리'),
            toolBax(context, '흡연구역 업데이트'),
            toolBax(context, '업적'),
            toolBax(context, '흡연데이터 초기화'),
            toolBax(context, '푸쉬 알림'),
            toolBax(context, '앱버전'),
          ],
        ),
      );
    });
  }
}

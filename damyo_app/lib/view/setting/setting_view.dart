import 'package:damyo_app/style.dart';
import 'package:damyo_app/view_models/login_models/is_login_view_model.dart';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';
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
    return Consumer3<IsloginViewModel, UserInfoViewModel, TokenViewModel>(
        builder: (context, isloginViewModel, userInfoViewModel, tokenViewModel,
            child) {
      return Scaffold(
        appBar: AppBar(
          title: appbarTitleFormat(text: "설정"),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isloginViewModel.isLogin)
              userProfile(
                  context, isloginViewModel, tokenViewModel, userInfoViewModel)
            else
              loginBtn(context),
            toolBax(context, '기여도'),
            toolBax(context, '흡연데이터 초기화'),
            toolBax(context, '앱버전'),
          ],
        ),
      );
    });
  }
}

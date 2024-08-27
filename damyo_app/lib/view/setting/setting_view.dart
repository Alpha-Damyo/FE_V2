import 'package:damyo_app/services/user_service.dart';
import 'package:damyo_app/style.dart';
import 'package:damyo_app/view_models/login_models/is_login_view_model.dart';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';
import 'package:damyo_app/view_models/login_models/user_info_view_model.dart';
import 'package:damyo_app/view_models/statistics_models/period_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:damyo_app/widgets/setting/setting_widgets.dart';
import 'package:provider/provider.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer4<IsloginViewModel, UserInfoViewModel, TokenViewModel,
            PeriodInfoViewModel>(
        builder: (context, isloginViewModel, userInfoViewModel, tokenViewModel,
            periodInfoViewModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: appbarTitleFormat(text: "설정"),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isloginViewModel.isLogin)
              userProfile(context, isloginViewModel, tokenViewModel,
                  userInfoViewModel, updateProfile)
            else
              loginBtn(context),
            contributionBtn(
              context,
              isloginViewModel.isLogin,
              '기여도',
            ),
            resetStatisticsBtn(context, isloginViewModel),
            toolBax(context, '앱버전'),
          ],
        ),
      );
    });
  }

  void updateProfile() async {
    List<dynamic> userInfo = await UserService.getUserInfo(
        Provider.of<TokenViewModel>(context, listen: false));
    Provider.of<UserInfoViewModel>(context, listen: false)
        .updateUserInfoModel(userInfo[1]);
  }
}

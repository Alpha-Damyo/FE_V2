import 'package:damyo_app/style.dart';
import 'package:damyo_app/view_models/login_models/user_info_view_model.dart';
import 'package:damyo_app/widgets/setting/contribution_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContributionView extends StatefulWidget {
  const ContributionView({super.key});

  @override
  State<ContributionView> createState() => _ContributionViewState();
}

class _ContributionViewState extends State<ContributionView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoViewModel>(
      builder: (context, userInfoViewModel, child) {
        return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colors.white,
            title: textFormat(
                text: '나의 기여도', fontSize: 20, fontWeight: FontWeight.w700),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      UserInfo(
                          userInfoViewModel.userInfoModel.name,
                          userInfoViewModel.userInfoModel.contribution,
                          userInfoViewModel.userInfoModel.percentage,
                          userInfoViewModel.userInfoModel.gap,
                          userInfoViewModel.userInfoModel.profileUrl),
                      badgeList(userInfoViewModel.userInfoModel.contribution),
                      explane(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

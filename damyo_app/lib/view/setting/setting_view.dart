import 'package:flutter/material.dart';
import 'package:damyo_app/widgets/setting_widgets.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
  }
}

import 'package:damyo_app/icon/damyo_icon_icons.dart';
import 'package:damyo_app/services/user_service.dart';
import 'package:damyo_app/utils/initialized_db.dart';
import 'package:damyo_app/view_models/bottom_navigation_model.dart';
import 'package:damyo_app/view_models/login_models/is_login_view_model.dart';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';
import 'package:damyo_app/view_models/login_models/user_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:provider/provider.dart";
import 'package:damyo_app/view/favorites/favorites_view.dart';
import 'package:damyo_app/view/map/map_view.dart';
import 'package:damyo_app/view/setting/setting_view.dart';
import 'package:damyo_app/view/statistics/statistics_view.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late BottomNavigationModel _bottomNavigationModel;

  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    _bottomNavigationModel = Provider.of<BottomNavigationModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: _bottomNavigationModel.curPage,
        children: const [
          MapView(),
          FavoritesView(),
          StatisticsView(),
          SettingView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: _bottomNavigationModel.curPage == 0
                ? const Icon(
                    DamyoIcon.map_fill_2,
                    size: 18,
                  )
                : const Icon(
                    DamyoIcon.map_empty_2,
                    size: 18,
                  ),
            label: "지도",
          ),
          BottomNavigationBarItem(
            icon: _bottomNavigationModel.curPage == 1
                ? const Icon(
                    DamyoIcon.favorites_fill_3,
                    size: 18,
                  )
                : const Icon(
                    DamyoIcon.favorites_empty_3,
                    size: 18,
                  ),
            label: "즐겨찾기",
          ),
          BottomNavigationBarItem(
            icon: _bottomNavigationModel.curPage == 2
                ? const Icon(
                    DamyoIcon.statistics_fill,
                    size: 18,
                  )
                : const Icon(
                    DamyoIcon.statistics_empty,
                    size: 18,
                  ),
            label: "통계",
          ),
          BottomNavigationBarItem(
            icon: _bottomNavigationModel.curPage == 3
                ? const Icon(
                    DamyoIcon.setting_fill,
                    size: 18,
                  )
                : const Icon(
                    DamyoIcon.setting_empty,
                    size: 18,
                  ),
            label: "설정",
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _bottomNavigationModel.curPage,
        onTap: (index) {
          _bottomNavigationModel.setCurPage(index);
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  void autoLogin() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? isLogin = await storage.read(key: "loginState");

    // 로그인이 되어있다면
    if (isLogin == "true") {
      // 토큰 불러오기
      await Provider.of<TokenViewModel>(context, listen: false).loadToken();
      // 토큰 만료 여부 확인 및 유저의 현재 정보 불러오기
      List<dynamic> userInfo = await UserService.getUserInfo(
          Provider.of<TokenViewModel>(context, listen: false));
      if (userInfo[0]) {
        // 로그인 상태 true
        await initializedDB(context);
        Provider.of<IsloginViewModel>(context, listen: false).login();
        Provider.of<UserInfoViewModel>(context, listen: false)
            .updateUserInfoModel(userInfo[1]);
      } else {
        // 로그인 상태 false
        Provider.of<IsloginViewModel>(context, listen: false).logout();
      }
    }
    FlutterNativeSplash.remove();
  }
}

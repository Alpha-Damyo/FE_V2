import 'package:damyo_app/database/smoke_data.dart';
import 'package:damyo_app/services/smoke_complete.dart';
import 'package:damyo_app/style.dart';
import 'package:damyo_app/utils/initialized_db.dart';
import 'package:damyo_app/utils/re_login_dialog.dart';
import 'package:damyo_app/utils/smoke_check_dialog.dart';
import 'package:damyo_app/view/map/smoking_area/favorites_bottomsheet.dart';
import 'package:damyo_app/view_models/login_models/is_login_view_model.dart';
import 'package:damyo_app/view_models/map_models/search/sa_search_view_model.dart';
import 'package:damyo_app/widgets/map/search/sa_search_map_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:provider/provider.dart';

class SaSearchMapView extends StatefulWidget {
  const SaSearchMapView({
    super.key,
  });

  @override
  State<SaSearchMapView> createState() => _SaSearchMapViewState();
}

class _SaSearchMapViewState extends State<SaSearchMapView> {
  late NaverMapController mapController;
  late SaSearchViewModel _saSearchViewModel;
  DateTime now = DateTime.now();
  SmokeDatabase userDB = SmokeDatabase();

  @override
  Widget build(BuildContext context) {
    _saSearchViewModel = Provider.of<SaSearchViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: appbarTitleFormat(
            text: _saSearchViewModel.searchWordController.text),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 지도
          NaverMap(
            options: const NaverMapViewOptions(),
            onMapReady: (controller) {
              mapController = controller;
              _saSearchViewModel.updateNaverMapController(controller);
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 15,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: searchedSmokingAreaCard(
                context,
                _saSearchViewModel.searchSelectedSa,
                () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return FavoritesBottomsheet(
                          areaId: _saSearchViewModel.searchSelectedSa.areaId,
                          areaName: _saSearchViewModel.searchSelectedSa.name,
                        );
                      });
                },
                () async {
                  // 흡연 완료
                  if (Provider.of<IsloginViewModel>(context, listen: false)
                      .isLogin) {
                    // 로그인을 한 경우
                    if (await smokingCheckBox(context) == true) {
                      // 흡연을 완료한 경우
                      String response = await smokeComplete(
                          context,_saSearchViewModel.searchSelectedSa.areaId);
                      if (response == "success") {
                        await userDB.insertSmokeInfo(
                            _saSearchViewModel.searchSelectedSa.areaId,
                            _saSearchViewModel.searchSelectedSa.name,
                            now);
                        initializedUserDB(context);
                      } else if (response == "re_login") {
                        reLogin(context);
                      }
                    } else {
                      // 흡연을 취소한 경우
                    }
                  } else {
                    // 로그인을 안 한 경우
                    reLogin(context);
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

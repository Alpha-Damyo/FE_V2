import 'package:damyo_app/view/map/smoking_area/favorites_bottomsheet.dart';
import 'package:damyo_app/view_models/map_models/map_view_model.dart';
import 'package:damyo_app/view_models/map_models/search/sa_search_view_model.dart';
import 'package:damyo_app/widgets/map/map_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late MapViewModel _mapViewModel;
  late SaSearchViewModel _saSearchViewModel;
  bool isMapControllerLoaded = false;
  List<String> tags = ['개방', '폐쇄', '실외', '실내'];

  @override
  Widget build(BuildContext context) {
    _mapViewModel = Provider.of<MapViewModel>(context);
    _saSearchViewModel = Provider.of<SaSearchViewModel>(context);
    _mapViewModel.loadFavorites();
    _saSearchViewModel.readRecentSearchWords();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 지도
          NaverMap(
            options: const NaverMapViewOptions(
              // initialCameraPosition: NCameraPosition(
              //   target: NLatLng(userLatitude, userLongitude),
              //   zoom: 14.0,
              // ),
              locationButtonEnable: true,
            ),
            onMapReady: (controller) {
              _mapViewModel.mapController = controller;
              isMapControllerLoaded = true;
              updateSmokingAreas();
            },
            onCameraIdle: () {
              _mapViewModel.trueResearchBtnVisible();
            },
            onMapTapped: (point, latLng) {
              _mapViewModel.closeSmokingAreaCard();
            },
          ),

          // 검색
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Row(
                  children: [
                    mapSearchBar(context),
                    const SizedBox(width: 10),
                    informBtn(
                      context,
                      () {
                        _mapViewModel.changeInformBtnVisible();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                tagListView(context, tags, _mapViewModel.tagIndex, (index) {
                  _mapViewModel.updateTagIndex(index);
                  updateSmokingAreas();
                }),
                const SizedBox(height: 10),
                reSearchBtn(
                  context,
                  _mapViewModel.researchBtnVisible,
                  () {
                    updateSmokingAreas();
                  },
                )
              ],
            ),
          ),
          // 제보 버튼을 누르면 활성화되는 제보하기 버튼
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: centerInformBtn(
                context, _mapViewModel.informBtnVisible, getNowCamerPosition()),
          ),
          // 마커를 누르면 나오는 정보 카드
          Positioned(
            left: 0,
            right: 0,
            bottom: 15,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: smokingAreaCard(
                context,
                _mapViewModel,
                // 즐겨찾기 추가
                () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const FavoritesBottomsheet();
                      });
                },
                // Todo: 흡연 완료
                () {},
              ),
            ),
          )
        ],
      ),
    );
  }

  Map<String, double> getNowCamerPosition() {
    if (isMapControllerLoaded) {
      return {
        "lat": double.parse(_mapViewModel
            .mapController.nowCameraPosition.target.latitude
            .toStringAsFixed(6)),
        "lng": double.parse(_mapViewModel
            .mapController.nowCameraPosition.target.longitude
            .toStringAsFixed(6)),
      };
    } else {
      return {
        "lat": 0.0,
        "lng": 0.0,
      };
    }
  }

  void updateSmokingAreas() {
    _mapViewModel.updateSaSearchModel(
      _mapViewModel.mapController.nowCameraPosition.target.latitude,
      _mapViewModel.mapController.nowCameraPosition.target.longitude,
    );
    _mapViewModel.updateSmokingAreas();
    _mapViewModel.falseResearchBtnVisible();
  }
}

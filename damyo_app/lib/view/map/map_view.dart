import 'package:damyo_app/view_models/map_models/map_view_model.dart';
import 'package:damyo_app/widgets/map/map_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> with AutomaticKeepAliveClientMixin {
  // 페이지를 이동하더라도 dispose하지 않고 re-rendering을 막음
  @override
  bool get wantKeepAlive => true;

  late MapViewModel _mapViewModel;
  late NaverMapController mapController;
  List<String> tags = ['개방', '폐쇄', '실외', '실내'];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    _mapViewModel = Provider.of<MapViewModel>(context);

    return Scaffold(
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
              mapController = controller;
              updateSmokingAreas(mapController);
            },
            onCameraIdle: () {
              _mapViewModel.trueResearchBtnVisible();
            },
            onMapTapped: (point, latLng) {
              _mapViewModel.closeSmokingAreaCard();
            },
          ),

          // 이외 버튼
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
                  updateSmokingAreas(mapController);
                }),
                const SizedBox(height: 10),
                reSearchBtn(
                  context,
                  _mapViewModel.researchBtnVisible,
                  () {
                    updateSmokingAreas(mapController);
                  },
                )
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: centerInformBtn(context, _mapViewModel.informBtnVisible),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 15,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: smokingAreaCard(
                context,
                _mapViewModel,
                () {},
                () {},
              ),
            ),
          )
        ],
      ),
    );
  }

  void updateSmokingAreas(NaverMapController mapController) {
    _mapViewModel.updateSaSearchModel(
      mapController.nowCameraPosition.target.latitude,
      mapController.nowCameraPosition.target.longitude,
    );
    _mapViewModel.updateSmokingAreas(mapController);
    _mapViewModel.falseResearchBtnVisible();
  }
}

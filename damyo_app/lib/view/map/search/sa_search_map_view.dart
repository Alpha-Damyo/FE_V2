import 'package:damyo_app/models/smoking_area/sa_basic_model.dart';
import 'package:damyo_app/style.dart';
import 'package:damyo_app/widgets/map/search/sa_search_map_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class SaSearchMapView extends StatefulWidget {
  final SaBasicModel searchedSa;
  const SaSearchMapView({
    super.key,
    required this.searchedSa,
  });

  @override
  State<SaSearchMapView> createState() => _SaSearchMapViewState();
}

class _SaSearchMapViewState extends State<SaSearchMapView> {
  SaBasicModel get _searchedSa => widget.searchedSa;
  late NaverMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appbarTitleFormat(text: _searchedSa.name),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // 지도
          NaverMap(
            options: NaverMapViewOptions(
              initialCameraPosition: NCameraPosition(
                target: NLatLng(_searchedSa.latitude, _searchedSa.longitude),
                zoom: 15.0,
              ),
              locationButtonEnable: true,
            ),
            onMapReady: (controller) {
              mapController = controller;

              final NMarker marker = NMarker(
                id: _searchedSa.areaId,
                position: NLatLng(
                  _searchedSa.latitude,
                  _searchedSa.longitude,
                ),
              );
              mapController.addOverlay(marker);

              // final onMarkerInfoWindow = NInfoWindow.onMarker(
              //   id: marker.info.id,
              //   text: "테스트 정보창",
              // );
              // marker.openInfoWindow(onMarkerInfoWindow);
            },
          ),
          // 마커를 누르면 나오는 정보 카드
          Positioned(
            left: 0,
            right: 0,
            bottom: 15,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: searchedSmokingAreaCard(
                context,
                _searchedSa,
                // Todo: ////
                () {},
                () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}

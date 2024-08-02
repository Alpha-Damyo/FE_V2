import 'package:damyo_app/widgets/map_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> with AutomaticKeepAliveClientMixin {
  // 페이지를 이동하더라도 dispose하지 않고 re-rendering을 막음
  @override
  bool get wantKeepAlive => true;

  late NaverMapController mapController;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          // 지도
          NaverMap(
            options: const NaverMapViewOptions(),
            onMapReady: (controller) {
              mapController = controller;
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
                    informBtn(context),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    tagListView(context, ['개방', '폐쇄', '실외', '실내']),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    reSearchBtn(context),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

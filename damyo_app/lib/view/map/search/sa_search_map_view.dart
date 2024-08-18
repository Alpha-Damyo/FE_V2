import 'package:damyo_app/style.dart';
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

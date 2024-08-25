import 'package:damyo_app/view/map/search/sa_search_complete_view.dart';
import 'package:damyo_app/view/map/search/sa_search_map_view.dart';
import 'package:damyo_app/view/map/search/sa_search_view.dart';
import 'package:damyo_app/view_models/bottom_navigation_model.dart';
import 'package:damyo_app/view_models/map_models/search/sa_search_view_model.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";

// ignore: must_be_immutable
class SaSearchHomeView extends StatelessWidget {
  SaSearchHomeView({super.key});
  late BottomNavigationModel _bottomNavigationModel;
  late SaSearchViewModel _saSearchViewModel;

  @override
  Widget build(BuildContext context) {
    _bottomNavigationModel = Provider.of<BottomNavigationModel>(context);
    _saSearchViewModel = Provider.of<SaSearchViewModel>(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (_bottomNavigationModel.searchPage == 0) {
          if (MediaQuery.of(context).viewInsets.bottom > 0) {
            FocusManager.instance.primaryFocus?.unfocus();
          } else {
            _saSearchViewModel.searchWordController.clear();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            });
          }
        } else if (_bottomNavigationModel.searchPage == 1) {
          _saSearchViewModel.searchWordController.clear();
          _bottomNavigationModel.setSearchPage(0);
        } else {
          _bottomNavigationModel.setSearchPage(1);
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _bottomNavigationModel.searchPage,
          children: const [
            SaSearchView(),
            SaSearchCompleteView(),
            SaSearchMapView(),
          ],
        ),
      ),
    );
  }
}

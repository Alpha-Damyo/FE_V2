import 'package:damyo_app/view_models/bottom_navigation_model.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:damyo_app/view/favorites/favorites_view.dart';
import 'package:damyo_app/view/map/map_view.dart';
import 'package:damyo_app/view/setting/setting_view.dart';
import 'package:damyo_app/view/statistics/statistics_view.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({super.key});
  late BottomNavigationModel _bottomNavigationModel;

  @override
  Widget build(BuildContext context) {
    _bottomNavigationModel = Provider.of<BottomNavigationModel>(context);
    return Scaffold(
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: "지도",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "즐겨찾기",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph),
            label: "통계",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
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
}

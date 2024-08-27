import 'package:damyo_app/style.dart';
import 'package:damyo_app/view_models/bottom_navigation_model.dart';
import 'package:damyo_app/view_models/map_models/map_view_model.dart';
import 'package:damyo_app/view_models/map_models/search/sa_search_view_model.dart';
import 'package:damyo_app/widgets/map/search/sa_seach_complete_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaSearchCompleteView extends StatefulWidget {
  const SaSearchCompleteView({super.key});

  @override
  State<SaSearchCompleteView> createState() => _SaSearchCompleteViewState();
}

class _SaSearchCompleteViewState extends State<SaSearchCompleteView> {
  late MapViewModel _mapViewModel;
  late SaSearchViewModel _saSearchViewModel;
  late BottomNavigationModel _bottomNavigationModel;

  @override
  Widget build(BuildContext context) {
    _mapViewModel = Provider.of<MapViewModel>(context);
    _saSearchViewModel = Provider.of<SaSearchViewModel>(context);
    _bottomNavigationModel = Provider.of<BottomNavigationModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: textFormat(
            text: _saSearchViewModel.searchWordController.text, fontSize: 18),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
              width: double.infinity,
            ),
            searchedSaListView(
              context,
              _mapViewModel,
              _saSearchViewModel,
              _saSearchViewModel.searchWordController.text,
              _bottomNavigationModel,
            )
          ],
        ),
      ),
    );
  }
}

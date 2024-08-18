import 'package:damyo_app/view_models/bottom_navigation_model.dart';
import 'package:damyo_app/view_models/map_models/search/sa_search_view_model.dart';
import 'package:damyo_app/widgets/map/search/sa_search_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaSearchView extends StatefulWidget {
  const SaSearchView({super.key});

  @override
  State<SaSearchView> createState() => _SaSearchViewState();
}

class _SaSearchViewState extends State<SaSearchView> {
  late SaSearchViewModel _saSearchViewModel;
  late BottomNavigationModel _bottomNavigationModel;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    _saSearchViewModel = Provider.of<SaSearchViewModel>(context);
    _bottomNavigationModel = Provider.of<BottomNavigationModel>(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: saSearchBar(
              context, _saSearchViewModel, _focusNode, _bottomNavigationModel),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              recentSearchWordsList(
                  context, _saSearchViewModel, _bottomNavigationModel),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }
}

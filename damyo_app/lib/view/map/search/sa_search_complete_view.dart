import 'package:damyo_app/view_models/map_models/search/sa_search_view_model.dart';
import 'package:damyo_app/widgets/map/search/sa_seach_complete_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaSearchCompleteView extends StatefulWidget {
  final String searchWord;
  const SaSearchCompleteView({super.key, required this.searchWord});

  @override
  State<SaSearchCompleteView> createState() => _SaSearchCompleteViewState();
}

class _SaSearchCompleteViewState extends State<SaSearchCompleteView> {
  late SaSearchViewModel _saSearchViewModel;

  @override
  Widget build(BuildContext context) {
    _saSearchViewModel = Provider.of<SaSearchViewModel>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(height: 35),
            saSearchCompleteBar(context, widget.searchWord),
            searchedSaListView(context, _saSearchViewModel, widget.searchWord)
          ],
        ),
      ),
    );
  }
}

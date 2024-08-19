import 'package:damyo_app/services/favorites_service.dart';
import 'package:damyo_app/style.dart';
import 'package:damyo_app/view_models/map_models/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class FavoritesBottomsheet extends StatefulWidget {
  const FavoritesBottomsheet({super.key});

  @override
  State<FavoritesBottomsheet> createState() => _FavoritesBottomSheetState();
}

class _FavoritesBottomSheetState extends State<FavoritesBottomsheet> {
  late MapViewModel _mapViewModel;
  int selectedFavorite = 0;

  @override
  Widget build(BuildContext context) {
    _mapViewModel = Provider.of<MapViewModel>(context);

    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          textFormat(
            text: _mapViewModel.smokingAreaCardInfo.name,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 30),
          InkWell(
            onTap: () {
              _showInputDialog();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Color(0xffe4e7eB),
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textFormat(text: "새 리스트 만들기", fontSize: 16),
                  Icon(
                    Icons.add_circle_outline,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    size: 25,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _mapViewModel.favoritesList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedFavorite = index;
                    });
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Color(0xffe4e7eB),
                      ))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              textFormat(
                                  text:
                                      '${_mapViewModel.favoritesList[index][0]} '),
                              textFormat(
                                  text: _mapViewModel
                                      .favoritesList[index][1].length
                                      .toString(),
                                  color: const Color(0xFF6F767F),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)
                            ],
                          ),
                          Icon(
                            Icons.check_circle_outline,
                            color: selectedFavorite == index
                                ? Theme.of(context).colorScheme.primary
                                : const Color(0xffe4e7eB),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(16.0),
              ),
              onTap: () async {
                // 이미 추가되어 있는 경우
                if (_mapViewModel.favoritesList[selectedFavorite][1]
                    .contains(_mapViewModel.smokingAreaCardInfo.areaId)) {
                  Fluttertoast.showToast(msg: "리스트에 이미 추가되어있습니다");
                } else {
                  _mapViewModel.addFavoritesElement(selectedFavorite);
                  FavoritesService.updateFavorites(_mapViewModel.favoritesList);
                  Fluttertoast.showToast(msg: "즐겨찾기 추가가 완료되었습니다");

                  setState(() {
                    Navigator.of(context).pop();
                  });
                }
              },
              child: Ink(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: textFormat(
                    text: '즐겨찾기 추가',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _enteredText = '';

  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: textFormat(text: '리스트 이름을 입력하세요', fontSize: 20),
          content: TextField(
            onChanged: (value) {
              setState(() {
                _enteredText = value;
              });
            },
            decoration: const InputDecoration(hintText: '이름'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: textFormat(
                text: '취소',
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextButton(
              onPressed: () async {
                if (_mapViewModel.favoritesList
                    .map((sublist) => sublist[0])
                    .toList()
                    .contains(_enteredText)) {
                  Fluttertoast.showToast(msg: "이미 존재하는 리스트입니다");
                } else {
                  _mapViewModel.addFavoritesList(_enteredText);
                  FavoritesService.updateFavorites(_mapViewModel.favoritesList);
                  Navigator.of(context).pop();
                }
              },
              child: textFormat(
                text: '확인',
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }
}

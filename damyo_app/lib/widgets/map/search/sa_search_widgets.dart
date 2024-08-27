import 'package:damyo_app/models/smoking_area/sa_basic_model.dart';
import 'package:damyo_app/services/smoking_area_service.dart';
import 'package:damyo_app/style.dart';
import 'package:damyo_app/view_models/bottom_navigation_model.dart';
import 'package:damyo_app/view_models/map_models/map_view_model.dart';
import 'package:damyo_app/view_models/map_models/search/sa_search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// 검색 창
Widget saSearchBar(BuildContext context, SaSearchViewModel saSearchViewModel,
    FocusNode focusNode, BottomNavigationModel bottomNavigationModel) {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: saSearchViewModel.searchWordController,
            focusNode: focusNode,
            decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                border: InputBorder.none,
                hintText: "흡연구역 검색",
                hintStyle: TextStyle(fontSize: 18)),
            style: const TextStyle(fontSize: 18),
            // 입력 완료 되었을 때 처리
            onSubmitted: (value) {
              searchByWord(
                  context,
                  saSearchViewModel,
                  saSearchViewModel.searchWordController.text,
                  bottomNavigationModel);
            },
          ),
        ),
        InkWell(
          onTap: () {
            saSearchViewModel.searchWordController.clear();
          },
          child: Icon(
            Icons.cancel,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            size: 25,
          ),
        ),
      ],
    ),
  );
}

Widget recentSearchWordsList(
    BuildContext context,
    SaSearchViewModel saSearchViewModel,
    BottomNavigationModel bottomNavigationModel) {
  return Expanded(
    child: ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: saSearchViewModel.recentSearchWords.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            // 키보드 내리기
            FocusManager.instance.primaryFocus?.unfocus();
            saSearchViewModel.searchWordController.text =
                saSearchViewModel.recentSearchWords[index];
            searchByWord(
                context,
                saSearchViewModel,
                saSearchViewModel.recentSearchWords[index],
                bottomNavigationModel);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFEEF1F5), width: 1.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFormat(
                  text: saSearchViewModel.recentSearchWords[index],
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                Row(
                  children: [
                    textFormat(
                      text: saSearchViewModel.recentSearchDates[index],
                      color: const Color(0xFF6F767F),
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        saSearchViewModel.deleteRecentSearchWord(index);
                      },
                      child: const Icon(
                        Icons.close,
                        color: Color(0xFF6F767F),
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

void searchByWord(BuildContext context, SaSearchViewModel saSearchViewModel,
    String word, BottomNavigationModel bottomNavigationModel) async {
  String searchWord = word;
  if (searchWord.isEmpty) {
    Fluttertoast.showToast(msg: "1글자 이상의 검색어를 입력해주세요");
    return;
  }

  // 검색 결과 화면으로 이동
  bottomNavigationModel.setSearchPage(1);
  saSearchViewModel.setSearchState(1);
  List<SaBasicModel> newList =
      await SmokingAreaService.searchSmokingAreaByName(searchWord);
  saSearchViewModel.setSearchedSaList(context, newList);
  saSearchViewModel.setSearchState(2);
  saSearchViewModel.updateRecentSearchWord(searchWord);
}

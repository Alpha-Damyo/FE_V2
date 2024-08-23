// 검색 창
import 'package:damyo_app/style.dart';
import 'package:damyo_app/utils/cal_distance.dart';
import 'package:damyo_app/view_models/bottom_navigation_model.dart';
import 'package:damyo_app/view_models/map_models/map_view_model.dart';
import 'package:damyo_app/view_models/map_models/search/sa_search_view_model.dart';
import 'package:flutter/material.dart';

Widget saSearchCompleteBar(BuildContext context, String searchWord) {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    child: Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 25,
          ),
        ),
        const SizedBox(width: 20),
        textFormat(text: searchWord, fontSize: 16),
      ],
    ),
  );
}

Widget searchedSaListView(
    BuildContext context,
    SaSearchViewModel saSearchViewModel,
    String searchWord,
    BottomNavigationModel bottomNavigationModel) {
  if (saSearchViewModel.searchState == 1) {
    return const CircularProgressIndicator();
  } else {
    if (saSearchViewModel.searchedSaList.isEmpty) {
      return textFormat(
        text: "\"$searchWord\" 에 대한 검색 결과가 없습니다",
        fontSize: 18,
      );
    } else {
      return Expanded(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: saSearchViewModel.searchedSaList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                saSearchViewModel.updateSearchSelectedSa(
                    saSearchViewModel.searchedSaList[index]);
                saSearchViewModel.moveMapCamera();
                bottomNavigationModel.setSearchPage(2);
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: textFormat(
                            text: saSearchViewModel.searchedSaList[index].name,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          child: textFormat(
                            text:
                                saSearchViewModel.searchedSaList[index].address,
                            color: const Color(0xFF6F767F),
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 20,
                              color: Colors.red,
                            ),
                            textFormat(
                              text: saSearchViewModel
                                  .searchedSaList[index].score
                                  .toString(),
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        textFormat(
                          text: mKm(
                            calculateDistance(
                              curLat,
                              curLng,
                              saSearchViewModel.searchedSaList[index].latitude,
                              saSearchViewModel.searchedSaList[index].longitude,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}

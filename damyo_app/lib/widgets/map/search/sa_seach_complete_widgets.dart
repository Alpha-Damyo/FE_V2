// 검색 창
import 'package:damyo_app/style.dart';
import 'package:damyo_app/utils/cal_distance.dart';
import 'package:damyo_app/view/map/search/sa_search_map_view.dart';
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

Widget searchedSaListView(BuildContext context,
    SaSearchViewModel saSearchViewModel, String searchWord) {
  if (saSearchViewModel.searchState == 1) {
    return const CircularProgressIndicator();
  } else {
    if (saSearchViewModel.searchedSaList.isEmpty) {
      return textFormat(
        text: "\"$searchWord\" 에 대한 검색 결과가 없습니다",
        fontSize: 16,
      );
    } else {
      return Expanded(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: saSearchViewModel.searchedSaList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                // Todo: 터치 시 흡연구역이 위치한 지도 화면 보여주기
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SaSearchMapView(
                            searchedSa:
                                saSearchViewModel.searchedSaList[index])));
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
                              // Todo: 유저 위치로 설정
                              37.5666,
                              126.979,
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

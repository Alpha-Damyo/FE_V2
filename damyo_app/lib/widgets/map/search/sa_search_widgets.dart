import 'package:damyo_app/models/smoking_area/sa_basic_model.dart';
import 'package:damyo_app/services/smoking_area_service.dart';
import 'package:damyo_app/view_models/map_models/search/sa_search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 검색 창
Widget saSearchBar(BuildContext context, SaSearchViewModel saSearchViewModel) {
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
            if (MediaQuery.of(context).viewInsets.bottom > 0) {
              FocusManager.instance.primaryFocus?.unfocus();
            } else {
              Navigator.pop(context);
            }
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 25,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: saSearchViewModel.saNameController,
            decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                border: InputBorder.none,
                hintText: "흡연구역 검색",
                hintStyle: TextStyle(fontSize: 16)),
            style: const TextStyle(fontSize: 16),
            // 입력 완료 되었을 때 처리
            onSubmitted: (value) async {
              String searchWord = saSearchViewModel.saNameController.text;
              context.push('/search/$searchWord');
              saSearchViewModel.setSearchState(1);
              List<SaBasicModel> newList =
                  await SmokingAreaService.searchSmokingAreaByName(
                      saSearchViewModel.saNameController.text);
              saSearchViewModel.setSearchedSaList(newList);
              saSearchViewModel.setSearchState(2);
              saSearchViewModel.saNameController.clear();
            },
          ),
        ),
        Icon(
          Icons.cancel,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          size: 25,
        ),
      ],
    ),
  );
}

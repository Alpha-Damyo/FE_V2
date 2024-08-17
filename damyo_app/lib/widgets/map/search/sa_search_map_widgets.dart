// 흡연구역 정보 카드
import 'package:damyo_app/models/smoking_area/sa_basic_model.dart';
import 'package:damyo_app/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget searchedSmokingAreaCard(
  BuildContext context,
  SaBasicModel saBasicModel,
  Function onTapAddFavorites,
  Function onTapCompleteSmoking,
) {
  return GestureDetector(
    onTap: () {
      context.push('/smokingarea/${saBasicModel.areaId}');
    },
    child: Container(
      height: 150,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFD2D7DD)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on_sharp,
                    size: 24,
                  ),
                  textFormat(
                    text: " ${saBasicModel.name}",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              textFormat(
                text: "상세주소: ${saBasicModel.address}",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: Colors.red,
                    size: 24,
                  ),
                  textFormat(
                    text: saBasicModel.score.toString(),
                    fontSize: 16,
                  )
                ],
              ),
              Row(
                children: [
                  simpleBtn(context, "즐겨찾기 추가", onTapAddFavorites),
                  const SizedBox(width: 10),
                  simpleBtn(context, "흡연 완료", onTapCompleteSmoking),
                ],
              )
            ],
          )
        ],
      ),
    ),
  );
}

Widget simpleBtn(BuildContext context, String text, Function onTap) {
  return normalMaterial(
    context,
    36,
    InkWell(
      onTap: () {
        onTap();
      },
      borderRadius: BorderRadius.circular(36),
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(36),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 6,
        ),
        child: textFormat(
          text: text,
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

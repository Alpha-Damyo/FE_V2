import 'package:damyo_app/models/smoking_area/sa_detail_model.dart';
import 'package:damyo_app/style.dart';
import 'package:flutter/material.dart';

Widget saDetailNameAndScore(SaDetailModel saDetailModel) {
  return Column(children: [
    textFormat(
      text: saDetailModel.name,
    ),
    const SizedBox(height: 5),
    const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // SAInfoScreenStar(starValue: snapshot.data.score),
      ],
    ),
  ]);
}

// Widget saDetailBtns(SaDetailModel saDetailModel) {}

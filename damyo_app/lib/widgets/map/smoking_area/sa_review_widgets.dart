import 'package:damyo_app/style.dart';
import 'package:damyo_app/widgets/common/ratingstar_widget.dart';
import 'package:flutter/material.dart';

Widget reviewSaName(BuildContext context, String name) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: name,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const TextSpan(
          text: "에\n방문했어요!",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget reviewRating(
    BuildContext context, double starValue, Function setStarValue) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        width: 1,
        color: const Color(0xFFE4E7EB),
      ),
    ),
    child: Column(
      children: [
        textFormat(
          text: "만족도를 평가해주세요",
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 10),
        ratingStars(context, starValue, setStarValue),
      ],
    ),
  );
}

Widget reviewWrite(BuildContext context, bool canReview) {
  return InkWell(
    borderRadius: const BorderRadius.all(Radius.circular(16)),
    onTap: () {
      // canReview ?
    },
    child: Ink(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: canReview
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSecondaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Align(
        alignment: Alignment.center,
        child: textFormat(
          text: '리뷰 작성',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    ),
  );
}

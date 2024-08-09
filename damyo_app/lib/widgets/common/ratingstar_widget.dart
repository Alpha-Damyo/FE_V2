import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

Widget ratingStars(
    BuildContext context, double starValue, Function setStarValue) {
  return RatingStars(
    value: starValue,
    starBuilder: (index, color) => Icon(
      Icons.star,
      size: 40,
      color: color,
    ),
    onValueChanged: (v) {
      setStarValue(v);
    },
    starCount: 5,
    starSize: 40,
    starColor: Theme.of(context).colorScheme.primary,
    valueLabelVisibility: false,
  );
}

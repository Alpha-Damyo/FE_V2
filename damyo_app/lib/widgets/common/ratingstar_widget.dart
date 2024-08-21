import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

Widget ratingStars(BuildContext context, double size, double starValue,
    Function setStarValue) {
  return RatingStars(
    value: starValue,
    starBuilder: (index, color) => Icon(
      Icons.star,
      size: size,
      color: color,
    ),
    onValueChanged: (v) {
      setStarValue(v);
    },
    starCount: 5,
    starSize: size,
    starColor: Colors.red,
    valueLabelVisibility: false,
  );
}

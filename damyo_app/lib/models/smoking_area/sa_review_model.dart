class SaReviewModel {
  String smokingAreaId;
  double score;

  SaReviewModel.fromJson(Map<String, dynamic> json)
      : smokingAreaId = json['smokingAreaId'],
        score = json['score'];

  Map<String, dynamic> toJson() {
    return {
      "smokingAreaId": smokingAreaId,
      "score": score,
    };
  }
}

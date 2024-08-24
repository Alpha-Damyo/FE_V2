class SaReportModel {
  bool notExist;
  bool incorrectTag;
  bool incorrectLocation;
  bool inappropriateWord;
  bool inappropriatePicture;
  String? otherSuggestions;

  SaReportModel({
    required this.notExist,
    required this.incorrectTag,
    required this.incorrectLocation,
    required this.inappropriateWord,
    required this.inappropriatePicture,
    this.otherSuggestions,
  });

  Map<String, dynamic> toJson() {
    if (otherSuggestions == null || otherSuggestions == "") {
      return {
        "notExist": notExist,
        "incorrectTag": incorrectTag,
        "incorrectLocation": incorrectLocation,
        "inappropriateWord": inappropriateWord,
        "inappropriatePicture": inappropriatePicture,
      };
    } else {
      return {
        "notExist": notExist,
        "incorrectTag": incorrectTag,
        "incorrectLocation": incorrectLocation,
        "inappropriateWord": inappropriateWord,
        "inappropriatePicture": inappropriatePicture,
        "otherSuggestions": otherSuggestions,
      };
    }
  }
}

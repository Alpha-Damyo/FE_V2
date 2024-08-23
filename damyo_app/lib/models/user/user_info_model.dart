class UserInfoModel {
  final String name;
  final String profileUrl;
  final int contribution;
  final double percentage;
  final int gap;

  UserInfoModel(
    this.name,
    this.profileUrl,
    this.contribution,
    this.percentage,
    this.gap,
  );

  UserInfoModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        profileUrl = json['profileUrl'],
        contribution = json['contribution'],
        percentage = json['percentage'],
        gap = json['gap'];
}

class UserInfoModel{
  String? name;
  String? nickname;
  int? age;
  int? contribution;
  //성별은 true면 남자, false면 여자
  bool? gender;
  
  UserInfoModel({
    this.name,
    this.nickname,
    this.age,
    this.contribution,
    this.gender}
  );
  
}
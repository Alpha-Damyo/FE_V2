class SaDetailModel {
  String areaId;
  String name;
  double latitude;
  double longitude;
  String address;
  String createdAt;
  String? description;
  double score;
  int reviewCount;
  bool? status;
  bool? opened;
  bool? closed;
  bool? indoor;
  bool? outdoor;
  List<dynamic> pictureList;

  SaDetailModel.fromJson(Map<String, dynamic> json)
      : areaId = json['areaId'],
        name = json['name'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        address = json['address'],
        createdAt = json['createdAt'],
        status = json['status'],
        description = json['description'],
        score = json['score'],
        reviewCount = json['reviewCount'],
        opened = json['opened'],
        closed = json['closed'],
        indoor = json['indoor'],
        outdoor = json['outdoor'],
        pictureList = json['pictureList'];
}

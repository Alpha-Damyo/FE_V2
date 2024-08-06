class SaDetailModel {
  String areaId;
  String name;
  double latitude;
  double longitude;
  String address;
  String creadtedAt;
  String description;
  double score;
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
        creadtedAt = json['createdAt'],
        status = json['status'],
        description = json['description'],
        score = json['score'],
        opened = json['opened'],
        closed = json['closed'],
        indoor = json['indoor'],
        outdoor = json['outdoor'],
        pictureList = json['pictureList'];
}

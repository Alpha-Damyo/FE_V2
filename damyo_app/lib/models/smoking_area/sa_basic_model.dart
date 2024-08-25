class SaBasicModel {
  final String areaId;
  final String name;
  final double latitude;
  final double longitude;
  final String address;
  final double score;

  SaBasicModel(
    this.areaId,
    this.name,
    this.latitude,
    this.longitude,
    this.address,
    this.score,
  );

  SaBasicModel.fromJson(Map<String, dynamic> json)
      : areaId = json['areaId'],
        name = json['name'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        address = json['address'],
        score = json['score'];
}

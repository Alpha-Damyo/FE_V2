class SaInformModel {
  String name;
  double latitude;
  double longitude;
  String address;
  String? description;
  double score;
  bool indoor;
  bool outdoor;
  bool opened;
  bool closed;

  SaInformModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        address = json['address'],
        description = json['description'],
        score = json['score'],
        indoor = json['indoor'],
        outdoor = json['outdoor'],
        opened = json['opened'],
        closed = json['closed'];

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "latitude": latitude,
      "longitude": longitude,
      "address": address,
      "description": description,
      "score": score,
      "indoor": indoor,
      "outdoor": outdoor,
      "opened": opened,
      "closed": closed,
    };
  }
}

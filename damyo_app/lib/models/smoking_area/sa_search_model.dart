class SaSearchModel {
  double latitude;
  double longitude;
  double range;
  bool? status;
  bool? opened;
  bool? closed;
  bool? hygiene;
  bool? dirty;
  bool? airOut;
  bool? noExist;
  bool? indoor;
  bool? outdoor;
  bool? big;
  bool? small;
  bool? crowded;
  bool? quite;
  bool? chair;

  SaSearchModel({
    required this.latitude,
    required this.longitude,
    required this.range,
    this.status,
    this.opened,
    this.closed,
    this.hygiene,
    this.dirty,
    this.airOut,
    this.noExist,
    this.indoor,
    this.outdoor,
    this.big,
    this.small,
    this.crowded,
    this.quite,
    this.chair,
  });

  Map<String, dynamic> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
      "range": range,
      "status": status,
      "opened": opened,
      "closed": closed,
      "hygiene": hygiene,
      "dirty": dirty,
      "airOut": airOut,
      "noExist": noExist,
      "indoor": indoor,
      "outdoor": outdoor,
      "big": big,
      "small": small,
      "crowded": crowded,
      "quite": quite,
      "chair": chair,
    };
  }
}

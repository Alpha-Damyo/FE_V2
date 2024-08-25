import 'package:damyo_app/view_models/map_models/map_view_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

Future<void> getCurrentLocation() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    curLat = position.latitude;
    curLng = position.longitude;
  } catch (e) {
    Fluttertoast.showToast(msg: "위치 권한을 허용해주세요");
  }
}

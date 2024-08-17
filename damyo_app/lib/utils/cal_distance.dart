import 'dart:math';

// 두 좌표의 위도와 경도를 라디안으로 변환하는 함수
double _degreesToRadians(double degrees) {
  return degrees * pi / 180;
}

// 두 좌표 사이의 거리를 계산하는 함수
double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  // 지구의 반지름 (미터 단위)
  const double R = 6371000;

  // 위도와 경도를 라디안 단위로 변환
  double lat1Rad = _degreesToRadians(lat1);
  double lon1Rad = _degreesToRadians(lon1);
  double lat2Rad = _degreesToRadians(lat2);
  double lon2Rad = _degreesToRadians(lon2);

  // 위도와 경도의 차이 계산
  double deltaLat = lat2Rad - lat1Rad;
  double deltaLon = lon2Rad - lon1Rad;

  // 해버사인 공식 적용
  double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
      cos(lat1Rad) * cos(lat2Rad) * sin(deltaLon / 2) * sin(deltaLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  // 두 좌표 사이의 거리 계산 (미터 단위)
  double distance = R * c;

  return distance;
}

String mKm(double distance) {
  if (distance > 1000) {
    return '${(distance / 1000).toInt().toString()}km';
  } else {
    return '${(distance.toInt().toString())}m';
  }
}

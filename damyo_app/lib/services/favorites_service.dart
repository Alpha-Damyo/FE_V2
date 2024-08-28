import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FavoritesService {
  static Future<void> updateFavorites(List<dynamic> favoritesList) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.write(key: "favorites", value: jsonEncode(favoritesList));
  }

  static Future<List<dynamic>> loadFavorites() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? str = await storage.read(key: "favorites");
    if (str == null) {
      return [];
    } else {
      return jsonDecode(str);
    }
  }
}

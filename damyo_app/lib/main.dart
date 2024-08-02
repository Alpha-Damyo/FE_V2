import 'dart:developer';

import 'package:damyo_app/view/home/home_view.dart';
import 'package:damyo_app/view_models/bottom_navigation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadDotEnv();
  await initializeMap();
  runApp(const Damyo());
}

class Damyo extends StatelessWidget {
  const Damyo({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: const Color(0xFF0099FC),
          secondary: const Color(0xFF6F767F),
        ),
        useMaterial3: true,
      ),
      // Todo: Provider 적용
      home: ChangeNotifierProvider<BottomNavigationModel>(
        create: (context) => BottomNavigationModel(),
        child: HomeView(),
      ),
    );
  }
}

Future<void> loadDotEnv() async {
  await dotenv.load(fileName: ".env");
}

Future<void> initializeMap() async {
  await NaverMapSdk.instance.initialize(
      clientId: dotenv.get('NAVER_CLOUD_ID'),
      onAuthFailed: (e) => log("인증오류 : $e", name: "onAuthFailed"));
}

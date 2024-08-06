import 'dart:developer';

import 'package:damyo_app/utils/go_router.dart';
import 'package:damyo_app/view_models/bottom_navigation_model.dart';
import 'package:damyo_app/view_models/map_models/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadDotEnv();
  await initializeMap();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavigationModel()),
        ChangeNotifierProvider(create: (context) => MapViewModel()),
      ],
      child: const Damyo(),
    ),
  );
}

class Damyo extends StatelessWidget {
  const Damyo({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0099FC),
          secondary: Color(0xFFD6ECFA),
        ),
      ),
      // Todo: Provider 적용
      routerConfig: router,
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

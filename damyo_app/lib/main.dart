import 'dart:developer';

import 'package:damyo_app/utils/get_cur_pos.dart';
import 'package:damyo_app/utils/get_gal_permission.dart';
import 'package:damyo_app/utils/go_router.dart';
import 'package:damyo_app/view_models/bottom_navigation_model.dart';
import 'package:damyo_app/view_models/login_models/is_login_view_model.dart';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';
import 'package:damyo_app/view_models/login_models/user_info_view_model.dart';
import 'package:damyo_app/view_models/map_models/map_view_model.dart';
import 'package:damyo_app/view_models/map_models/search/sa_search_view_model.dart';
import 'package:damyo_app/view_models/map_models/smoking_area/sa_inform_view_model.dart';
import 'package:damyo_app/view_models/map_models/smoking_area/sa_review_view_model.dart';
import 'package:damyo_app/view_models/statistics_models/period_info_view_model.dart';
import 'package:damyo_app/view_models/statistics_models/smoke_info_view_model.dart';
import 'package:damyo_app/view_models/statistics_models/locaI_info_view_model.dart';
import 'package:damyo_app/view_models/statistics_models/timeAver_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadDotEnv();
  await initializeMap();
  // await getCurrentLocation();
  await getPhotoPermission();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavigationModel()),
        ChangeNotifierProvider(create: (context) => MapViewModel()),
        ChangeNotifierProvider(create: (context) => SaReviewViewModel()),
        ChangeNotifierProvider(create: (context) => SaInformViewModel()),
        ChangeNotifierProvider(create: (context) => SaSearchViewModel()),
        ChangeNotifierProvider(create: (context) => IsloginViewModel()),
        ChangeNotifierProvider(create: (context) => TokenViewModel()),
        ChangeNotifierProvider(create: (context) => UserInfoViewModel()),
        ChangeNotifierProvider(create: (context) => SmokeViewModel()),
        ChangeNotifierProvider(create: (context) => LocalInfoViewModel()),
        ChangeNotifierProvider(create: (context) => TimeaverInfoViewModel()),
        ChangeNotifierProvider(create: (context) => PeriodInfoViewModel()),
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
        scaffoldBackgroundColor: const Color.fromARGB(255, 193, 163, 163),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0099FC),
          secondary: Color(0xFFD6ECFA),
          secondaryContainer: Color(0xFFEEF1F5),
          onSecondaryContainer: Color(0xFFD2D7DD),
        ),
      ),
      // Todo: Provider 적용
      routerConfig: router,
      builder: (context, child) {
        return MediaQuery(
          data:
              MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: child!,
        );
      },
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

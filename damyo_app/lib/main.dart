import 'package:damyo_app/view/home/home_view.dart';
import 'package:damyo_app/view_models/bottom_navigation_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Damyo());
}

class Damyo extends StatelessWidget {
  const Damyo({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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

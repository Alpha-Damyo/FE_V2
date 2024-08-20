import 'package:damyo_app/database/smoke_data.dart';
import 'package:damyo_app/style.dart';
import 'package:damyo_app/view_models/login_models/islogin_view_model.dart';
import 'package:damyo_app/view_models/login_models/user_info_view_model.dart';
import 'package:damyo_app/widgets/statistics/calculate_widget.dart';
import 'package:damyo_app/widgets/statistics/local_info_widget.dart';
import 'package:damyo_app/widgets/statistics/period_info_widget.dart';
import 'package:damyo_app/widgets/statistics/timeAver_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:damyo_app/widgets/statistics/user_info_widget.dart';
import 'package:provider/provider.dart';

class StatisticsView extends StatefulWidget {
  const StatisticsView({super.key});

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _priceController = TextEditingController();

  SmokeDatabase userDB = SmokeDatabase();

  bool timeCheck = true;
  bool compareCheck = true;
  int _selectedIndex = -1;

  List<dynamic>? smokePlace;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getSmokeDB();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> getSmokeDB() async {
    final smokeDB = await userDB.getSmokeInfoGroupedByColumn('id');
    setState(() {
      smokePlace = smokeDB;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<IsloginViewModel, UserInfoViewModel>(
        builder: (context, isloginViewModel, userInfoViewModel, child) {
      return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: textFormat(text: '통계', fontSize: 20),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: (isloginViewModel.isloginModel.isLogin)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    userInfo(context, userInfoViewModel, smokePlace),
                    testbtn(),
                    const SizedBox(
                      height: 20,
                    ),
                    localInfo(context, _tabController),
                    const SizedBox(
                      height: 20,
                    ),
                    timeAverInfo(context, timeCheck, (check) {
                      setState(() {
                        timeCheck = check;
                      });
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    calculate(context, _priceController, _selectedIndex,
                        (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    periodCompareInfo(context, compareCheck, (check) {
                      setState(() {
                        compareCheck = check;
                      });
                    })
                  ],
                )
              : Column(),
        ),
      );
    });
  }
}

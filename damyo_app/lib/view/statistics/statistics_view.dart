import 'package:damyo_app/database/smoke_data.dart';
import 'package:damyo_app/style.dart';
import 'package:damyo_app/view_models/login_models/islogin_view_model.dart';
import 'package:damyo_app/view_models/login_models/user_info_view_model.dart';
import 'package:damyo_app/view_models/statistics_models/locaI_info_view_model.dart';
import 'package:damyo_app/view_models/statistics_models/smoke_info_view_model.dart';
import 'package:damyo_app/view_models/statistics_models/timeAver_info_view_model.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SmokeViewModel>(context, listen: false).fetchSmokeDB(userDB);
      Provider.of<LocalInfoViewModel>(context, listen: false).fetchLocalDB(userDB);
      Provider.of<TimeaverInfoViewModel>(context, listen: false).fetchTimeDB(userDB);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer5<IsloginViewModel, UserInfoViewModel, SmokeViewModel,
            LocalInfoViewModel, TimeaverInfoViewModel>(
        builder: (context, isloginViewModel, userInfoViewModel, smokeViewModel,
            localInfoViewModel, timeaverInfoViewModel, child) {
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
                    userInfo(
                        context, userInfoViewModel, smokeViewModel.smokePlace),
                    testbtn(),
                    const SizedBox(
                      height: 20,
                    ),
                    localInfo(context, _tabController, localInfoViewModel.GuList, localInfoViewModel.areaList, localInfoViewModel.areaInfo),
                    const SizedBox(
                      height: 20,
                    ),
                    timeAverInfo(context, timeCheck, timeaverInfoViewModel.everyTimeInfo, timeaverInfoViewModel.userTimeInfo, (check) {
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

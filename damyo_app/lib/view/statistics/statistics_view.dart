import 'package:damyo_app/database/smoke_data.dart';
import 'package:damyo_app/style.dart';
import 'package:damyo_app/utils/initialized_db.dart';
import 'package:damyo_app/view_models/login_models/is_login_view_model.dart';
import 'package:damyo_app/view_models/login_models/user_info_view_model.dart';
import 'package:damyo_app/view_models/statistics_models/locaI_info_view_model.dart';
import 'package:damyo_app/view_models/statistics_models/period_info_view_model.dart';
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

  bool timeCheck = true;
  bool compareCheck = true;
  String compareType = '일';
  int selectedIndex = -1;
  int allcnt = 0;

  final List<bool> isComparetype = [true, false, false];
  final List<String> calType = ['1일', '1주일', '1달'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
    
  //   if (Provider.of<IsloginViewModel>(context).isLogin) {
      
  //   }
  // }

  @override
  void dispose() {
    _tabController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer6<IsloginViewModel, UserInfoViewModel, SmokeViewModel,
            LocalInfoViewModel, TimeaverInfoViewModel, PeriodInfoViewModel>(
        builder: (context,
            isloginViewModel,
            userInfoViewModel,
            smokeViewModel,
            localInfoViewModel,
            timeaverInfoViewModel,
            periodInfoViewModel,
            child) {
      return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: appbarTitleFormat(text: '통계'),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            initializedDB(context);
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: (isloginViewModel.isLogin)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      userInfo(
                          context, userInfoViewModel, smokeViewModel.smokePlace),
                      Container(
                        height: 20,
                        color: Colors.grey[200],
                      ),
                      localInfo(
                          context,
                          _tabController,
                          localInfoViewModel.GuList,
                          localInfoViewModel.areaList,
                          localInfoViewModel.areaInfo),
                      Container(
                        height: 20,
                        color: Colors.grey[200],
                      ),
                      timeAverInfo(
                          context,
                          timeCheck,
                          timeaverInfoViewModel.everyTimeInfo,
                          smokeViewModel.userTimeInfo, (check) {
                        setState(() {
                          timeCheck = check;
                        });
                      }),
                      Container(
                        height: 20,
                        color: Colors.grey[200],
                      ),
                      calculate(context, smokeViewModel, _priceController,
                          selectedIndex, calType, allcnt, (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      }, (val) {
                        setState(() {
                          allcnt = val;
                        });
                      }),
                      Container(
                        height: 20,
                        color: Colors.grey[200],
                      ),
                      periodCompareInfo(
                          context,
                          compareCheck,
                          compareType,
                          isComparetype,
                          smokeViewModel,
                          periodInfoViewModel, (check) {
                        setState(() {
                          compareCheck = check;
                        });
                      }, (type) {
                        setState(() {
                          isComparetype[type] = true;
                          for (int i = 0; i < isComparetype.length; i++) {
                            if (i != type) {
                              isComparetype[i] = false;
                            }
                          }
                          if (isComparetype[type]) {
                            switch (type) {
                              case 0:
                                compareType = '일';
                                break;
                              case 1:
                                compareType = '주';
                                break;
                              case 2:
                                compareType = '월';
                                break;
                              default:
                                break;
                            }
                          }
                        });
                      })
                    ],
                  )
                : Column(
                    children: [
                      const SizedBox(
                        height: 200,
                      ),
                      Center(
                        child: Container(
                          width: 160,
                          height: 210,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/icons/statistics/notlogin.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: textFormat(
                            text: '로그인하지 않은 상태입니다\n로그인 / 회원가입 후 이용해주세요',
                            fontSize: 16),
                      ),
                    ],
                  ),
          ),
        ),
      );
    });
  }
}

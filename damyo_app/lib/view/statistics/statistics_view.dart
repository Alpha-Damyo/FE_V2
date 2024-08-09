import 'package:damyo_app/style.dart';
import 'package:damyo_app/widgets/statistics/local_info_widget.dart';
import 'package:damyo_app/widgets/statistics/timeAver_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:damyo_app/widgets/statistics/user_info_widget.dart';

class StatisticsView extends StatefulWidget {
  const StatisticsView({super.key});

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  bool timeCheck = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);  
  }

  @override
  void dispose() {
    _tabController.dispose();  
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: textFormat(text: '통계', fontSize: 20),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            userInfo(context),
            SizedBox(height: 20,),
            localInfo(context, _tabController),
            timeAverInfo(context, timeCheck, (newValue){
              setState(() {
                timeCheck = newValue;
              });
            })
          ],
        ),
      ),
    );
  }
}

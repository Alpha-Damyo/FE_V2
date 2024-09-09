import 'package:damyo_app/database/smoke_data.dart';
import 'package:damyo_app/view_models/statistics_models/local_info_view_model.dart';
import 'package:damyo_app/view_models/statistics_models/period_info_view_model.dart';
import 'package:damyo_app/view_models/statistics_models/smoke_info_view_model.dart';
import 'package:damyo_app/view_models/statistics_models/timeaver_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> initializedDB(BuildContext context) async {
  SmokeDatabase userDB = SmokeDatabase();

  await Provider.of<LocalInfoViewModel>(context, listen: false).fetchLocalDB();
  await Provider.of<TimeaverInfoViewModel>(context, listen: false)
      .fetchTimeDB();
  await Provider.of<PeriodInfoViewModel>(context, listen: false)
      .fetchPeriodEveryDB();
  await Provider.of<SmokeViewModel>(context, listen: false)
      .fetchSmokeDB(userDB);
}

void initializedUserDB(BuildContext context) async {
  SmokeDatabase userDB = SmokeDatabase();
  await Provider.of<SmokeViewModel>(context, listen: false)
      .fetchSmokeDB(userDB);
}

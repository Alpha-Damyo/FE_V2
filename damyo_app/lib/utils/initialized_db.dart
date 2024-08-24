import 'package:damyo_app/database/smoke_data.dart';
import 'package:damyo_app/view_models/statistics_models/locaI_info_view_model.dart';
import 'package:damyo_app/view_models/statistics_models/period_info_view_model.dart';
import 'package:damyo_app/view_models/statistics_models/smoke_info_view_model.dart';
import 'package:damyo_app/view_models/statistics_models/timeAver_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void initializedDB(BuildContext context, SmokeDatabase userDB) async {
  await Provider.of<SmokeViewModel>(context).fetchSmokeDB(userDB);
  await Provider.of<LocalInfoViewModel>(context, listen: false)
      .fetchLocalDB(userDB);
  await Provider.of<TimeaverInfoViewModel>(context, listen: false)
      .fetchTimeDB();
  await Provider.of<PeriodInfoViewModel>(context, listen: false)
      .fetchPeriodEveryDB();
}

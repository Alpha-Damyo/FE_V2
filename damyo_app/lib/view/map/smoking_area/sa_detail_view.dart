import 'package:damyo_app/models/smoking_area/sa_detail_model.dart';
import 'package:damyo_app/services/smoking_area_service.dart';
import 'package:damyo_app/style.dart';
import 'package:flutter/material.dart';

class SaDetailView extends StatefulWidget {
  const SaDetailView({super.key, required this.areaId});
  final String areaId;

  @override
  State<SaDetailView> createState() => _SaDetailViewState();
}

class _SaDetailViewState extends State<SaDetailView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SmokingAreaService.getDetailSmokingArea(widget.areaId),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData == false) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: textFormat(text: "에러가 발생하였습니다", fontSize: 18),
            ),
          );
        } else {
          SaDetailModel detail = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: appbarTitleFormat(text: detail.name),
            ),
            body: const Column(),
          );
        }
      },
    );
  }
}

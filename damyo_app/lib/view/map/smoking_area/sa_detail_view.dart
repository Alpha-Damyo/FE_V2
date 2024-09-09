import 'package:damyo_app/models/smoking_area/sa_detail_model.dart';
import 'package:damyo_app/services/smoking_area_service.dart';
import 'package:damyo_app/style.dart';
import 'package:damyo_app/view_models/login_models/is_login_view_model.dart';
import 'package:damyo_app/widgets/map/smoking_area/sa_detail_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaDetailView extends StatefulWidget {
  const SaDetailView({super.key, required this.areaId});
  final String areaId;

  @override
  State<SaDetailView> createState() => _SaDetailViewState();
}

class _SaDetailViewState extends State<SaDetailView> {
  late IsloginViewModel _isloginViewModel;
  @override
  Widget build(BuildContext context) {
    _isloginViewModel = Provider.of<IsloginViewModel>(context);
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
          SaDetailModel saDetailModel = snapshot.data;
          // print(saDetailModel.address);
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            appBar: AppBar(
              title: appbarTitleFormat(text: saDetailModel.name),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  saDetailRepresentativeImage(
                      context, saDetailModel.pictureList),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: saDetailNameScoreBtns(
                      context,
                      saDetailModel.areaId,
                      saDetailModel.name,
                      saDetailModel.score,
                      saDetailModel.reviewCount,
                      saDetailModel.opened,
                      saDetailModel.closed,
                      saDetailModel.indoor,
                      saDetailModel.outdoor,
                      _isloginViewModel.isLogin,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15),
                    child: saDetailInfo(
                      context,
                      saDetailModel.name,
                      saDetailModel.address,
                      saDetailModel.description,
                      saDetailModel.areaId,
                      saDetailModel.opened,
                      saDetailModel.outdoor,
                      _isloginViewModel.isLogin,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15),
                    child: saDetailImages(context, saDetailModel.pictureList),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

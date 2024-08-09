import 'package:damyo_app/style.dart';
import 'package:damyo_app/view_models/map_models/smoking_area/sa_inform_model.dart';
import 'package:damyo_app/widgets/common/image_select_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SaInformView extends StatefulWidget {
  const SaInformView({super.key, required this.lat, required this.lng});
  final double lat;
  final double lng;

  @override
  State<SaInformView> createState() => _SaInformViewState();
}

class _SaInformViewState extends State<SaInformView> {
  double get _lat => widget.lat;
  double get _lng => widget.lng;
  final ImagePicker _imagePicker = ImagePicker();
  late SaInformModel _saInformModel;

  @override
  Widget build(BuildContext context) {
    _saInformModel = Provider.of<SaInformModel>(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: appbarTitleFormat(text: "제보하기"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    imageSelector(
                      context,
                      _imagePicker,
                      _saInformModel.informImage,
                      (xFile) {
                        _saInformModel.setInformImage(xFile);
                      },
                    ),
                    Text("$_lat / $_lng "),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

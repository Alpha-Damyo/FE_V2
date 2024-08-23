import 'package:damyo_app/style.dart';
import 'package:damyo_app/view_models/login_models/is_login_view_model.dart';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';
import 'package:damyo_app/view_models/map_models/smoking_area/sa_inform_view_model.dart';
import 'package:damyo_app/widgets/common/image_select_widget.dart';
import 'package:damyo_app/widgets/map/smoking_area/sa_inform_widgets.dart';
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
  late SaInformViewModel _saInformModel;
  late IsloginViewModel _isloginViewModel;
  late TokenViewModel _tokenViewModel;

  @override
  Widget build(BuildContext context) {
    _saInformModel = Provider.of<SaInformViewModel>(context);
    _isloginViewModel = Provider.of<IsloginViewModel>(context);
    _tokenViewModel = Provider.of<TokenViewModel>(context);

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
                    const SizedBox(height: 20),
                    informName(
                      context,
                      _saInformModel.nameController,
                      _saInformModel.checkCanInform,
                    ),
                    const SizedBox(height: 20),
                    informAddress(context, _lat, _lng,
                        _saInformModel.descriptionController, (val) {
                      _saInformModel.setAddress(val);
                    }),
                    const SizedBox(height: 20),
                    informRating(
                      context,
                      _saInformModel.starValue,
                      (val) {
                        _saInformModel.setStarValue(val);
                      },
                    ),
                    const SizedBox(height: 15),
                    informInOut(
                      context,
                      [_saInformModel.inside, _saInformModel.outside],
                      (index) {
                        _saInformModel.setInOut(index);
                      },
                    ),
                    const SizedBox(height: 10),
                    informOpenClose(
                      context,
                      [_saInformModel.open, _saInformModel.close],
                      (index) {
                        _saInformModel.setOpenClose(index);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            informComplete(
              context,
              _saInformModel.canInform,
              _saInformModel,
              _lat,
              _lng,
              _isloginViewModel.isLogin,
              _tokenViewModel,
            )
          ],
        ),
      ),
    );
  }
}

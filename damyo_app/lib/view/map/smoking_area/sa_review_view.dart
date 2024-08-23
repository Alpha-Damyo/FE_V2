import 'package:damyo_app/style.dart';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';
import 'package:damyo_app/view_models/map_models/smoking_area/sa_review_view_model.dart';
import 'package:damyo_app/widgets/common/image_select_widget.dart';
import 'package:damyo_app/widgets/map/smoking_area/sa_review_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SaReviewView extends StatefulWidget {
  const SaReviewView({super.key, required this.areaId, required this.name});
  final String areaId;
  final String name;

  @override
  State<SaReviewView> createState() => _SaReviewViewState();
}

class _SaReviewViewState extends State<SaReviewView> {
  String get _areaId => widget.areaId;
  String get _name => widget.name;
  final ImagePicker _imagePicker = ImagePicker();
  late SaReviewViewModel _saReviewViewModel;
  late TokenViewModel _tokenViewModel;

  @override
  Widget build(BuildContext context) {
    _saReviewViewModel = Provider.of<SaReviewViewModel>(context);
    _tokenViewModel = Provider.of<TokenViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: appbarTitleFormat(text: "리뷰 작성"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    reviewSaName(context, _name),
                    const SizedBox(height: 20),
                    imageSelector(
                      context,
                      _imagePicker,
                      _saReviewViewModel.reviewImage,
                      (xfile) {
                        _saReviewViewModel.setReviewImage(xfile);
                      },
                    ),
                    const SizedBox(height: 20),
                    reviewRating(context, _saReviewViewModel.starValue, (val) {
                      _saReviewViewModel.setStarValue(val);
                    })
                  ],
                ),
              ),
            ),
            reviewComplete(context, _saReviewViewModel.canReview, _areaId,
                _saReviewViewModel, _tokenViewModel),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _saReviewViewModel.resetAll();
    super.dispose();
  }
}

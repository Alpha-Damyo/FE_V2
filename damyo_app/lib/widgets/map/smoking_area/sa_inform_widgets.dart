import 'package:damyo_app/models/smoking_area/sa_inform_model.dart';
import 'package:damyo_app/models/user/user_info_model.dart';
import 'package:damyo_app/services/naver_address_service.dart';
import 'package:damyo_app/services/smoking_area_service.dart';
import 'package:damyo_app/style.dart';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';
import 'package:damyo_app/view_models/login_models/user_info_view_model.dart';
import 'package:damyo_app/view_models/map_models/map_view_model.dart';
import 'package:damyo_app/view_models/map_models/smoking_area/sa_inform_view_model.dart';
import 'package:damyo_app/widgets/common/ratingstar_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

Widget informName(BuildContext context, TextEditingController nameController,
    Function canInform) {
  return SizedBox(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        essentialText(context, "이름"),
        const SizedBox(height: 5),
        informTextField(context, nameController, "이름을 입력해주세요", canInform),
      ],
    ),
  );
}

Widget informAddress(BuildContext context, double lat, double lng,
    TextEditingController descriptionController, Function setAddress) {
  return SizedBox(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textFormat(text: "주소", fontSize: 18, fontWeight: FontWeight.w700),
        const SizedBox(height: 5),
        basicBox(
          context,
          FutureBuilder(
            future: getNaverAddress(lat, lng),
            builder: (
              BuildContext context,
              AsyncSnapshot snapshot,
            ) {
              if (snapshot.hasData == false) {
                return const Text('...');
              } else if (snapshot.hasError) {
                return const Text('주소를 불러올 수 없습니다');
              } else {
                setAddress(snapshot.data);
                return Text(snapshot.data);
              }
            },
          ),
        ),
        const SizedBox(height: 10),
        informTextField(context, descriptionController, "상세주소를 입력해 주세요", () {})
      ],
    ),
  );
}

Widget informRating(
    BuildContext context, double starValue, Function setStarValue) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      essentialText(context, "별점"),
      ratingStars(context, 25, starValue, setStarValue),
    ],
  );
}

Widget informInOut(
    BuildContext context, List<bool> isSelected, Function onPressed) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      essentialText(context, "실내 여부"),
      informToggle(
          context, [const Text("실내"), const Text("실외")], isSelected, onPressed)
    ],
  );
}

Widget informOpenClose(
    BuildContext context, List<bool> isSelected, Function onPressed) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      essentialText(context, "개방 여부"),
      informToggle(
          context, [const Text("개방"), const Text("폐쇄")], isSelected, onPressed)
    ],
  );
}

Widget informComplete(
  BuildContext context,
  bool canReview,
  SaInformViewModel model,
  double lat,
  double lng,
  bool isLogin,
  TokenViewModel tokenViewModel,
  MapViewModel mapViewModel,
) {
  return InkWell(
    borderRadius: const BorderRadius.all(Radius.circular(16)),
    onTap: () async {
      if (canReview) {
        model.updateIsLoading(true);
        SaInformModel saInformModel = SaInformModel.fromJson({
          "name": model.nameController.text,
          "latitude": lat,
          "longitude": lng,
          "address": model.address,
          "description": model.descriptionController.text,
          "score": model.starValue,
          "indoor": model.inside,
          "outdoor": model.outside,
          "opened": model.open,
          "closed": model.close,
        });

        bool success = await SmokingAreaService.informSmokingArea(
            isLogin, tokenViewModel, model.informImage, saInformModel);

        Provider.of<UserInfoViewModel>(context, listen: false)
            .updateContributionByInform();
        model.updateIsLoading(false);
        if (success) {
          Fluttertoast.showToast(msg: "제보가 완료되었습니다");
          mapViewModel.changeInformBtnVisible();
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(msg: "제보에 실패하였습니다");
        }
      }
    },
    child: Ink(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: canReview
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSecondaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Align(
        alignment: Alignment.center,
        child: textFormat(
          text: '제보 완료',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget basicBox(BuildContext context, Widget widget) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12.5),
    decoration: BoxDecoration(
      border: Border.all(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(4),
    ),
    child: widget,
  );
}

Widget essentialText(BuildContext context, String name) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextSpan(
          text: " *",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget informTextField(BuildContext context, TextEditingController controller,
    String hint, Function onChange) {
  return TextField(
    controller: controller,
    onChanged: (value) {
      onChange();
    },
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ), // 선택되지 않았을 때
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
        ), // 선택되었을 때
      ),
      hintText: hint,
    ),
    style: const TextStyle(fontSize: 14),
  );
}

Widget informToggle(BuildContext context, List<Widget> types,
    List<bool> isSelected, Function onPressed) {
  return ToggleButtons(
    isSelected: isSelected,
    onPressed: (index) {
      onPressed(index);
    },
    constraints: const BoxConstraints(minHeight: 30, minWidth: 60),
    borderRadius: BorderRadius.circular(5),
    fillColor: const Color(0xFF90CAF9),
    selectedColor: Colors.black,
    children: types,
  );
}

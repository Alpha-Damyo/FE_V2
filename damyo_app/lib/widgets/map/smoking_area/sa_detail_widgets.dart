import 'package:damyo_app/database/smoke_data.dart';
import 'package:damyo_app/style.dart';
import 'package:damyo_app/utils/initialized_db.dart';
import 'package:damyo_app/utils/re_login_dialog.dart';
import 'package:damyo_app/view/map/smoking_area/favorites_bottomsheet.dart';
import 'package:damyo_app/view/map/smoking_area/sa_gallery_screen.dart';
import 'package:damyo_app/view/map/smoking_area/sa_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:go_router/go_router.dart';

// 흡연구역 대표 이미지
Widget saDetailRepresentativeImage(
    BuildContext context, List<dynamic> imageUrlList) {
  String? photoUrl;
  if (imageUrlList.isNotEmpty) {
    photoUrl = imageUrlList[0]["pictureUrl"];
  }
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SaImageScreen(photoUrl),
        ),
      );
    },
    child: SizedBox(
      width: double.infinity,
      height: 250,
      child: photoUrl == null
          ? Image.asset(
              'assets/images/smoking_area_default_img.png',
              fit: BoxFit.cover,
            )
          : Image.network(
              photoUrl,
              fit: BoxFit.cover,
            ),
    ),
  );
}

// 흡연구역 이름, 별점, 버튼(즐겨찾기, 공유, 리뷰작성, 흡연완료)
Widget saDetailNameScoreBtns(
  BuildContext context,
  String areaId,
  String name,
  double score,
  bool? opened,
  bool? closed,
  bool? indoor,
  bool? outdoor,
  bool isLogin,
) {
  String tag = "";
  if (opened == true) {
    tag += " #개방형 ";
  } else if (closed == true) {
    tag += " #폐쇄형 ";
  }
  if (indoor == true) {
    tag += "#실내 ";
  } else if (outdoor == true) {
    tag += "#실외 ";
  }

  SmokeDatabase userDB = SmokeDatabase();
  DateTime now = DateTime.now();

  return Column(
    children: [
      textFormat(
        text: name,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      const SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textFormat(text: score.toStringAsFixed(1), color: Colors.red),
          const SizedBox(width: 5),
          RatingStars(
            value: score,
            valueLabelVisibility: false,
            starColor: Colors.red,
            starSize: 18,
          ),
          const SizedBox(width: 5),
          textFormat(text: "(3건)")
        ],
      ),
      const SizedBox(height: 10),
      textFormat(text: tag),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          saDetailBtn(
            context,
            (Icons.bookmark_add),
            "즐겨찾기",
            () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const FavoritesBottomsheet();
                  });
            },
          ),
          saDetailBtn(
            context, (Icons.share_rounded), "공유",
            // Todo: 공유
            () {},
          ),
          saDetailBtn(
            context,
            (Icons.message),
            "리뷰작성",
            () {
              if (isLogin) {
                context.push("/smokingarea/$areaId/review", extra: name);
              } else {
                reLogin(context);
              }
            },
          ),
          saDetailBtn(
            context,
            (Icons.check_box),
            "흡연완료",
            // Todo: 흡연 완료
            () async {
              await userDB.insertSmokeInfo(areaId, name, now);
              initializedUserDB(context);
            },
          ),
        ],
      ),
    ],
  );
}

// 버튼 양식
Widget saDetailBtn(
    BuildContext context, IconData icon, String name, Function onTap) {
  return Column(
    children: [
      normalMaterial(
        context,
        100,
        InkWell(
          onTap: () {
            onTap();
          },
          borderRadius: BorderRadius.circular(100),
          child: Ink(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
      const SizedBox(height: 5),
      textFormat(
        text: name,
        color: Theme.of(context).colorScheme.primary,
      )
    ],
  );
}

// 흡연구역 정보(주소, 설명, 수정제안)
Widget saDetailInfo(
    BuildContext context,
    String name,
    String address,
    String description,
    String areaId,
    bool? opened,
    bool? outdoor,
    bool isLogined) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.location_on_sharp),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textFormat(
                  text: address,
                  fontSize: 16,
                  textOverflow: TextOverflow.clip,
                ),
                if (description != "") const SizedBox(height: 5),
                if (description != "")
                  textFormat(
                    text: description,
                    textOverflow: TextOverflow.clip,
                  ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 15),
      InkWell(
        onTap: () {
          if (isLogined) {
            context.push("/smokingarea/$areaId/report", extra: name);
          } else {
            reLogin(context);
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.mode_edit_outlined),
            const SizedBox(width: 10),
            Flexible(
              child: textFormat(
                text: "정보 수정 제안",
                fontSize: 16,
                textOverflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// 사진 목록
Widget saDetailImages(BuildContext context, List<dynamic> photoUrlList) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          textFormat(
              text: "사진 (${photoUrlList.length})", fontWeight: FontWeight.w600)
          // const Text(
          //   '전체보기 >',
          //   style: TextStyle(
          //     fontSize: 12,
          //     fontWeight: FontWeight.w600,
          //     color: Color(0xff6f767f),
          //   ),
          // ),
        ],
      ),
      const SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (int i = 0; i < photoUrlList.length; i++)
                Padding(
                  padding: EdgeInsets.only(
                      right: i == photoUrlList.length - 1 ? 0 : 15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SaGalleryScreen(
                              photoUrlList: photoUrlList,
                              photoIndex: i,
                            ),
                          ),
                        );
                      },
                      child: Image.network(
                        photoUrlList[i]["pictureUrl"],
                        width: 128,
                        height: 128,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      )
    ],
  );
}

Widget grayBox(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 15,
    color: Theme.of(context).colorScheme.secondaryContainer,
  );
}

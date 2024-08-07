import 'package:damyo_app/style.dart';
import 'package:damyo_app/widgets/map/smoking_area/sa_gallery_screen.dart';
import 'package:damyo_app/widgets/map/smoking_area/sa_iamge_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

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
          builder: (context) => SaIamgeScreen(photoUrl),
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
Widget saDetailNameScoreBtns(BuildContext context, String name, double score) {
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RatingStars(
            value: score,
            valueLabelVisibility: false,
          ),
          const SizedBox(width: 10),
          textFormat(text: "(3건)")
        ],
      ),
      const SizedBox(height: 30),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          saDetailBtn(context, (Icons.bookmark_add), "즐겨찾기", () {}),
          saDetailBtn(context, (Icons.share_rounded), "공유", () {}),
          saDetailBtn(context, (Icons.message), "리뷰작성", () {}),
          saDetailBtn(context, (Icons.check_box), "흡연완료", () {}),
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

// 흡연구역 정보(주소, 설명, 태그)
Widget saDetailInfo(
    String address, String description, bool? opened, bool? outdoor) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.location_on_outlined),
          const SizedBox(width: 5),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textFormat(
                  text: address,
                  fontSize: 16,
                  textOverflow: TextOverflow.clip,
                ),
                const SizedBox(height: 5),
                textFormat(
                  text: description,
                  textOverflow: TextOverflow.clip,
                ),
              ],
            ),
          ),
        ],
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

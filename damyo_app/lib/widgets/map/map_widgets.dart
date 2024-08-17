import "package:damyo_app/style.dart";
import "package:damyo_app/view_models/map_models/map_view_model.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

// 검색 바
Widget mapSearchBar(BuildContext context) {
  return GestureDetector(
    onTap: () {
      context.push("/search");
    },
    child: Container(
      width: MediaQuery.of(context).size.width - 50 - 30 - 10,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          btnBoxShadow(),
        ],
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            size: 25,
          ),
          const SizedBox(width: 10),
          textFormat(
              text: "흡연구역 검색", fontSize: 16, color: const Color(0xFF666666)),
        ],
      ),
    ),
  );
}

// 제보 버튼
Widget informBtn(BuildContext context, Function onTap) {
  return shadowMaterial(
    context,
    16,
    InkWell(
      onTap: () {
        onTap();
      },
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_location_alt_outlined,
              size: 25,
              color: Colors.white,
            ),
            Text(
              "제보",
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// 태그 버튼
Widget tagListView(
  BuildContext context,
  List<String> tags,
  int tagIndex,
  Function(int) onTap,
) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - 30,
    height: 30,
    child: ListView.builder(
      itemCount: tags.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            right: index == tags.length - 1 ? 5 : 10,
          ), // 마지막 아이템에는 패딩을 적용하지 않음.
          child: shadowMaterial(
            context,
            16,
            InkWell(
              onTap: () {
                onTap(index);
              },
              borderRadius: BorderRadius.circular(16),
              child: Ink(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: tagIndex == index
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: tagIndex == index
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white,
                      width: 1),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: textFormat(
                      text: tags[index], fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

// "이 위치에서 재탐색" 버튼
Widget reSearchBtn(BuildContext context, bool visible, Function onTap) {
  return Visibility(
    visible: visible,
    child: shadowMaterial(
      context,
      36,
      InkWell(
        onTap: () {
          onTap();
        },
        borderRadius: BorderRadius.circular(36),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFD2D7DD),
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(36),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.refresh_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 5),
              textFormat(
                text: "이 위치에서 재탐색",
              ),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ),
    ),
  );
}

// 제보 버튼을 누르면 가운데에 활성화되는 버튼
Widget centerInformBtn(
    BuildContext context, bool visible, Map<String, double> coord) {
  return Visibility(
    visible: visible,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.add_location_alt,
          color: Colors.red,
          size: 40,
        ),
        const SizedBox(
          height: 10,
        ),
        // 제보하기를 누르면 등장하는 '제보하기' 버튼
        shadowMaterial(
          context,
          36,
          InkWell(
            onTap: () {
              context.push("/smokingarea/inform", extra: coord);
            },
            borderRadius: BorderRadius.circular(36),
            child: Ink(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(36),
              ),
              child: textFormat(text: "제보하기"),
            ),
          ),
        ),
      ],
    ),
  );
}

// 흡연구역 정보 카드
Widget smokingAreaCard(
  BuildContext context,
  MapViewModel mapViewModel,
  Function onTapAddFavorites,
  Function onTapCompleteSmoking,
) {
  return Visibility(
    visible: mapViewModel.showSmokingAreaCard,
    child: GestureDetector(
      onTap: () {
        context
            .push('/smokingarea/${mapViewModel.smokingAreawCardInfo.areaId}');
      },
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFD2D7DD)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_sharp,
                      size: 24,
                    ),
                    textFormat(
                      text: " ${mapViewModel.smokingAreawCardInfo.name}",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
                textFormat(
                  text: "상세주소: ${mapViewModel.smokingAreawCardInfo.address}",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.red,
                      size: 24,
                    ),
                    textFormat(
                      text: mapViewModel.smokingAreawCardInfo.score.toString(),
                      fontSize: 16,
                    )
                  ],
                ),
                Row(
                  children: [
                    simpleBtn(context, "즐겨찾기 추가", onTapAddFavorites),
                    const SizedBox(width: 10),
                    simpleBtn(context, "흡연 완료", onTapCompleteSmoking),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget simpleBtn(BuildContext context, String text, Function onTap) {
  return normalMaterial(
    context,
    36,
    InkWell(
      onTap: () {
        onTap();
      },
      borderRadius: BorderRadius.circular(36),
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(36),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 6,
        ),
        child: textFormat(
          text: text,
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

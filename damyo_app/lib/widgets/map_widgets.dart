import "package:flutter/material.dart";

// 버튼 그림자
BoxShadow btnBoxShadow() {
  return BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 0,
    blurRadius: 2.0,
    offset: const Offset(0, 3), // changes position of shadow
  );
}

// 검색 바
Widget mapSearchBar(BuildContext context) {
  return GestureDetector(
    onTap: () {
      // Todo: 검색페이지 연동
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
      child: const Row(
        children: [
          Icon(
            Icons.search,
            size: 25,
          ),
          SizedBox(width: 10),
          Text("흡연구역 검색")
        ],
      ),
    ),
  );
}

// 제보 버튼
Widget informBtn(BuildContext context) {
  return InkWell(
    onTap: () {
      // Todo: 제보페이지 연동
    },
    child: Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        border: Border.all(color: const Color(0xFFD2D7DD)),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          btnBoxShadow(),
        ],
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_location_alt_outlined,
            size: 20,
            color: Colors.white,
          ),
          Text(
            "제보",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

// 태그 버튼
Widget tagListView(BuildContext context, List<String> tags) {
  return Container(
    width: MediaQuery.of(context).size.width - 30,
    height: 35,
    alignment: Alignment.centerLeft,
    child: ListView.builder(
      itemCount: tags.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            right: index == tags.length - 1 ? 5 : 10,
            bottom: 5,
          ), // 마지막 아이템에는 패딩을 적용하지 않음.
          child: GestureDetector(
            onTap: () {
              // Todo: 태그 버튼 터치 적용
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xffE4E7EB),
                ),
                boxShadow: [
                  btnBoxShadow(),
                ],
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(tags[index]),
              ),
            ),
          ),
        );
      },
    ),
  );
}

// "이 위치에서 재탐색" 버튼
Widget reSearchBtn(BuildContext context) {
  return Visibility(
    visible: true,
    child: InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFD2D7DD)),
          borderRadius: BorderRadius.circular(36),
          boxShadow: [
            btnBoxShadow(),
          ],
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
            const Text("이 위치에서 재탐색"),
          ],
        ),
      ),
    ),
  );
}

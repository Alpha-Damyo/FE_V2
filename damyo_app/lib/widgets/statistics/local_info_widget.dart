import 'package:damyo_app/models/smoking_area/sa_basic_model.dart';
import 'package:damyo_app/style.dart';
import 'package:damyo_app/view/map/smoking_area/sa_detail_view.dart';
import 'package:flutter/material.dart';

// 인기있는 흡연 구역 정보
Widget localInfo(BuildContext context, TabController tabController,
    List<dynamic>? guList, List<dynamic>? areaList, List<dynamic>? areaInfo) {
  return SizedBox(
    width: double.infinity,
    height: 300,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                child: textFormat(
                    text: '가장 인기있는 흡연구역',
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TabBar(
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.black,
            tabs: const [
              Tab(text: '지역'),
              Tab(text: '흡연구역'),
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TabBarView(
              controller: tabController,
              children: [
                _tapContentsGu(guList),
                _tapContentsSmokeArea(context, areaList, areaInfo)
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// 가장 인기있는 지역
Widget _tapContentsGu(List<dynamic>? guList) {
  if (guList == null || guList.isEmpty) {
    return const Center(child: Text('지역 정보가 존재하지 않습니다.'));
  }
  return Column(
      children: List.generate(
    guList.length,
    (index) {
      return gu(guList[index], index);
    },
  ));
}

// 가장 인기있는 흡연구역(흡연구역)
Widget _tapContentsSmokeArea(
    BuildContext context, List<dynamic>? areaList, List<dynamic>? areaInfo) {
  if (areaList == null || areaList.isEmpty) {
    return const Center(child: Text('구역 정보가 존재하지 않습니다.'));
  }
  return Column(
      children: List.generate(
    areaList.length,
    (index) {
      return sa(areaList[index], areaInfo?[index], index, context);
    },
  ));
}

// 흡연 지역 정보
Widget gu(Map<String, dynamic> guInfo, int rank) {
  String key = guInfo.keys.first;
  dynamic value = guInfo[key];
  return SizedBox(
    height: 55,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${rank + 1}등',
          style: const TextStyle(
            color: Color(0xFF0099FC),
            fontSize: 12,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              key,
              style: const TextStyle(
                color: Color(0xFF10151B),
                fontSize: 14,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '$value회',
              style: const TextStyle(
                color: Color(0xFF454D56),
                fontSize: 12,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// 흡연 구역 정보
Widget sa(Map<String, dynamic> saInfo, SaBasicModel saModel, int rank,
    BuildContext context) {
  String key = saInfo.keys.first;
  dynamic value = saInfo[key];

  return Ink(
    height: 55,
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SaDetailView(areaId: saModel.areaId)));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${rank + 1}등',
            style: const TextStyle(
              color: Color(0xFF0099FC),
              fontSize: 12,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textFormat(text: saModel.name, fontWeight: FontWeight.w600),
              textFormat(
                  text: '$value회', fontSize: 12, fontWeight: FontWeight.w400),
            ],
          ),
        ],
      ),
    ),
  );
}

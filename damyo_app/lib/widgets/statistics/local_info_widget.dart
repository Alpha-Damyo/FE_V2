import 'package:damyo_app/models/smoking_area/sa_basic_model.dart';
import 'package:damyo_app/style.dart';
import 'package:damyo_app/view/map/smoking_area/sa_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 인기있는 흡연 구역 정보
Widget localInfo(BuildContext context, TabController tabController,
    List<dynamic>? guList, List<dynamic>? areaList, List<dynamic>? areaInfo) {
  return Container(
    width: double.infinity,
    height: 300,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
Widget _tapContentsGu(List<dynamic>? _GuList) {
  if (_GuList == null || _GuList.isEmpty) {
    return const Center(child: Text('지역 정보가 존재하지 않습니다.'));
  }
  return Column(
      children: List.generate(
    _GuList.length,
    (index) {
      return Gu(_GuList[index], index);
    },
  ));
}

// 가장 인기있는 흡연구역(흡연구역)
Widget _tapContentsSmokeArea(
    BuildContext context, List<dynamic>? _areaList, List<dynamic>? _areaInfo) {
  if (_areaList == null || _areaList.isEmpty) {
    return const Center(child: Text('구역 정보가 존재하지 않습니다.'));
  }
  return Column(
      children: List.generate(
    _areaList.length,
    (index) {
      return Sa(_areaList[index], _areaInfo?[index], index, context);
    },
  ));
}

// 흡연 지역 정보
Widget Gu(Map<String, dynamic> GuInfo, int rank) {
  String key = GuInfo.keys.first;
  dynamic value = GuInfo[key];
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
Widget Sa(Map<String, dynamic> SaInfo, SaBasicModel SaModel, int rank,
    BuildContext context) {
  String key = SaInfo.keys.first;
  dynamic value = SaInfo[key];

  return Ink(
    height: 55,
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SaDetailView(areaId: SaModel.areaId)));
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
              textFormat(text: SaModel.name, fontWeight: FontWeight.w600),
              textFormat(
                  text: '$value회', fontSize: 12, fontWeight: FontWeight.w400),
            ],
          ),
        ],
      ),
    ),
  );
}

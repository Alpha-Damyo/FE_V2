import 'package:damyo_app/models/smoking_area/sa_detail_model.dart';
import 'package:damyo_app/services/smoking_area_service.dart';
import 'package:damyo_app/style.dart';
import 'package:damyo_app/view/map/smoking_area/sa_detail_view.dart';
import 'package:damyo_app/view_models/login_models/user_info_view_model.dart';
import 'package:flutter/material.dart';

// 사용자 정보 위젯
Widget userInfo(BuildContext context, UserInfoViewModel userInfoViewModel,
    List<dynamic>? smokePlace) {
  return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 25,
        left: 16,
        right: 16,
        bottom: 20,
      ),
      //그라데이션
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFFD6ECFA), Colors.white],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: userInfoViewModel.userInfoModel.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const TextSpan(
                          text: '님을\n분석해봤어요',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  child: textFormat(
                text: '가장 많이 방문한 곳',
                fontSize: 16,
              )),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              (smokePlace == null || smokePlace.isEmpty)
                  ? Center(child: textFormat(text: '흡연 기록이 없습니다.'))
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(smokePlace.length, (index) {
                          if (index < 3) {
                            return FutureBuilder(
                                future: SmokingAreaService.getDetailSmokingArea(
                                    smokePlace[index]['id']),
                                builder: (context, AsyncSnapshot saInfo) {
                                  if (saInfo.hasError) {
                                    return _mostSmokingArea(
                                      context,
                                      index + 1,
                                      smokePlace[index]['id'],
                                      smokePlace[index]['name'],
                                      smokePlace[index]['count'],
                                      null,
                                    );
                                  } else {
                                    return _mostSmokingArea(
                                      context,
                                      index + 1,
                                      smokePlace[index]['id'],
                                      smokePlace[index]['name'],
                                      smokePlace[index]['count'],
                                      saInfo.data,
                                    );
                                  }
                                });
                          }
                          return Container();
                        }).where((element) => element != Container()).toList(),
                      ),
                    ),
            ],
          ),
        ],
      ));
}

// 많이 방문한 흡연구역
Widget _mostSmokingArea(BuildContext context, int rank, String id, String name,
    int cnt, SaDetailModel? saInfo) {
  return Row(
    children: [
      Center(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SaDetailView(areaId: id)));
          },
          child: Container(
            width: 130,
            height: 120,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: const Color(0xFFEEF1F4)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$rank등',
                  style: const TextStyle(
                    color: Color(0xFF0099FC),
                    fontSize: 12,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Color(0xFF10151B),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$cnt회',
                      style: const TextStyle(
                        color: Color(0xFF6E767F),
                        fontSize: 10,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (saInfo != null)
                          if (saInfo.closed == true)
                            _buildTag('폐쇄')
                          else if (saInfo.opened == true)
                            _buildTag('개방'),
                        const SizedBox(
                          width: 10,
                        ),
                        if (saInfo != null)
                          if (saInfo.outdoor == true)
                            _buildTag('실외')
                          else if (saInfo.indoor == true)
                            _buildTag('실내'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
    ],
  );
}

Widget _buildTag(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      color: const Color(0xFFD6ECFA),
      borderRadius: BorderRadius.circular(8),
    ),
    child: textFormat(
      text: text,
      fontSize: 10,
      color: const Color(0xFF0E6AA6),
    ),
  );
}

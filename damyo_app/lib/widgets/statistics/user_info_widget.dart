import 'package:damyo_app/services/statistics_service.dart';
import 'package:damyo_app/style.dart';
import 'package:damyo_app/view_models/login_models/user_info_view_model.dart';
import 'package:flutter/material.dart';

// 사용자 정보 위젯
Widget userInfo(BuildContext context, UserInfoViewModel userInfoViewModel) {
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
            ],
          ),
        ],
      ));
}

Widget testbtn() {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: InkWell(
      onTap: () async {
        await getDateStatics();
        await getRegionStatics();
      },
      child: Container(
        width: 100,
        height: 55,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFF000000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(41),
          ),
        ),
      ),
    ),
  );
}
import 'package:damyo_app/style.dart';
import 'package:flutter/material.dart';

Widget UserInfo(String name, int contributionScore, double contributionPecentage,
    int? contributionGap, String? profileUrl) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    decoration: const BoxDecoration(color: Colors.white),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  child: Row(
                    children: [
                      textFormat(
                          text: name,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                      textFormat(
                          text: ' 님의 기여도',
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              textFormat(
                  text: '$contributionScore점',
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  textFormat(
                      text: '상위',
                      color: const Color(0xFF0099FC),
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                  textFormat(
                      text: ' $contributionPecentage%',
                      color: const Color(0xFF0099FC),
                      fontSize: 24,
                      fontWeight: FontWeight.w700)
                ],
              ),
              const SizedBox(height: 6),
              (contributionGap != null)
                  ? textFormat(
                      text: '1등과 $contributionGap점 차이가 나요. 조금만 더 노력해보세요!',
                      color: const Color(0xFF6E767F),
                      fontWeight: FontWeight.w500)
                  : textFormat(
                      text: '사용자 정보를 불러오지 못했습니다.',
                      color: const Color(0xFF6E767F),
                      fontWeight: FontWeight.w500),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300 * (contributionPecentage * 0.01),
                height: 10,
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(1.00, 0.00),
                    end: Alignment(-1, 0),
                    colors: [Color(0xFFBFE5FF), Color(0xFF0099FC)],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: (profileUrl != null)
                        ? NetworkImage(profileUrl) as ImageProvider
                        : const AssetImage(
                            'assets/icons/setting/contribution/defalut.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                width: 340 * (1 - (contributionPecentage * 0.01)),
                height: 10,
                decoration: ShapeDecoration(
                  color: const Color(0xFFEEF1F4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

List<int> contributionPoint = [5, 50, 100, 500];

Widget badgeList(int contributionScore) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(color: Colors.white),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: textFormat(
                            text: '기여도 뱃지',
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                  width: double.infinity,
                  child: textFormat(
                      text: '기여도가 올라갈 수록 뱃지가 생겨요. 기여도를 올려 뱃지를 모아보세요 !',
                      fontSize: 12,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(contributionPoint.length, (index) {
            return Container(
              width: 80,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: (contributionScore < contributionPoint[index])
                        ? Image.asset(
                            'assets/icons/setting/contribution/lock.png')
                        : Image.asset(
                            'assets/icons/setting/contribution/contribution_${contributionPoint[index]}.png'),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    ),
  );
}

Widget explane() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    decoration: const BoxDecoration(color: Colors.white),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: double.infinity,
          child: Text(
            '기여도 획득 방법',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '제보하기',
                    style: TextStyle(
                      color: Color(0xFF0099FC),
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  SizedBox(width: 23),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        '흡연 구역 하나를 제보해 주실 때마다 20의 기여도를 얻을 수 있어요',
                        style: TextStyle(
                          color: Color(0xFF262B32),
                          fontSize: 12,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFFF7F8FA),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '리뷰하기',
                    style: TextStyle(
                      color: Color(0xFF0099FC),
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  SizedBox(width: 23),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        '흡연 구역 하나를 리뷰해 주실 때마다 5의 기여도를 얻을 수 있어요',
                        style: TextStyle(
                          color: Color(0xFF262B32),
                          fontSize: 12,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFFF7F8FA),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        const SizedBox(height: 30),
        Center(
          child: Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 16,
              right: 16,
              bottom: 10,
            ),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFFF7F8FA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  '기여도를 획득해서\n총 4개의 뱃지를 얻어 보아요!',
                  style: TextStyle(
                    color: Color(0xFF0099FC),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                const SizedBox(width: 30),
                Container(
                  width: 75,
                  height: 75,
                  padding: const EdgeInsets.all(16),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD6ECFA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child:
                      Image.asset('assets/icons/setting/contribution/lock.png'),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

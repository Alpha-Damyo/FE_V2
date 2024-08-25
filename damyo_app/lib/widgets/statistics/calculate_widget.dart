import 'package:damyo_app/style.dart';
import 'package:damyo_app/view_models/statistics_models/smoke_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// 담배값 계산기
Widget calculate(
    BuildContext context,
    SmokeViewModel smokeViewModel,
    TextEditingController priceController,
    int selectedIndex,
    List<String> calType,
    int allcnt,
    Function(int) onTap,
    Function(int) onChanged) {
  return SizedBox(
    width: double.infinity,
    height: 300,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20, left: 16),
          child: Text(
            '나의 담배가격 계산해보기',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: 300,
          height: 60,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      if (selectedIndex == index) {
                        selectedIndex = -1;
                        onTap(-1);
                      } else {
                        selectedIndex = index;
                        onTap(index);
                      }
                    },
                    child: Container(
                      width: 65,
                      height: 12,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? Theme.of(context).colorScheme.onPrimary
                            : Colors.white,
                        borderRadius: BorderRadius.circular(26),
                        border: selectedIndex == index
                            ? Border.all(
                                color: Theme.of(context).colorScheme.primary,
                              )
                            : Border.all(
                                color: const Color(0xffE4E7EB),
                              ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: textFormat(
                          text: calType[index],
                          color: const Color(0xFF464D57),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: const Text(
                  '직접 입력하기',
                  style: TextStyle(
                    color: Color(0xFF454D56),
                    fontSize: 12,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                onPressed: () {
                  onTap(-1);
                  selectedIndex = -1;
                  priceController.clear();
                  onChanged(0);
                },
              ),
              if (selectedIndex == -1)
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: priceController,
                    textAlign: TextAlign.right,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      if (!_isFieldEmpty(priceController)) {
                        onChanged(int.parse(priceController.text));
                      } else {
                        onChanged(0);
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: '개비 수를 입력해주세요.',
                      border: InputBorder.none,
                      alignLabelWithHint: true,
                    ),
                    style: const TextStyle(
                      color: Color(0xFF454D56),
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Text(
                  (selectedIndex == -1)
                      ? '${priceController.text} 개비'
                      : (selectedIndex == 0)
                          ? '${(smokeViewModel.cntMonth == null) ? 0 : smokeViewModel.cntMonth} 개비'
                          : (selectedIndex == 1)
                              ? '${(smokeViewModel.cntWeek == null) ? 0 : smokeViewModel.cntWeek} 개비'
                              : '${(smokeViewModel.cntDay == null) ? 0 : smokeViewModel.cntDay} 개비',
                  style: const TextStyle(
                    color: Color(0xFF454D56),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                child: Text(
                  (selectedIndex == -1)
                      ? formatCurrency(allcnt)
                      : (selectedIndex == 0)
                          ? formatCurrency(smokeViewModel.cntMonth)
                          : (selectedIndex == 1)
                              ? formatCurrency(smokeViewModel.cntWeek)
                              : formatCurrency(smokeViewModel.cntDay),
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Color(0xFF0099FC),
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

String formatCurrency(var cnt) {
  int price;
  if (cnt == null) {
    price = 0;
  } else {
    price = cnt * 225;
  }

  final formatter = NumberFormat.currency(locale: 'ko_KR', symbol: '');
  return '${formatter.format(price)}원';
}

bool _isFieldEmpty(TextEditingController controller) {
  return controller.text.trim().isEmpty;
}

import 'package:damyo_app/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<String> calType = ['1일', '1주일', '1달'];

// 담배값 계산기 
Widget calculate(BuildContext context, TextEditingController _priceController,
    int _selectedIndex, Function(int) onTap) {
  return Container(
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
        Container(
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
                      if (_selectedIndex == index) {
                        _selectedIndex = -1;
                        onTap(-1);
                      } else {
                        _selectedIndex = index;
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
                        color: _selectedIndex == index
                            ? Theme.of(context).colorScheme.onPrimary
                            : Colors.white,
                        borderRadius: BorderRadius.circular(26),
                        border: _selectedIndex == index
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
                          color: Color(0xFF464D57),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
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
                  // _inputUser = !_inputUser;
                  // _selectedIndex = -1;
                  // _priceController.clear();
                  // allcnt = 0;
                },
              ),
              // if (_inputUser)
              //   SizedBox(
              //     width: 100,
              //     child: TextField(
              //       controller: _priceController,
              //       textAlign: TextAlign.right,
              //       inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              //       onChanged: (value) {
              //         setState(() {
              //           if (!_isFieldEmpty(_priceController)) {
              //             allcnt = int.parse(_priceController.text);
              //           } else {
              //             allcnt = 0;
              //           }
              //         });
              //       },
              //       decoration: const InputDecoration(
              //         hintText: '개비 수를 입력해주세요.',
              //         border: InputBorder.none,
              //         alignLabelWithHint: true,
              //       ),
              //       style: const TextStyle(
              //         color: Color(0xFF454D56),
              //         fontSize: 16,
              //         fontFamily: 'Pretendard',
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SizedBox(
              //   child: Text(
              //     (_inputUser)
              //         ? '${_priceController.text} 개비'
              //         : (_selectedIndex == 0)
              //             ? '$cntMonth 개비'
              //             : (_selectedIndex == 1)
              //                 ? '$cntWeek 개비'
              //                 : '$cntDay 개비',
              //     style: const TextStyle(
              //       color: Color(0xFF454D56),
              //       fontSize: 14,
              //       fontFamily: 'Pretendard',
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   child: Text(
              //     (_inputUser)
              //         ? formatCurrency(allcnt)
              //         : (_selectedIndex == 0)
              //             ? formatCurrency(cntMonth)
              //             : (_selectedIndex == 1)
              //                 ? formatCurrency(cntWeek)
              //                 : formatCurrency(cntDay),
              //     textAlign: TextAlign.right,
              //     style: const TextStyle(
              //       color: Color(0xFF0099FC),
              //       fontSize: 16,
              //       fontFamily: 'Pretendard',
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    ),
  );
}

import 'package:damyo_app/style.dart';
import 'package:damyo_app/widgets/map/smoking_area/sa_report_widgets.dart';
import 'package:flutter/material.dart';

class SaReportView extends StatefulWidget {
  final String areaId;
  final String name;
  const SaReportView({super.key, required this.areaId, required this.name});

  @override
  State<SaReportView> createState() => _SaReportViewState();
}

class _SaReportViewState extends State<SaReportView> {
  String get _areaId => widget.areaId;
  String get _name => widget.name;
  final List<bool> _isChecked = [false, false];
  String _etc = "";
  bool _canReport = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: appbarTitleFormat(text: "흡연구역 수정 제안"),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: reportSaName(context, _name),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isChecked[0] = !_isChecked[0];
                  _canReport = checkCanReport();
                });
              },
              child: Row(
                children: [
                  Checkbox(
                    value: _isChecked[0],
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked[0] = value!;
                        _canReport = checkCanReport();
                      });
                    },
                  ),
                  textFormat(
                      text: "존재하지 않는 장소에요",
                      fontSize: 18,
                      fontWeight: FontWeight.w600)
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isChecked[1] = !_isChecked[1];
                  _canReport = checkCanReport();
                });
              },
              child: Row(
                children: [
                  Checkbox(
                    value: _isChecked[1],
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked[1] = value!;
                        _canReport = checkCanReport();
                      });
                    },
                  ),
                  textFormat(
                      text: "태그가 일치하지 않아요",
                      fontSize: 18,
                      fontWeight: FontWeight.w600)
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isChecked[1] = !_isChecked[1];
                  _canReport = checkCanReport();
                });
              },
              child: Row(
                children: [
                  Checkbox(
                    value: _isChecked[1],
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked[1] = value!;
                        _canReport = checkCanReport();
                      });
                    },
                  ),
                  textFormat(
                      text: "위치가 정확하지 않아요",
                      fontSize: 18,
                      fontWeight: FontWeight.w600)
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isChecked[1] = !_isChecked[1];
                  _canReport = checkCanReport();
                });
              },
              child: Row(
                children: [
                  Checkbox(
                    value: _isChecked[1],
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked[1] = value!;
                        _canReport = checkCanReport();
                      });
                    },
                  ),
                  textFormat(
                      text: "부적절한 단어가 포함되어 있어요",
                      fontSize: 18,
                      fontWeight: FontWeight.w600)
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isChecked[1] = !_isChecked[1];
                  _canReport = checkCanReport();
                });
              },
              child: Row(
                children: [
                  Checkbox(
                    value: _isChecked[1],
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked[1] = value!;
                        _canReport = checkCanReport();
                      });
                    },
                  ),
                  textFormat(
                      text: "부적절한 사진이 포함되어 있어요",
                      fontSize: 18,
                      fontWeight: FontWeight.w600)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                  maxLines: 3,
                  onChanged: (value) {
                    setState(() {
                      _etc = value;
                      _canReport = checkCanReport();
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "기타 제안사항을 입력해주세요",
                    border: OutlineInputBorder(),
                  )),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                onTap: () async {},
                child: Ink(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: _canReport
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSecondaryContainer,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: textFormat(
                      text: '수정 제안',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool checkCanReport() {
    if (_isChecked[0] || _isChecked[1]) {
      return true;
    }
    if (_etc != "") {
      return true;
    }
    return false;
  }
}

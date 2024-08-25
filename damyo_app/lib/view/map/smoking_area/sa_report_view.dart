import 'package:damyo_app/models/smoking_area/sa_report_model.dart';
import 'package:damyo_app/services/smoking_area_service.dart';
import 'package:damyo_app/style.dart';
import 'package:damyo_app/utils/re_login_dialog.dart';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';
import 'package:damyo_app/widgets/map/smoking_area/sa_report_widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SaReportView extends StatefulWidget {
  final String areaId;
  final String name;
  const SaReportView({super.key, required this.areaId, required this.name});

  @override
  State<SaReportView> createState() => _SaReportViewState();
}

class _SaReportViewState extends State<SaReportView> {
  late TokenViewModel _tokenViewModel;

  String get _areaId => widget.areaId;
  String get _name => widget.name;
  final List<bool> _isChecked = [false, false, false, false, false];
  String? _etc;
  bool _canReport = false;

  @override
  Widget build(BuildContext context) {
    _tokenViewModel = Provider.of<TokenViewModel>(context);
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
                  _isChecked[2] = !_isChecked[2];
                  _canReport = checkCanReport();
                });
              },
              child: Row(
                children: [
                  Checkbox(
                    value: _isChecked[2],
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked[2] = value!;
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
                  _isChecked[3] = !_isChecked[3];
                  _canReport = checkCanReport();
                });
              },
              child: Row(
                children: [
                  Checkbox(
                    value: _isChecked[3],
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked[3] = value!;
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
                  _isChecked[4] = !_isChecked[4];
                  _canReport = checkCanReport();
                });
              },
              child: Row(
                children: [
                  Checkbox(
                    value: _isChecked[4],
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked[4] = value!;
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
                onTap: () async {
                  SaReportModel saReportModel = SaReportModel(
                    notExist: _isChecked[0],
                    incorrectTag: _isChecked[1],
                    incorrectLocation: _isChecked[2],
                    inappropriateWord: _isChecked[3],
                    inappropriatePicture: _isChecked[4],
                    otherSuggestions: _etc,
                  );
                  String response = await SmokingAreaService.reportSmokingArea(
                      saReportModel, _areaId, _tokenViewModel);
                  if (response == "success") {
                    Fluttertoast.showToast(msg: "수정 제안이 완료되었습니다");
                    Navigator.pop(context);
                  } else if (response == "re_login") {
                    reLogin(context);
                  } else if (response == "already_reported") {
                    Fluttertoast.showToast(msg: "이미 수정 제안한 흡연구역입니다");
                  }
                },
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
    for (int i = 0; i < _isChecked.length; i++) {
      if (_isChecked[i]) {
        return true;
      }
    }
    if (_etc != "" && _etc != null) {
      return true;
    }
    return false;
  }
}

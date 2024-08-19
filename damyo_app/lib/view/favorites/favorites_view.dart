import 'package:damyo_app/models/smoking_area/sa_basic_model.dart';
import 'package:damyo_app/services/favorites_service.dart';
import 'package:damyo_app/services/smoking_area_service.dart';
import 'package:damyo_app/style.dart';
import 'package:damyo_app/view_models/bottom_navigation_model.dart';
import 'package:damyo_app/view_models/map_models/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoritesView> {
  late MapViewModel _mapViewModel;
  late BottomNavigationModel _bottomNavigationModel;
  bool removeGroup = false;

  @override
  Widget build(BuildContext context) {
    _mapViewModel = Provider.of<MapViewModel>(context);
    _bottomNavigationModel = Provider.of<BottomNavigationModel>(context);
    return Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: appbarTitleFormat(text: "즐겨찾기"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  removeGroup = !removeGroup;
                });
              },
              icon: const Icon(Icons.delete),
            )
          ],
        ),
        body: Column(
          children: [
            // Container(
            //   alignment: Alignment.centerRight,
            //   color: Colors.white,
            //   child: InkWell(
            //     onTap: () {},
            //     child: Padding(
            //       padding: const EdgeInsets.only(right: 16.0, bottom: 16),
            //       child: Container(
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(15),
            //             border: Border.all(
            //               color: const Color(0xFFEEF1F5),
            //             )),
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 20, vertical: 10),
            //         child: const Text(
            //           "삭제",
            //           style: TextStyle(
            //             fontSize: 14,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    for (int i = 0; i < _mapViewModel.favoritesList.length; i++)
                      _buildExpansionTile(index: i),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildExpansionTile({required int index}) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Material(
              type: MaterialType.transparency,
              child: Theme(
                data: ThemeData(),
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  trailing: removeGroup
                      ? GestureDetector(
                          onTap: () {
                            _showDeleteGroupDialog(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            child: const Text(
                              "삭제",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFBC6065),
                                  fontSize: 16),
                            ),
                          ),
                        )
                      : null,
                  title: Row(
                    children: [
                      Text(
                        _mapViewModel.favoritesList[index][0],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        ' ${_mapViewModel.favoritesList[index][1].length}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color(0xFF6F767F),
                        ),
                      )
                    ],
                  ),
                  children: [
                    for (int j = 0;
                        j < _mapViewModel.favoritesList[index][2].length;
                        j++)
                      InkWell(
                        onTap: () async {
                          // Todo: 지도 이동 및 즐겨찾기 장소 보여줌
                          SaBasicModel sa = await SmokingAreaService
                              .serachSmokingAreaByAreaId(
                                  _mapViewModel.favoritesList[index][1][j]);
                          _mapViewModel.tapFavoritesSa(sa);

                          _bottomNavigationModel.setCurPage(0);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 3),
                          child: Row(
                            children: [
                              Expanded(
                                child: textFormat(
                                    text: _mapViewModel.favoritesList[index][2]
                                        [j],
                                    fontSize: 15),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.star,
                                  color: Color(0xFFFFC226),
                                ),
                                onPressed: () {
                                  _showDeleteFavoriteDialog(index, j);
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _showDeleteGroupDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "정말 삭제하시겠습니까?",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                if (index == 0) {
                  Fluttertoast.showToast(msg: "기본 그룹은 삭제할 수 없습니다");
                } else {
                  _mapViewModel.removeFavoritesList(index);
                  FavoritesService.updateFavorites(_mapViewModel.favoritesList);
                }
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteFavoriteDialog(int index1, int index2) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "정말 삭제하시겠습니까?",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                _mapViewModel.removeFavoritesElement(index1, index2);
                FavoritesService.updateFavorites(_mapViewModel.favoritesList);

                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}

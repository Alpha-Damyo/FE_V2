import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class SaGalleryScreen extends StatelessWidget {
  SaGalleryScreen({
    super.key,
    required this.photoUrlList,
    required this.photoIndex,
  }) : pageController = PageController(initialPage: photoIndex);

  final List<dynamic> photoUrlList;
  final int photoIndex;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            itemCount: photoUrlList.length,
            pageController: PageController(initialPage: photoIndex),
            loadingBuilder: (context, event) => Center(
                  child: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              event.expectedTotalBytes!,
                    ),
                  ),
                ),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(photoUrlList[index]["pictureUrl"]),
              );
            }),
      ),
    );
  }
}

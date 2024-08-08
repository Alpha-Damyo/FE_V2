import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class SaIamgeScreen extends StatelessWidget {
  const SaIamgeScreen(this.photoPath, {super.key});
  final String? photoPath;

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider =
        const AssetImage('assets/images/smoking_area_default_img.png');
    if (photoPath != null) {
      imageProvider = NetworkImage(photoPath!);
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: PhotoView(
          imageProvider: imageProvider,
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2.0,
          enableRotation: false,
        ),
      ),
    );
  }
}

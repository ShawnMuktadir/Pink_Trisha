import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';

import '../../utils/enum.dart';

class GlobalImageLoader extends StatelessWidget {
  const GlobalImageLoader({
    Key? key,
    required this.imagePath,
    this.imageFor = ImageFor.asset,
    this.height,
    this.width,
    this.fit,
  }) : super(key: key);
  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final ImageFor imageFor;

  @override
  Widget build(BuildContext context) {
    if (imageFor == ImageFor.network) {
      return Image.network(
        imagePath,
        height: height,
        width: width,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            height: height,
            width: width,
            child: Icon(
              size: height,
              Icons.image,
              color: Colors.grey.withOpacity(.2),
            ),
          );
        },
        errorBuilder: (context, exception, stackTrace) => GlobalImageLoader(
            height: height,
            width: width,
            imagePath: KAssetName.icEmptyImage2png.imagePath),
      );
    } else {
      return Image.asset(
        imagePath,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (context, exception, stackTrace) => const Text('😢'),
      );
    }
  }
}

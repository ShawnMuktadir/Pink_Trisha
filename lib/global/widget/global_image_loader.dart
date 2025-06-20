import 'package:flutter/material.dart';

import '../../utils/enum.dart';

class GlobalImageLoader extends StatelessWidget {
  const GlobalImageLoader({
    super.key,
    required this.imagePath,
    this.imageFor = ImageFor.asset,
    this.height,
    this.width,
    this.fit,
  });

  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final ImageFor imageFor;

  @override
  Widget build(BuildContext context) {
    if (imageFor == ImageFor.network) {
      print("Loading image from: $imagePath");
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
            child: const Center(child: CircularProgressIndicator()),
          );
        },
        errorBuilder: (context, exception, stackTrace) {
          return SizedBox(
            height: height,
            width: width,
            child: const Center(child: Icon(Icons.broken_image)),
          );
        },
      );
    } else {
      return Image.asset(
        imagePath,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (context, exception, stackTrace) => SizedBox(
          height: height,
          width: width,
          child: const Center(child: Icon(Icons.broken_image)),
        ),
      );
    }
  }
}

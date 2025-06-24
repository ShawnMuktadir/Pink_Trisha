import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
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
      if (kDebugMode) {
        print("Loading image from network: $imagePath");
      }
      return CachedNetworkImage(
        imageUrl: imagePath,
        height: height,
        width: width,
        fit: fit,
        placeholder: (context, url) => SizedBox(
          height: height,
          width: width,
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
        errorWidget: (context, url, error) => SizedBox(
          height: height,
          width: width,
          child: const Center(child: Icon(Icons.broken_image)),
        ),
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

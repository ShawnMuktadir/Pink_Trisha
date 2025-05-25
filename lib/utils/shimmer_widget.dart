import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 20, width: 150, color: Colors.white),
            const SizedBox(height: 12),
            Container(height: 20, width: 150, color: Colors.white),
            const SizedBox(height: 12),
            Container(height: 20, width: 200, color: Colors.white),
            const SizedBox(height: 12),
            Container(height: 20, width: 250, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

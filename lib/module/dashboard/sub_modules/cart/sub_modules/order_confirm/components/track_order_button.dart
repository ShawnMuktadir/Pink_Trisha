import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';

import '../../../../../../../global/widget/global_text.dart';
import '../../../../../../../utils/styles/k_colors.dart';

class TrackOrderButton extends StatelessWidget {
  const TrackOrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      // height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.32, -0.95),
          end: const Alignment(-0.32, 0.95),
          colors: [
            KColor.homeGradientStart.color,
            KColor.homeGradientEnd.color
          ],
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: KColor.deepPrimary.color),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GlobalText(
            str: 'Track Your Order',
            textAlign: TextAlign.center,
            color: KColor.deep3.color,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 0.10,
          ),
        ],
      ),
    );
  }
}

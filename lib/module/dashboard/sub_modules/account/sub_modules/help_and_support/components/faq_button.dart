import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class FAQButton extends StatelessWidget {
  const  FAQButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 156,
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
            str: 'FAQ',
            textAlign: TextAlign.center,
            color: KColor.deep4.color,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 0.08,
          ),
        ],
      ),
    );
  }
}

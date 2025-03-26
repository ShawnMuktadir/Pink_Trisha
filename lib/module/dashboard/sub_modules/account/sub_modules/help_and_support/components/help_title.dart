import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class HelpTitle extends StatelessWidget {
  const HelpTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalText(
      str:
          'We‘re here to help you with anything and everything on Gorillamove.',
      color: KColor.deep4.color,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 0.09,
    );
  }
}

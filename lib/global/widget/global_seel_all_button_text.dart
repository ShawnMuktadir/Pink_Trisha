import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class GlobalSeeAllTextButton extends StatelessWidget {
  final VoidCallback onTap;

  const GlobalSeeAllTextButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: GlobalText(
        str: "See All",
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: KColor.primary.color,
        height: 0.11,
      ),
    );
  }
}

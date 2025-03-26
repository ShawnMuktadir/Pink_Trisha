import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class FilterTitle extends StatelessWidget {
  const FilterTitle({
    required this.title,
    super.key,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlobalText(
        str: title,
        color: KColor.deep4.color,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 0.10,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/utils/styles/styles.dart';

class SearchForTitle extends StatelessWidget {
  const SearchForTitle({super.key, required this.slug});
  final String slug;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, top: 10),
      alignment: Alignment.centerLeft,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Search results showing for “',
              style: KTextStyle.customTextStyle(
                color: KColor.deep3.color,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 0.09,
              ),
            ),
            TextSpan(
              text: slug,
              style: KTextStyle.customTextStyle(
                color: KColor.deep3.color,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 0.09,
              ),
            ),
            TextSpan(
              text: '”',
              style: KTextStyle.customTextStyle(
                color: KColor.deep3.color,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 0.09,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

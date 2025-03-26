import 'package:flutter/widgets.dart';
import 'package:pink_by_trisha_app/utils/styles/styles.dart';

class SupportDetails extends StatelessWidget {
  const SupportDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'At ',
            style: KTextStyle.customTextStyle(
              color: KColor.deep3.color,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 0.10,
            ),
          ),
          TextSpan(
            text: 'Pink By Trisha',
            style: KTextStyle.customTextStyle(
              color: KColor.deepPrimary.color,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 0.10,
            ),
          ),
          TextSpan(
            text:
                ' everything we expect at a day’s start is you, better and happier than yesterday. We have got you covered. Share your concern or check ',
            style: KTextStyle.customTextStyle(
              color: KColor.deep3.color,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 0.10,
            ),
          ),
          TextSpan(
            text: 'frequently asked questions link',
            style: KTextStyle.customTextStyle(
              color: KColor.deep3.color,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
              height: 0.10,
            ),
          ),
          TextSpan(
            text: '.',
            style: KTextStyle.customTextStyle(
              color: KColor.deep3.color,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 0.10,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.justify,
    );
  }
}

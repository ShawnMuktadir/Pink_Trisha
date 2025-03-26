import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_container.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';
import 'package:pink_by_trisha_app/utils/styles/k_text_style.dart';

class DeliveryDate extends StatelessWidget {
  const DeliveryDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GlobalContainer(
          height: 40,
          padding: const EdgeInsets.all(0),
          borderRadius: 8,
          backgroundColor: KColor.background3.color,
          child: Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Estimated Delivery Date',
                    style: KTextStyle.customTextStyle(
                      color: KColor.deep4.color,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 0.10,
                    ),
                  ),
                  TextSpan(
                    text: ' ',
                    style: KTextStyle.customTextStyle(
                      color: KColor.deepPrimary.color,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 0.10,
                    ),
                  ),
                  TextSpan(
                    text: '4th Decmber',
                    style: KTextStyle.customTextStyle(
                      color: KColor.deepPrimary.color,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 0.10,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}

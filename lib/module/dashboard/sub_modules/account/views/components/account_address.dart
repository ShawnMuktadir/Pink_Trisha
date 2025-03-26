import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class AccountAddress extends StatelessWidget {
  const AccountAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalText(
      str: "Dhaka\nBangladesh -1216",
      color: KColor.deepGrey.color,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 0.09,
    );
  }
}

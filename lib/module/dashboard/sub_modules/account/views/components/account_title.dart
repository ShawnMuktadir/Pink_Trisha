import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class AccountTitle extends StatelessWidget {
  const AccountTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalText(
      str: 'Account',
      color: KColor.deep2.color,
      fontSize: 24,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      height: 0.06,
    );
  }
}

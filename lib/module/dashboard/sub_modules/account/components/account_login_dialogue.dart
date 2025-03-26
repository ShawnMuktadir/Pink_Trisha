import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';

import '../../../../../../../utils/app_routes.dart';
import '../../../../../../../utils/navigation.dart';

class AccountLoginDialogue extends StatelessWidget {
  final String? title;
  const AccountLoginDialogue({
    super.key,
    this.title,
    /*required this.cartProduct*/
  });
  /*final CartProduct cartProduct;*/
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalText(
            str: title ??
                'If you want to see your account information please login first',
            color: Color(0xFF666465),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 0.10,
          ),
          const VerticalSpace(
            height: 24,
          ),
          GlobalButton(
              onPressed: () {
                Navigation.push(context,
                    appRoutes: AppRoutes.signIn, arguments: true);
                // controller.addToCartFromDetails(
                //     cartProduct: cartProduct, context: context);
              },
              buttonText: "Login Now")
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/controller/cart_controller.dart';

import '../../../../../../../global/widget/global_text.dart';
import '../../../../../../../utils/styles/k_colors.dart';

class CheckBillingAddress extends StatelessWidget {
  const CheckBillingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller = ref.read(cartController.notifier);
        final state = ref.watch(cartController);
        return Padding(
          padding: EdgeInsets.all(24.0),
          child: Row(
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Checkbox(
                  value: state.isSameBillingAndShipping,
                  activeColor: KColor.deepPrimary.color, // Color when checked
                  checkColor: Colors.white, // Checkmark color
                  fillColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return KColor.deepPrimary.color; // Background when checked
                      }
                      return Colors.white10; // Background when unchecked
                    },
                  ),
                  onChanged: (value) {
                    controller.setSameShippingAndBilling(value ?? false);
                  },
                ),
              ),
              const HorizontalSpace(
                width: 8,
              ),
              Expanded(
                child: GlobalText(
                  str: "Billing address is similar as shipping address",
                  color: KColor.deep2.color,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 0.11,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

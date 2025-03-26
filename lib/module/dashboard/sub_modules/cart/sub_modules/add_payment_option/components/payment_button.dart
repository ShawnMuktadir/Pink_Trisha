import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/controller/cart_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/model/payment_type.dart';

import '../../../../../../../constant/constant_key.dart';
import '../../../../../../../data_provider/pref_helper.dart';
import '../../../../../../../utils/styles/k_colors.dart';

class PaymentButtonScreen extends ConsumerWidget {
  final bool isSelected;
  final String iconName;
  final String title;
  final VoidCallback onTap;

  const PaymentButtonScreen({
    required this.isSelected,
    required this.iconName,
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(cartController.notifier);
    final state = ref.watch(cartController);

    final bool hasDVP = state.cartProducts.any(
        (item) => item.paymentType == "DVP"); // Check if any item requires DVP
    final bool allCOD = state.cartProducts.every(
        (item) => item.paymentType == "COD"); // Check if all items are COD

// If there's a DVP item, force the switch ON (user cannot change it).
// If all items are COD, allow the user to toggle the switch.
    bool isPayOnline = hasDVP || state.paymentType.name == "DVP";

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                iconName.isNotEmpty
                    ? Image.asset(iconName, width: 24, height: 24,
                        errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.payment,
                            size: 24, color: Colors.grey);
                      })
                    : const Icon(Icons.payment, size: 24, color: Colors.grey),
                const SizedBox(width: 12),
                Text(title, style: const TextStyle(fontSize: 16)),
              ],
            ),
            if (title == "Pay Online")
              Switch(
                value: isPayOnline,
                // Ensures switch is ON if any product requires DVP
                activeTrackColor: KColor.deepPrimary.color,
                // Track color when ON
                activeColor: KColor.background.color,
                // Thumb color when ON
                inactiveTrackColor: Colors.grey.shade50,
                // Track color when OFF
                inactiveThumbColor: hasDVP ? Colors.white38 : Colors.grey,
                // Thumb color when OFF
                onChanged: (value) async {
                  if (hasDVP && !value) {
                    // Show message if user tries to turn off online payment
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Online payment is required for items in your cart."),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return; // Prevent the switch from turning OFF
                  }

                  final newPaymentType = value
                      ? PaymentType(title: "Pay Online", name: "DVP", index: 0)
                      : PaymentType(title: "Cash on Delivery", name: "COD", index: 1);

                  // Save to SharedPreferences using PrefHelper
                  await PrefHelper.setBool(AppConstant.IS_SWITCHED.key, value);

                  // Update state
                  controller.setPaymentTypeIndex(newPaymentType);




                  /*// Allow switching when online payment is not mandatory
                  controller.setPaymentTypeIndex(
                    value
                        ? PaymentType(
                            title: "Pay Online", name: "DVP", index: 0)
                        : PaymentType(
                            title: "Cash on Delivery", name: "COD", index: 1),
                  );*/
                },
              ),
          ],
        ),
      ),
    );
  }
}

/*class PaymentButtonScreen extends StatefulWidget {
  const PaymentButtonScreen(
      {super.key,
      this.isSelected = false,
      this.iconName,
      this.title,
      this.onTap});

  final bool isSelected;
  final String? iconName;
  final String? title;
  final void Function()? onTap;

  @override
  State<PaymentButtonScreen> createState() => _PaymentButtonScreenState();
}

class _PaymentButtonScreenState extends State<PaymentButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () => widget.onTap!(),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 48.h,
            width: context.width,
            padding: const EdgeInsets.symmetric(horizontal: 21),
            decoration: BoxDecoration(
              color: KColor.white.color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: widget.isSelected
                      ? KColor.deepPrimary.color
                      : Colors.transparent,
                  width: .5.w),
            ),
            child: Row(
              children: [
                widget.iconName != null
                    ? GlobalImageLoader(
                        imagePath: widget.iconName!,
                        width: 79,
                        height: 35.59,
                      )
                    : GlobalText(
                        str: "${widget.title}",
                        color: KColor.deep2.color,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/

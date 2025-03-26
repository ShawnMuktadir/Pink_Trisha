import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_container.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/controller/all_address/all_address_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/controller/cart_controller.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class ShippingHomeAddress extends ConsumerWidget {
  const ShippingHomeAddress({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(cartController.notifier);
    final state = ref.watch(allAddressController);
    return Padding(
        padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
        child: state.addressList.isNotEmpty
            ? Column(
                children: [
                  ...state.addressList
                      .map((address) => GlobalContainer(
                          onTap: () {
                            controller.setShippingAddress(
                                addressData: address, context: context);
                          },
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 16, left: 20, right: 17),
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GlobalText(
                                str: "${address.area}",
                                color: KColor.deep2.color,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 0.09,
                              ),
                              const VerticalSpace(
                                height: 4,
                              ),
                              GlobalText(
                                str:
                                    "House No-${address.house}, Road No-${address.addressLine}, ${address.area}, ${address.city}-${address.postCode}, ${address.country}",
                                color: KColor.deepGrey.color,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 0.09,
                              ),
                            ],
                          )))
                      .toList()
                ],
              )
            : const SizedBox.shrink());
  }
}

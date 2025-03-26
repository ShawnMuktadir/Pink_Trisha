import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_container.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/model/all_address_model.dart';
import 'package:pink_by_trisha_app/utils/styles/styles.dart';

class OrderShippingAddress extends StatelessWidget {
  const OrderShippingAddress({super.key, required this.shippingAddress});
  final AllAddressData shippingAddress;
  @override
  Widget build(BuildContext context) {
    final house = shippingAddress.house!.isNotEmpty
        ? "House No-${shippingAddress.house},"
        : "";
    final addressLine = "${shippingAddress.addressLine}, ";
    // final road = "Road No-${shippingAddress.addressLine}";
    return Padding(
      padding: const EdgeInsets.only(top: 24, right: 24, left: 24, bottom: 16),
      child: GlobalContainer(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          borderRadius: 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalText(
                str: 'Shipping Address',
                color: KColor.deep2.color,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 0.07,
              ),
              const SizedBox(height: 14),
              GlobalText(
                str:
                    "$house$addressLine${shippingAddress.area}, ${shippingAddress.city}-${shippingAddress.postCode}, ${shippingAddress.country}",
                color: KColor.deep4.color,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 0.10,
              ),
            ],
          )),
    );
  }
}
                  //  'Land View Commercial Center4th Floor, 28 Gulshan North C/A, Gulshan Circle-2, Dhaka-1212, Bangladesh',

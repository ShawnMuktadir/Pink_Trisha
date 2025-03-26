import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_container.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/controller/all_address/all_address_controller.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class HomeAddress extends ConsumerWidget {
  const HomeAddress({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final controller = ref.read(allAddressController.notifier);
    final state = ref.watch(allAddressController);
    return state.addressList.isNotEmpty
        ? ListView.builder(
            itemCount: state.addressList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              return GlobalContainer(
                  width: double.infinity,
                  onTap: () {
                    Navigation.push(context,
                        appRoutes: AppRoutes.updateAddress,
                        arguments: state.addressList[index]);
                  },
                  padding: const EdgeInsets.only(
                      top: 16, bottom: 16, left: 20, right: 17),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlobalText(
                        str: "${state.addressList[index].area}",
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
                            "House No-${state.addressList[index].house}, Road No-${state.addressList[index].addressLine}, ${state.addressList[index].area}, ${state.addressList[index].city}-${state.addressList[index].postCode}, ${state.addressList[index].country}",
                        color: KColor.deepGrey.color,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 0.09,
                      ),
                    ],
                  ));
            })
        : SizedBox(
            child: Text('No Address Found'),
          );
  }
}

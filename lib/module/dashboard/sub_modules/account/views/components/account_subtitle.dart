import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/controller/add_address/add_address_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/profile/controller/profile_controller.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';
import 'package:pink_by_trisha_app/utils/styles/k_text_style.dart';

class AccountSubtitle extends ConsumerWidget {
  const AccountSubtitle({super.key, this.hasAddress = true});
  final bool hasAddress;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileController);
    final addressState = ref.watch(addAddressController);
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text:
                '${state.fetchProfile?.firstName ?? ""} ${state.fetchProfile?.lastName ?? ""},',
            style: KTextStyle.customTextStyle(
              height: 0.09,
              color: KColor.deep2.color,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: ' ',
            style: KTextStyle.customTextStyle(
              height: 0.09,
              color: KColor.deepGrey.color,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          hasAddress
              ? TextSpan(
                  text: '${state.fetchProfile?.email ?? ""}.',
                  style: KTextStyle.customTextStyle(
                    height: 0.09,
                    color: KColor.deepGrey.color,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              : TextSpan(
                  text: state.fetchProfile?.email ?? "",
                  style: KTextStyle.customTextStyle(
                    height: 0.09,
                    color: KColor.deepGrey.color,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
        ],
      ),
      softWrap: true,
    );
  }
}

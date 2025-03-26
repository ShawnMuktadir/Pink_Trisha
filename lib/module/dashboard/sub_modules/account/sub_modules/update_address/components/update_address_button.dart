import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_button.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/controller/update_address/update_address_controller.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';

import '../../address/controller/add_address/add_address_controller.dart';

class UpdateAddressButton extends ConsumerWidget {
  const UpdateAddressButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(updateAddressController.notifier);
    final state = ref.watch(updateAddressController);
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: GlobalButton(
        isLoading: state.isUpdateBtnLoading,
        onPressed: () async{
          await controller.reqUpdateAddress(context);
          // Navigation.pop(context);
        },
        buttonText: "Update",
      ),
    );
  }
}

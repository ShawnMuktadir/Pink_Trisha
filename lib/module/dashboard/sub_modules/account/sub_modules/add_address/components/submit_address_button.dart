import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_button.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';

import '../../address/controller/add_address/add_address_controller.dart';

class SubmitAddressButton extends ConsumerWidget {
  const SubmitAddressButton({required this.fromCart, super.key});
  final bool fromCart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(addAddressController.notifier);
    final state = ref.watch(addAddressController);
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: GlobalButton(
        isLoading: state.isCreateButtonLoading,
        onPressed: () {
          controller.reqAddAddres(context: context, fromCart: fromCart);
          // Navigation.pop(context);
        },
        buttonText: "Submit",
      ),
    );
  }
}

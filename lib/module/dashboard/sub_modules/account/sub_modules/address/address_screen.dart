import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_back_button.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/components/home_address.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/components/new_address_button.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

import 'controller/all_address/all_address_controller.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    super.initState();
    final controller = context.read(allAddressController.notifier);
    Future(() async {
      await controller.getAllAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: context.width,
          constraints: BoxConstraints(
            minHeight: context.height,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                KColor.homeGradientStart.color,
                KColor.homeGradientEnd.color,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalBackButton(
                title: "My Address",
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                  child: HomeAddress(),
                ),
              ),
              NewAddressButton()
            ],
          ),
        ),
      ),
    );
  }
}

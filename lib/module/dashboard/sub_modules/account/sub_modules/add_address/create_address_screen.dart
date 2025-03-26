import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_back_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_primary_dropdown.dart';
import 'package:pink_by_trisha_app/global/widget/global_primary_textformfield.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/add_address/components/city_dropdown.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/add_address/components/submit_address_button.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/controller/add_address/add_address_controller.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class CreateAddressScreen extends ConsumerWidget {
  const CreateAddressScreen(this.fromCart, {Key? key}) : super(key: key);
  final bool fromCart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addAddressController);
    final controller = ref.read(addAddressController.notifier);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
          child: SafeArea(
            child: Column(
              children: [
                const GlobalBackButton(title: "Add Address"),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            GlobalPrimaryTextFormField(
                                controller: state.houseCon,
                                title: "House No",
                                hint: "12",
                                textInputType: TextInputType.number),
                            const VerticalSpace(),
                            GlobalPrimaryTextFormField(
                                controller: state.addressLineCon,
                                title: "Road No",
                                hint: "02",
                                textInputType: TextInputType.number),
                            const VerticalSpace(),
                            GlobalPrimaryTextFormField(
                                controller: state.areaCon,
                                title: "Town/Area",
                                hint: "Write",
                                textInputType: TextInputType.text),
                            const VerticalSpace(),
                            // CityDropdown(),
                            // GlobalPrimaryTextFormField(
                            //     controller: state.cityCon,
                            //     title: "City",
                            //     hint: "Write",
                            //     textInputType: TextInputType.text),
                            CityDropdown(),
                            const VerticalSpace(),
                            GlobalPrimaryTextFormField(
                                controller: state.postCodeCon,
                                title: "Postal Code",
                                hint: "10",
                                textInputType: TextInputType.number),
                            const VerticalSpace(),
                            GlobalPrimaryTextFormField(
                                controller: state.countryCon,
                                title: "Country",
                                hint: "Write",
                                textInputType: TextInputType.text),
                            // GlobalPrimaryDropdown(title: "Country"),
                            SubmitAddressButton(
                              fromCart: fromCart,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

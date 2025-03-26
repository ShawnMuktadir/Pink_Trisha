import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_back_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_primary_textformfield.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/controller/update_address/update_address_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/model/all_address_model.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/update_address/components/update_address_button.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class UpdateAddressScreen extends StatefulWidget {
  const UpdateAddressScreen(this.allAddressModel, {Key? key}) : super(key: key);
  final AllAddressData allAddressModel;

  @override
  State<UpdateAddressScreen> createState() => _UpdateAddressScreenState();
}

class _UpdateAddressScreenState extends State<UpdateAddressScreen> {
  @override
  void initState() {
    super.initState();
    final controller = context.read(updateAddressController.notifier);
    Future(() {
      controller.setAddressData(widget.allAddressModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, widget) {
      final state = ref.watch(updateAddressController);
      final controller = ref.read(updateAddressController.notifier);

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
                  const GlobalBackButton(title: "Update Address"),
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
                              GlobalPrimaryTextFormField(
                                  controller: state.cityCon,
                                  title: "City",
                                  hint: "Write",
                                  textInputType: TextInputType.text),
                              // GlobalPrimaryDropdown(title: "City"),
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
                              const UpdateAddressButton(),
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
    });
  }
}

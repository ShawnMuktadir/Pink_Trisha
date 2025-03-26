import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/controller/add_address/add_address_state.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/model/add_address_model.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/model/add_address_response.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/model/district_list.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/network_connection.dart';

import '../../../../../../../../constant/app_url.dart';
import '../../../../../../../../data_provider/api_client.dart';
import '../../../../../../../../utils/navigation.dart';
import '../all_address/all_address_controller.dart';

final addAddressController =
    StateNotifierProvider.autoDispose<AddAddressController, AddAddressState>(
        (ref) => AddAddressController());

class AddAddressController extends StateNotifier<AddAddressState> {
  AddAddressController()
      : super(AddAddressState(
            addressCon: TextEditingController(text: 'test'),
            apartmentCon: TextEditingController(text: ' '),
            houseCon: TextEditingController(),
            streetCon: TextEditingController(text: ' '),
            addressLineCon: TextEditingController(),
            areaCon: TextEditingController(),
            postCodeCon: TextEditingController(),
            stateCon: TextEditingController(text: 'state'),
            countryCon: TextEditingController(),
            countryISOCodeCon: TextEditingController(text: 'countryISOCode'),
            typeCon: TextEditingController(text: "BILLING"),
            selectedCity: null,
            isButtonEnabled: false,
            isCreateButtonLoading: false)) {
    state.addressCon.addListener(() {
      checkButtonStatus();
    });
    state.apartmentCon.addListener(() {
      checkButtonStatus();
    });
    state.houseCon.addListener(() {
      checkButtonStatus();
    });
    state.streetCon.addListener(() {
      checkButtonStatus();
    });
    state.addressLineCon.addListener(() {
      checkButtonStatus();
    });
    state.areaCon.addListener(() {
      checkButtonStatus();
    });
    state.postCodeCon.addListener(() {
      checkButtonStatus();
    });
    state.stateCon.addListener(() {
      checkButtonStatus();
    });
    state.countryCon.addListener(() {
      checkButtonStatus();
    });
    state.countryISOCodeCon.addListener(() {
      checkButtonStatus();
    });
    state.typeCon.addListener(() {
      checkButtonStatus();
    });
    // state.cityCon.addListener(() {
    //   checkButtonStatus();
    // });
  }

  checkButtonStatus() {
    final String addressCon = state.addressCon.text.trim();
    final String apartmentCon = state.apartmentCon.text.trim();
    final String houseCon = state.houseCon.text.trim();
    final String streetCon = state.streetCon.text.trim();
    final String addressLineCon = state.addressLineCon.text.trim();
    final String areaCon = state.areaCon.text.trim();
    final String postCodeCon = state.postCodeCon.text.trim();
    final String stateCon = state.stateCon.text.trim();
    final String countryCon = state.countryCon.text.trim();
    final String countryISOCodeCon = state.countryISOCodeCon.text.trim();
    final String typeCon = state.typeCon.text.trim();

    if (addressCon.isNotEmpty &&
        apartmentCon.isNotEmpty &&
        houseCon.isNotEmpty &&
        streetCon.isNotEmpty &&
        addressLineCon.isNotEmpty &&
        areaCon.isNotEmpty &&
        postCodeCon.isNotEmpty &&
        stateCon.isNotEmpty &&
        countryCon.isNotEmpty &&
        countryISOCodeCon.isNotEmpty &&
        typeCon.isNotEmpty) {
      state = state.copyWith(isButtonEnabled: true);
    } else {
      state = state.copyWith(isButtonEnabled: false);
    }
  }

  /// ==@ Function
  final ApiClient _apiClint = ApiClient();
  final formKey = GlobalKey<FormState>();
  void onCityChanged(DistrictModel districtModel) {
    state = state.copyWith(selectedCity: districtModel);
  }

  Future<void> reqAddAddres(
      {required BuildContext context, required bool fromCart}) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    state = state.copyWith(isCreateButtonLoading: true);
    try {
      AddAddressSendData? addressResponse;
      addressResponse = AddAddressSendData(
        addressCon: state.addressCon.text.trim(),
        apartmentCon: state.apartmentCon.text.trim(),
        houseCon: state.houseCon.text.trim(),
        streetCon: state.streetCon.text.trim(),
        addressLineCon: state.addressLineCon.text.trim(),
        areaCon: state.areaCon.text.trim(),
        postCodeCon: state.postCodeCon.text.trim(),
        stateCon: state.stateCon.text.trim(),
        countryCon: state.countryCon.text.trim(),
        countryISOCodeCon: state.countryISOCodeCon.text.trim(),
        typeCon: state.typeCon.text.trim(),
        cityCon: state.selectedCity?.value ?? "",
      );
      log('Pass: ${addressResponse.toJson()}');
      await _apiClint.request(
          url: AppUrl.addAddressUrl.url,
          method: MethodType.POST,
          data: addressResponse.toJson(),
          onSuccessFunction: (response) {
            log('Response: ${jsonEncode(response.data)}');

            if (response.data != null) {
              'response is: ${jsonEncode(response.data)}'.log();
              final AddAddressModel addressModel =
                  AddAddressModel.fromJson(response.data);
              log('Model Response: ${addressModel.statusCode}');

              if (addressModel.statusCode == 200) {
                log("${addressModel.message}");
                final controller = context.read(allAddressController.notifier);
                Future(() async {
                  await controller.getAllAddress();
                });
                if (!fromCart) {
                  Navigation.pop(context);
                } else {
                  Navigation.pushReplacement(context,
                      appRoutes: AppRoutes.shippingAddress);
                }
                // ViewUtil.showAlertDialog(
                //   barrierDismissible: false,
                //     content:
                // );
              }
            }
          });
    } catch (e, s) {
      log("Log Error :-", error: e, stackTrace: s);
      // ViewUtil.showAlertDialog(
      //     barrierDismissible: false,
      //     content: ErrorWid
      // );
    }
    state = state.copyWith(isCreateButtonLoading: false);
  }
}

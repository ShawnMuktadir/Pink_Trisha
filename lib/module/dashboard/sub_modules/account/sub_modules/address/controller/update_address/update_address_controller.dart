import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/constant/constant_key.dart';
import 'package:pink_by_trisha_app/data_provider/pref_helper.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/controller/update_address/update_address_state.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/model/add_address_response.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/model/all_address_model.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/network_connection.dart';

import '../../../../../../../../constant/app_url.dart';
import '../../../../../../../../data_provider/api_client.dart';
import '../../../../../../../../utils/navigation.dart';
import '../all_address/all_address_controller.dart';

final updateAddressController = StateNotifierProvider.autoDispose<
    UpdateAddressController,
    UpdateAddressState>((ref) => UpdateAddressController());

class UpdateAddressController extends StateNotifier<UpdateAddressState> {
  UpdateAddressController()
      : super(UpdateAddressState(
          addressCon: TextEditingController(text: ''),
          apartmentCon: TextEditingController(text: ' '),
          houseCon: TextEditingController(),
          streetCon: TextEditingController(text: ' '),
          addressLineCon: TextEditingController(),
          areaCon: TextEditingController(),
          postCodeCon: TextEditingController(),
          stateCon: TextEditingController(text: ''),
          countryCon: TextEditingController(),
          countryISOCodeCon: TextEditingController(text: ''),
          typeCon: TextEditingController(text: ""),
          cityCon: TextEditingController(),
          isButtonEnabled: false,
          isUpdateBtnLoading: false,
          id: null,
        )) {
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
    state.cityCon.addListener(() {
      checkButtonStatus();
    });
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

  void setAddressData(AllAddressData addressData) {
    state = state.copyWith(id: addressData.id?.toString());
    print('addressData is: ${addressData.toJson()}');

    state.addressCon.text = addressData.address ?? "";
    state.apartmentCon.text = addressData.apartment ?? "";
    state.houseCon.text = addressData.house ?? "";
    state.streetCon.text = addressData.street ?? "";
    state.addressLineCon.text = addressData.addressLine ?? "";
    state.areaCon.text = addressData.area ?? "";
    state.postCodeCon.text = addressData.postCode ?? "";
    state.stateCon.text = addressData.state ?? "";
    state.countryCon.text = addressData.country ?? "";
    state.countryISOCodeCon.text = addressData.countryISOCode ?? "";
    state.typeCon.text = addressData.type ?? "";
    state.cityCon.text = addressData.city ?? "";
  }

  final formKey = GlobalKey<FormState>();

  Future<void> reqUpdateAddress(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    state = state.copyWith(isUpdateBtnLoading: true);
    try {
      AddAddressSendData? sendData;
      sendData = AddAddressSendData(
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
        cityCon: state.cityCon.text.trim(),
      );
      final token = PrefHelper.getString(AppConstant.TOKEN.key);
      final url = AppUrl.updateAddress.url.replaceFirst('{id}', state.id!);

      print('Send data is: ${sendData.toJson()}');
      await _apiClint.request(
          url: url,
          method: MethodType.PUT,
          token: token,
          data: sendData.toJson(),
          onSuccessFunction: (response) {
            log('Response: ${jsonEncode(response.data)}');

            if (response.data != null) {
              'response is: ${jsonEncode(response.data)}'.log();
              final controller = context.read(allAddressController.notifier);
              Future(() async {
                await controller.getAllAddress();
              });
              Navigation.pop(context);
            }
          });
    } catch (e, s) {
      log("Log Error :-", error: e, stackTrace: s);
    }
    state = state.copyWith(isUpdateBtnLoading: false);
  }
}

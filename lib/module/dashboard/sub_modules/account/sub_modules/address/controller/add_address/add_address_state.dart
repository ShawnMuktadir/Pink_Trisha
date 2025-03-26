import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/model/district_list.dart';

class AddAddressState {
  final TextEditingController addressCon;
  final TextEditingController apartmentCon;
  final TextEditingController houseCon;
  final TextEditingController streetCon;
  final TextEditingController addressLineCon;
  final TextEditingController areaCon;
  final TextEditingController postCodeCon;
  final TextEditingController stateCon;
  final TextEditingController countryCon;
  final TextEditingController countryISOCodeCon;
  final TextEditingController typeCon;
  final DistrictModel? selectedCity;
  final bool isButtonEnabled;
  final bool isCreateButtonLoading;

  // Constructor
  AddAddressState(
      {required this.addressCon,
      required this.apartmentCon,
      required this.houseCon,
      required this.streetCon,
      required this.addressLineCon,
      required this.areaCon,
      required this.postCodeCon,
      required this.stateCon,
      required this.countryCon,
      required this.countryISOCodeCon,
      required this.typeCon,
      required this.selectedCity,
      required this.isCreateButtonLoading,
      required this.isButtonEnabled});

  // CopyWith method
  AddAddressState copyWith({
    TextEditingController? addressCon,
    TextEditingController? apartmentCon,
    TextEditingController? houseCon,
    TextEditingController? streetCon,
    TextEditingController? addressLineCon,
    TextEditingController? areaCon,
    TextEditingController? postCodeCon,
    TextEditingController? stateCon,
    TextEditingController? countryCon,
    TextEditingController? countryISOCodeCon,
    TextEditingController? typeCon,
    DistrictModel? selectedCity,
    bool? isCreateButtonLoading,
    bool? isButtonEnabled,
  }) {
    return AddAddressState(
        addressCon: addressCon ?? this.addressCon,
        apartmentCon: apartmentCon ?? this.apartmentCon,
        houseCon: houseCon ?? this.houseCon,
        streetCon: streetCon ?? this.streetCon,
        addressLineCon: addressLineCon ?? this.addressLineCon,
        areaCon: areaCon ?? this.areaCon,
        postCodeCon: postCodeCon ?? this.postCodeCon,
        stateCon: stateCon ?? this.stateCon,
        countryCon: countryCon ?? this.countryCon,
        countryISOCodeCon: countryISOCodeCon ?? this.countryISOCodeCon,
        typeCon: typeCon ?? this.typeCon,
        selectedCity: selectedCity ?? this.selectedCity,
        isCreateButtonLoading:
            isCreateButtonLoading ?? this.isCreateButtonLoading,
        isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled);
  }
}

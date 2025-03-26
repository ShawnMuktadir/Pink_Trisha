import 'package:flutter/material.dart';

class UpdateAddressState {
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
  final TextEditingController cityCon;
  final bool isButtonEnabled;
  final bool isUpdateBtnLoading;
  final String? id;

  // Constructor
  UpdateAddressState({
    required this.id,
    required this.addressCon,
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
    required this.cityCon,
    required this.isButtonEnabled,
    required this.isUpdateBtnLoading
  });

  // CopyWith method
  UpdateAddressState copyWith({
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
    TextEditingController? cityCon,
    bool? isButtonEnabled,
    bool? isUpdateBtnLoading,
    String? id
  }) {
    return UpdateAddressState(
      addressCon: addressCon ?? this.addressCon,
      id: id ?? this.id,
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
      cityCon: cityCon ?? this.cityCon,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      isUpdateBtnLoading: isUpdateBtnLoading ?? this.isUpdateBtnLoading
    );
  }

}

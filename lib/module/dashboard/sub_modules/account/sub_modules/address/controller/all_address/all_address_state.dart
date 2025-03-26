import 'package:flutter/cupertino.dart';

import '../../model/all_address_model.dart';

@immutable
class AllAddressState {
  final List<AllAddressData> addressList;
  final bool isLoading;
  final bool isLoggedIn;

  const AllAddressState({
    required this.addressList,
    required this.isLoading,
    required this.isLoggedIn,
  });

  AllAddressState copyWith({
    List<AllAddressData>? addressList,
    bool? isLoggedIn,
    bool? isLoading,
  }) {
    return AllAddressState(
      addressList: addressList ?? this.addressList,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

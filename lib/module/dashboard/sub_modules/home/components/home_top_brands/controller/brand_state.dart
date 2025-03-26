import 'package:flutter/material.dart';

import '../model/brand_response.dart';

@immutable
class BrandState {
  final List<BrandData> topBrandsList;
  int selectIndex;
  final bool isLoading;
  final bool isLoggedIn;

  BrandState({
    required this.topBrandsList,
    required this.selectIndex,
    required this.isLoading,
    required this.isLoggedIn,
  });

  BrandState copyWith({
    List<BrandData>? topBrandsList,
    int? selectIndex,
    bool? isLoggedIn,
    bool? isLoading,
  }) {
    return BrandState(
      topBrandsList: topBrandsList ?? this.topBrandsList,
      selectIndex: selectIndex ?? this.selectIndex,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

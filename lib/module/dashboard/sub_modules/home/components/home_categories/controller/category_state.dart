import 'package:flutter/material.dart';

import '../model/category_response.dart';

@immutable
class CategoryState {
  final List<CategoryData> cateAllData;
  final int selectIndex;
  final bool isLoading;
  final bool isLoggedIn;

  const CategoryState({
    required this.cateAllData,
    required this.selectIndex,
    required this.isLoading,
    required this.isLoggedIn,
  });

  CategoryState copyWith({
    List<CategoryData>? cateAllData,
    int? selectIndex,
    bool? isLoggedIn,
    bool? isLoading,
  }) {
    return CategoryState(
      cateAllData: cateAllData ?? this.cateAllData,
      selectIndex: selectIndex ?? this.selectIndex,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/module/dashboard/model/bottomnav_widget_model.dart';

@immutable
class DashboardState {
  final int selectedIndex;
  final List<BottomNavWidgetModel> bottomNavItems;
  final int currentCarouselIndex;
  final int currentBestDealIndex;
  final int selectedProductIndex;

  const DashboardState({
    required this.selectedIndex,
    required this.bottomNavItems,
    required this.currentCarouselIndex,
    required this.currentBestDealIndex,
    required this.selectedProductIndex,
  });

  DashboardState copyWith({
    int? selectedIndex,
    int? currentCarouselIndex,
    int? currentBestDealIndex,
    int? selectedProductIndex,
    List<BottomNavWidgetModel>? bottomNavItems,
  }) =>
      DashboardState(
        selectedIndex: selectedIndex ?? this.selectedIndex,
        bottomNavItems: bottomNavItems ?? this.bottomNavItems,
        selectedProductIndex: selectedProductIndex ?? this.selectedProductIndex,
        currentBestDealIndex: currentBestDealIndex ?? this.currentBestDealIndex,
        currentCarouselIndex: currentCarouselIndex ?? this.currentCarouselIndex,
      );
}

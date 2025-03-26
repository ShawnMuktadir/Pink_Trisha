import 'package:flutter/cupertino.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/controller/wish_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/model/wish_list_response.dart';

@immutable
class WishState {
  final WishListResponse? wishlistResponse;
  final List<WishItem>? wishItems;
  final List<int> wishProductIds;
  final bool isLoading;
  final bool isReloading;
  final bool isWishDeleteLoading;
  final bool isWishCreateLoading;
  final LoaderScreenType loaderScreenType;

  const WishState({
    required this.wishlistResponse,
    required this.loaderScreenType,
    required this.wishItems,
    required this.wishProductIds,
    required this.isLoading,
    required this.isReloading,
    required this.isWishDeleteLoading,
    required this.isWishCreateLoading,
  });

  WishState copyWith(
      {List<WishItem>? wishItems,
      List<int>? wishProductIds,
      WishListResponse? wishlistResponse,
      bool? isLoading,
      bool? isReloading,
      bool? isWishCreateLoading,
      bool? isWishDeleteLoading,
      LoaderScreenType? loaderScreenType}) {
    return WishState(
        wishItems: wishItems ?? this.wishItems,
        wishProductIds: wishProductIds ?? this.wishProductIds,
        wishlistResponse: wishlistResponse ?? this.wishlistResponse,
        isLoading: isLoading ?? this.isLoading,
        isReloading: isReloading ?? this.isReloading,
        isWishCreateLoading: isWishCreateLoading ?? this.isWishCreateLoading,
        isWishDeleteLoading: isWishDeleteLoading ?? this.isWishDeleteLoading,
        loaderScreenType: loaderScreenType ?? this.loaderScreenType);
  }
}

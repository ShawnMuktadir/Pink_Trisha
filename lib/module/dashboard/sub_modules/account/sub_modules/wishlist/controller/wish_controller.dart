import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/constant/app_url.dart';
import 'package:pink_by_trisha_app/constant/constant_key.dart';
import 'package:pink_by_trisha_app/data_provider/api_client.dart';
import 'package:pink_by_trisha_app/data_provider/pref_helper.dart';
import 'package:pink_by_trisha_app/data_provider/storage_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/components/account_login_dialogue.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/controller/wish_state.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/model/wish_data.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/model/wish_list_response.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/network_connection.dart';
import 'package:pink_by_trisha_app/utils/view_util.dart';

final wishController =
    StateNotifierProvider<WishController, WishState>((ref) => WishController());

enum LoaderScreenType { home, productList, productDetails, none, wishList }

class WishController extends StateNotifier<WishState> {
  WishController()
      : super(const WishState(
            wishlistResponse: null,
            wishItems: null,
            wishProductIds: [],
            isLoading: true,
            isReloading: false,
            isWishDeleteLoading: false,
            isWishCreateLoading: false,
            loaderScreenType: LoaderScreenType.none));

  final ApiClient _apiClient = ApiClient();
  int page = 1, count = 10;

  Future<void> getWishList() async {
    state.wishlistResponse == null
        ? state = state.copyWith(isLoading: true)
        : state = state.copyWith(isReloading: true);

    final userId = PrefHelper.getString(AppConstant.USER_ID.key);
    final token = PrefHelper.getString(AppConstant.TOKEN.key);

    var url =
        AppUrl.wishList.url.replaceFirst('{customerId}', userId.toString());
    // .replaceFirst('{page}', page.toString())
    // .replaceFirst('{count}', count.toString());
    if (kDebugMode) {
      print('Token get :- $token');
    }
    await _apiClient
        .request(
      url: url,
      method: MethodType.GET,
      token: token,
      onSuccessFunction: (response) {
        print('res 1');
        final WishListResponse wishlistResponse =
            WishListResponse.fromJson(response.data);
        print('res 2');
        "response  data is ${response.data}".log();
        "response  error is :: ${response.data["error"]}".log();
        final List<int> wishProductIds = [];
        for (var item in wishlistResponse.data) {
          wishProductIds.add(item.product.id!);
        }
        state = state.copyWith(
            wishlistResponse: wishlistResponse,
            wishItems: wishlistResponse.data,
            wishProductIds: wishProductIds);
      },
    )
        .catchError((e) {
      print('res error');
      "error catch $e".log();
    });
    state = state.copyWith(isLoading: false, isReloading: false);
  }

  bool isSelected(int id) {
    final list = state.wishProductIds;
    // print("ids length : ${list.length}");
    final hasProductId = list.where((element) {
      if (kDebugMode) {
        print("list id : $element");
      }
      return element == id;
    }).isNotEmpty;
    //  print("has hasProductId $id : $hasProductId");
    return hasProductId;
  }

  bool hasProduct(int id) {
    final list = state.wishItems;
    // print("ids length : ${list!.length}");
    final hasProduct = list!.where((element) {
      if (kDebugMode) {
        print("list id : ${element}");
      }
      return element.product.id == id;
    }).isNotEmpty;
    // print("has hasProductId $id : $hasProduct");
    return hasProduct;
  }

  void checkLogin() {}
  Future<void> createWish(
      {required CreateWishData createWishData,
      required LoaderScreenType loaderScreenType}) async {
    if (!StorageController.isLoggedIn) {
      ViewUtil.showLoginDialog();
      return;
    }

    if (state.wishItems == null) {
      ViewUtil.SSLSnackbar("Wait...");
      return;
    }
    List<WishItem> updatedWishProducts = List.from(state.wishItems!);
    final hasWish = updatedWishProducts
        .any((item) => item.product.id == createWishData.productId);
    if (hasWish) {
      ViewUtil.SSLSnackbar("Wait...");
      return;
    }
    final updatedProductIds =
        addWishIds(state.wishProductIds, createWishData.productId);
    state = state.copyWith(
        isWishCreateLoading: true,
        loaderScreenType: loaderScreenType,
        wishProductIds: updatedProductIds);

    final token = PrefHelper.getString(AppConstant.TOKEN.key);
    final userid = PrefHelper.getString(AppConstant.USER_ID.key);

    var url = AppUrl.createWish.url;
    if (kDebugMode) {
      print('Token userid :- $userid');
      print('Token userid :- $userid');
      print('Token userid :- $userid');
    }
    await _apiClient
        .request(
      url: url,
      method: MethodType.POST,
      token: token,
      data: createWishData.toJson(),
      onSuccessFunction: (response) {
        // final WishResponse wishCreateResponse =
        //     WishCreateResponse.fromJson(response.data);
        "response $response".log();
        //   ViewUtil.SSLSnackbar("Added successfully.");
      },
    )
        .catchError((e) {
      "error $e".log();
    });
    getWishList();
    state = state.copyWith(
      isWishCreateLoading: false,
      loaderScreenType: LoaderScreenType.none,
    );
  }

  List<int> addWishIds(
      List<int> existingWishProductIds, int newWishProductIds) {
    List<int> updatedWishProductIds = List.from(existingWishProductIds);

    // Simply add the new item to the wishlist without checking for duplicates
    updatedWishProductIds.add(newWishProductIds);

    return updatedWishProductIds;
  }

  Future<void> deleteWish(
      {required int id, required LoaderScreenType loaderScreenType}) async {
    if (!StorageController.isLoggedIn) {
      // ViewUtil.showAlertDialog(
      //     content: const AccountLoginDialogue(
      //   title: "Please Login first.",
      // ));
      ViewUtil.showLoginDialog();
      return;
    }
    print("object 1");
    if (state.wishItems == null) {
      ViewUtil.SSLSnackbar("Wait...");
      print("object 2");
      return;
    }
    print("object 3");
    List<WishItem> updatedWishProducts = List.from(state.wishItems!);
    List<int> updatedWishProductIds = List.from(state.wishProductIds);
    final hasWish = updatedWishProducts.any((item) => item.product.id == id);
    print("object 4 $hasWish");
    final wishId = state.wishItems!
        .firstWhere((element) => element.product.id == id)
        .id
        .toString();
    if (hasWish) {
      print("object 5");
      updatedWishProducts.removeWhere((item) => item.product.id == id);
      updatedWishProductIds.removeWhere((item) => item == id);
      print("object 6");
      state = state.copyWith(
        isWishDeleteLoading: true,
        loaderScreenType: loaderScreenType,
        wishItems: updatedWishProducts,
        wishProductIds: updatedWishProductIds,
      );
      print("object 7");
    } else {
      print("object 8");
      ViewUtil.SSLSnackbar("Try again.");
      return;
    }
    // final userId = PrefHelper.getString(AppConstant.USER_ID.key);
    // print("object 9");
    // print("object 9");

    var url = AppUrl.deleteWish.url.replaceFirst('{wishId}', wishId);
    final token = PrefHelper.getString(AppConstant.TOKEN.key);
    if (kDebugMode) {
      print('Token get :- $token');
    }
    await _apiClient
        .request(
      url: url,
      method: MethodType.DELETE,
      token: token,
      onSuccessFunction: (response) {
        // final WishResponse wishCreateResponse =
        //     WishCreateResponse.fromJson(response.data);
        "response $response".log();
        // state = state.copyWith(
        //   wishCreateResponse: wishCreateResponse,
        // );
        //    ViewUtil.SSLSnackbar("Cancelled successfully.");
      },
    )
        .catchError((e) {
      ViewUtil.SSLSnackbar("$e");
      "error $e".log();
    });
    getWishList();
    state = state.copyWith(
      isWishDeleteLoading: false,
      loaderScreenType: LoaderScreenType.none,
    );
  }
}

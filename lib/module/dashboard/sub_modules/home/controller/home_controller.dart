import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/constant/app_url.dart';
import 'package:pink_by_trisha_app/data_provider/api_client.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/controller/home_state.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/model/home_country_response.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/model/home_price_calculation.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/model/home_response.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/model/review_price_confirmation_response.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/model/review_price_response.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/network_connection.dart';
import 'package:pink_by_trisha_app/utils/view_util.dart';

final homeController =
    StateNotifierProvider<HomeController, HomeState>((ref) => HomeController());

class HomeController extends StateNotifier<HomeState> {
  HomeController()
      : super(HomeState(
            heroBanners: const [],
            featuredCategories: const [],
            selectedCategory: null,
            categoryTitles: const [],
            bestDealProducts: const [],
            featuredBrands: const [],
            featuredProducts: const [],
            countries: const [],
            countryProductTypes: const [],
            priceCalculationData: null,
            isLoading: false,
            isCalculateBtnLoading: false,
            isReviewBtnLoading: false,
            isLoggedIn: false,
            productLinkCon: TextEditingController(text: ''),
            sellerShippingFeeCon: TextEditingController(text: ''),
            weightCon: TextEditingController(text: ''),
            weightUnit: null,
            dimensionUnit: null,
            productPriceCon: TextEditingController(text: ''),
            dimensionLengthCon: TextEditingController(text: ''),
            dimensionWidthCon: TextEditingController(text: ''),
            dimensionHeightCon: TextEditingController(text: ''),
            itemPriceCon: TextEditingController(text: ''),
            shippingFeeCon: TextEditingController(text: ''),
            totalPriceCon: TextEditingController(text: ''),
            selectedCountry: null,
            selectedProductType: null,
            responsePriceId: null,
            weightUnits: const ['KG', 'LB', 'OZ'],
            dimensionUnits: const ['Inch', 'CM'],
            reviewPriceResponse: null));

  final ApiClient _apiClient = ApiClient();
  void addListenersToControllers() {
    final controllers = [
      state.productLinkCon,
      state.productPriceCon,
      state.sellerShippingFeeCon,
      state.weightCon,
      state.dimensionLengthCon,
      state.dimensionWidthCon,
      state.dimensionHeightCon,
      state.itemPriceCon,
      state.shippingFeeCon,
      state.totalPriceCon,
    ];

    for (final controller in controllers) {
      controller.addListener(checkButtonStatus);
    }
  }

  void clearControllerText() {
    List<TextEditingController> controllers = [
      state.productLinkCon,
      state.productPriceCon,
      state.sellerShippingFeeCon,
      state.weightCon,
      state.dimensionLengthCon,
      state.dimensionWidthCon,
      state.dimensionHeightCon,
      state.itemPriceCon,
      state.shippingFeeCon,
      state.totalPriceCon,
    ];

    for (TextEditingController controller in controllers) {
      controller.clear();
    }
  }

  void checkButtonStatus() {
    final String productLink = state.productLinkCon.text.trim();
    final String productPrice = state.productPriceCon.text.trim();
    final String sellerShippingFee = state.sellerShippingFeeCon.text.trim();
    final String weight = state.weightCon.text.trim();
    final String dimensionLength = state.dimensionLengthCon.text.trim();
    final String dimensionWidth = state.dimensionWidthCon.text.trim();
    final String dimensionHeight = state.dimensionHeightCon.text.trim();
    final String itemPrice = state.itemPriceCon.text.trim();
    final String shippingFee = state.shippingFeeCon.text.trim();
    final String totalPrice = state.totalPriceCon.text.trim();

    if (productLink.isNotEmpty &&
        productPrice.isNotEmpty &&
        sellerShippingFee.isNotEmpty &&
        weight.isNotEmpty &&
        dimensionLength.isNotEmpty &&
        dimensionWidth.isNotEmpty &&
        dimensionHeight.isNotEmpty &&
        itemPrice.isNotEmpty &&
        shippingFee.isNotEmpty &&
        totalPrice.isNotEmpty) {
      // state = state.copyWith(isButtonEnabled: true);
    } else {
      // state = state.copyWith(isButtonEnabled: false);
    }
  }

  Future<void> reqHomePriceCalculation(BuildContext context) async {
    state = state.copyWith(isCalculateBtnLoading: true);

    try {
      final HomePriceCalculationSendData sendData =
          HomePriceCalculationSendData(
        onDemandCountryId: state.selectedCountry!.id!,
        onDemandProductTypeId: state.selectedProductType!.id!,
        productPrice: double.parse(state.productPriceCon.text.trim()),
        sellerShippingFee: double.parse(state.sellerShippingFeeCon.text.trim()),
        weight: double.parse(state.weightCon.text.trim()),
        weightUnit: state.weightUnit ?? state.weightUnits[0],
      );

      log('Pass: ${sendData.toMap()}');

      await _apiClient.request(
        url: AppUrl.homePriceCalculation.url,
        method: MethodType.POST,
        data: sendData.toMap(),
        onSuccessFunction: (response) {
          log('Response: ${jsonEncode(response.data)}');

          if (response.data != null) {
            'response is: ${jsonEncode(response.data)}'.log();
            final HomePriceCalculationResponse calculationModel =
                HomePriceCalculationResponse.fromJson(response.data);
            log('Model Response: ${calculationModel.statusCode}');
            state = state.copyWith(priceCalculationData: calculationModel.data);
            if (calculationModel.statusCode == 200) {
              log("${calculationModel.message}");
              state = state.copyWith(
                shippingFeeCon: TextEditingController(
                    text: calculationModel.data?.shippingFee?.toString() ?? ""),
                totalPriceCon: TextEditingController(
                    text: calculationModel.data?.totalPrice?.toString() ?? ""),
                itemPriceCon: TextEditingController(
                    text: calculationModel.data?.itemPrice?.toString() ?? ""),
              );
            }
          }
        },
      );
    } catch (e, s) {
      log("Log Error :-", error: e, stackTrace: s);
      // Handle errors as needed
    }
    state = state.copyWith(isCalculateBtnLoading: false);
  }

  Future<void> reqHomeReviewPrice() async {
    state = state.copyWith(isReviewBtnLoading: true);

    try {
      final url = AppUrl.homeReviewPrice.url;
      final ReviewPriceSendData sendData = ReviewPriceSendData(
        onDemandCountry: state.selectedCountry?.name ?? "",
        onDemandProductTypeName: state.selectedProductType?.name ?? "",
        productPrice: double.parse(state.productPriceCon.text.trim()),
        productPriceUnit: state.selectedCountry?.currencyISOCode ?? "",
        weight: double.parse(state.weightCon.text.trim()),
        weightUnit: state.weightUnit ?? "",
        sellerShippingFee: double.parse(state.sellerShippingFeeCon.text.trim()),
        length: int.parse(state.dimensionLengthCon.text.trim()),
        width: int.parse(state.dimensionWidthCon.text.trim()),
        height: int.parse(state.dimensionHeightCon.text.trim()),
        dimensionUnit: state.dimensionUnit ?? "",
        itemPrice: double.parse(state.itemPriceCon.text.trim()),
        shippingFee: double.parse(state.shippingFeeCon.text.trim()),
        pinkByTrishaFee: 5,
        totalPrice: double.parse(state.totalPriceCon.text.trim()),
        status: "ACTIVE",
        url: state.productLinkCon.text,
      );

      log('Pass: ${sendData.toMap()}');

      await _apiClient.request(
        url: url,
        method: MethodType.POST,
        data: sendData.toMap(),
        onSuccessFunction: (response) {
          log('Response: ${jsonEncode(response.data)}');

          'response is: ${jsonEncode(response.data)}'.log();
          final ReviewPriceResponse reviewPriceResponse =
              ReviewPriceResponse.fromJson(response.data);
          state = state.copyWith(reviewPriceResponse: reviewPriceResponse);
          log('Model Response: ${reviewPriceResponse.statusCode}');
          if (reviewPriceResponse.statusCode == 200) {
            log("${reviewPriceResponse.message}");
          }
        },
      );
    } catch (e, s) {
      log("Log Error :-", error: e, stackTrace: s);
      // Handle errors as needed
    }
    state = state.copyWith(isReviewBtnLoading: false);
  }

  Future<void> reqHomeReviewPriceConfirmation() async {
    state = state.copyWith(isReviewBtnLoading: true);

    try {
      final url = AppUrl.homeReviewPriceConfirmation.url.replaceFirst(
          '{priceId}', state.reviewPriceResponse!.data!.id!.toString());
      final ReviewPriceSendData sendData = ReviewPriceSendData(
        onDemandCountry: state.selectedCountry?.name ?? "",
        onDemandProductTypeName: state.selectedProductType?.name ?? "",
        productPrice: double.parse(state.productPriceCon.text.trim()),
        productPriceUnit: state.selectedCountry?.currencyISOCode ?? "",
        weight: double.parse(state.weightCon.text.trim()),
        weightUnit: state.weightUnit ?? "",
        sellerShippingFee: double.parse(state.sellerShippingFeeCon.text.trim()),
        length: int.parse(state.dimensionLengthCon.text.trim()),
        width: int.parse(state.dimensionWidthCon.text.trim()),
        height: int.parse(state.dimensionHeightCon.text.trim()),
        dimensionUnit: state.dimensionUnit ?? "",
        itemPrice: double.parse(state.itemPriceCon.text.trim()),
        shippingFee: double.parse(state.shippingFeeCon.text.trim()),
        pinkByTrishaFee: 5,
        totalPrice: double.parse(state.totalPriceCon.text.trim()),
        status: "ACTIVE",
        url: state.productLinkCon.text,
      );

      log('Pass: ${sendData.toMap()}');

      await _apiClient.request(
        url: url,
        method: MethodType.POST,
        data: sendData.toMap(),
        onSuccessFunction: (response) {
          log('Response: ${jsonEncode(response.data)}');

          if (response.data != null) {
            'response is: ${jsonEncode(response.data)}'.log();
            final ReviewPriceConfirmationResponse
                reviewPriceConfirmationResponse =
                ReviewPriceConfirmationResponse.fromJson(response.data);
            log('Model Response: ${reviewPriceConfirmationResponse.statusCode}');
            if (reviewPriceConfirmationResponse.statusCode == 200) {
              log("${reviewPriceConfirmationResponse.message}");
              ViewUtil.SSLSnackbar("Order Confirmed.");

              // set the state null of   priceCalculationData, reviewPriceResponse here
              state = state.makeNullableCalculation();
              clearControllerText();
            }
          }
        },
      );
    } catch (e, s) {
      log("Log Error :-", error: e, stackTrace: s);
      // Handle errors as needed
    }
    state = state.copyWith(isReviewBtnLoading: false);
  }

  Future<void> getHomeCountryResponse() async {
    final url = AppUrl.homeCountry.url;
    await _apiClient
        .request(
      url: url,
      method: MethodType.GET,
      onSuccessFunction: (response) {
        final HomeCountryResponse homeCountryResponse =
            HomeCountryResponse.fromJson(response.data);
        "response $response".log();
        state = state.copyWith(
            countries: homeCountryResponse.data,
            selectedCountry: homeCountryResponse.data?.first);
        if (state.countries.isNotEmpty) {
          getHomeProductTypesResponse(
              onDemandCountryId: state.countries[0].id!);
        }
      },
    )
        .catchError((e) {
      "error $e".log();
      print(e);
    });
  }

  void onCountryDropdownChange({required CountryData? data}) {
    state = state.copyWith(selectedCountry: data);
  }

  void onProductTypeDropdownChange({required CountryProductType? data}) {
    state = state.copyWith(selectedProductType: data);
  }

  void onCategoryChange({required FeaturedCategory? data}) {
    state = state.copyWith(selectedCategory: data);
  }

  void onWeightUnitDropdownChange({required data}) {
    state = state.copyWith(selectedCountry: data);
  }

  void onDimensionUnitDropdownChange({required data}) {
    state = state.copyWith(selectedCountry: data);
  }

  Future<void> getHomeProductTypesResponse(
      {required int onDemandCountryId}) async {
    final url = AppUrl.homeCountryProductType.url
        .replaceFirst('{onDemandCountryId}', onDemandCountryId.toString());
    await _apiClient
        .request(
      url: url,
      method: MethodType.GET,
      onSuccessFunction: (response) {
        final CountryProductTypeResponse countryProductTypeResponse =
            CountryProductTypeResponse.fromJson(response.data);
        "response $response".log();
        state = state.copyWith(
            selectedProductType: countryProductTypeResponse.data != null &&
                    countryProductTypeResponse.data!.isNotEmpty
                ? countryProductTypeResponse.data?.first
                : null,
            countryProductTypes: countryProductTypeResponse.data);
      },
    )
        .catchError((e) {
      "error $e".log();
      print(e);
    });
  }

  Future<void> getHomeResponse({
    required int? categoryId,
    bool isReload = true,
    required int skip,
    required int take,
  }) async {
    if (isReload) state = state.copyWith(isLoading: true);

    final url = AppUrl.home.url
        .replaceFirst('{categoryId}', categoryId?.toString() ?? "")
        .replaceFirst('{skip}', skip.toString())
        .replaceFirst('{take}', take.toString());
    await _apiClient
        .request(
      url: url,
      method: MethodType.GET,
      onSuccessFunction: (response) {
        print("home success 1");
        final HomeResponse homeBannerResponse =
            HomeResponse.fromJson(response.data);
        print("home success 2");
        final data = homeBannerResponse.data;
        print("home success 3");
        "response $response".log();
        final categoryTitles = [
          FeaturedCategory(name: "All Arrival"),
        ];
        print("home success 4");
        categoryTitles.addAll(data?.featuredCategories ?? []);
        state = state.copyWith(
          heroBanners: data?.heroBanners ?? [],
          featuredCategories: data?.featuredCategories ?? [],
          categoryTitles: categoryTitles,
          selectedCategory: categoryTitles.firstWhere(
              (element) => element.id == state.selectedCategory?.id),
          bestDealProducts: data?.bestDealProducts ?? [],
          featuredBrands: data?.featuredBrands ?? [],
          featuredProducts: data?.featuredProducts ?? [],
        );
      },
    )
        .catchError((e) {
      "error in home $e".log();
      print("home err 4");
    });
    state = state.copyWith(isLoading: false);
  }

  // Future<void> getCategoriesResponse() async {
  //   //state = state.copyWith(isLoading: true);

  //   final url = AppUrl.home.url
  //       .replaceFirst('{categoryId}', categoryId?.toString() ?? "")
  //       .replaceFirst('{skip}', skip.toString())
  //       .replaceFirst('{take}', take.toString());
  //   await _apiClient
  //       .request(
  //     url: url,
  //     method: Method.GET,
  //     onSuccessFunction: (response) {
  //       final HomeResponse homeBannerResponse =
  //           HomeResponse.fromJson(response.data);
  //       final data = homeBannerResponse.data;
  //       "response $response".log();
  //       final categoryTitles = [
  //         FeaturedCategory(name: "All Arrival"),
  //       ];
  //       categoryTitles.addAll(data?.featuredCategories ?? []);
  //       state = state.copyWith(
  //         heroBanners: data?.heroBanners ?? [],
  //         featuredCategories: data?.featuredCategories ?? [],
  //         categoryTitles: categoryTitles,
  //         selectedCategory: categoryTitles.firstWhere(
  //             (element) => element.id == state.selectedCategory?.id),
  //         bestDealProducts: data?.bestDealProducts ?? [],
  //         featuredBrands: data?.featuredBrands ?? [],
  //         featuredProducts: data?.featuredProducts ?? [],
  //       );
  //     },
  //   )
  //       .catchError((e) {
  //     "error $e".log();
  //   });
  //  // state = state.copyWith(isLoading: false);
  // }

  Future<void> getProductDetailsResponse() async {
    state = state.copyWith(isLoading: true);
    final url = AppUrl.home.url;
    await _apiClient
        .request(
      url: url,
      method: MethodType.GET,
      onSuccessFunction: (response) {
        final HomeResponse homeBannerResponse =
            HomeResponse.fromJson(response.data);
        final data = homeBannerResponse.data;
        "response $response".log();
        state = state.copyWith(
          heroBanners: data?.heroBanners ?? [],
          featuredCategories: data?.featuredCategories ?? [],
          bestDealProducts: data?.bestDealProducts ?? [],
          featuredBrands: data?.featuredBrands ?? [],
          featuredProducts: data?.featuredProducts ?? [],
        );
      },
    )
        .catchError((e) {
      "error $e".log();
    });
    state = state.copyWith(isLoading: false);
  }

  Future<void> getSearchResponse({
    required int? categoryId,
    required int skip,
    required int take,
  }) async {
    state = state.copyWith(isLoading: true);

    final url = AppUrl.home.url
        .replaceFirst('{categoryId}', categoryId?.toString() ?? "")
        .replaceFirst('{skip}', skip.toString())
        .replaceFirst('{take}', take.toString());
    await _apiClient
        .request(
      url: url,
      method: MethodType.GET,
      onSuccessFunction: (response) {
        final HomeResponse homeBannerResponse =
            HomeResponse.fromJson(response.data);
        final data = homeBannerResponse.data;
        "response $response".log();
        state = state.copyWith(
          heroBanners: data?.heroBanners ?? [],
          featuredCategories: data?.featuredCategories ?? [],
          bestDealProducts: data?.bestDealProducts ?? [],
          featuredBrands: data?.featuredBrands ?? [],
          featuredProducts: data?.featuredProducts ?? [],
        );
      },
    )
        .catchError((e) {
      "error $e".log();
    });
    state = state.copyWith(isLoading: false);
  }
  // Future<void> initializeAllApis() async {
  //   await getHomeResponse();
  // }
}

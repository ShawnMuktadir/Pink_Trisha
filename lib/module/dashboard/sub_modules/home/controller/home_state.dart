import 'package:flutter/cupertino.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/model/home_country_response.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/model/home_price_calculation.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/model/home_response.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/model/review_price_response.dart';

@immutable
class HomeState {
  final List<HeroBanner> heroBanners;
  final List<FeaturedCategory> featuredCategories;
  final List<FeaturedCategory> categoryTitles;
  final FeaturedCategory? selectedCategory;
  final List<ProductModel> bestDealProducts;
  final List<FeaturedBrand> featuredBrands;
  final List<ProductModel> featuredProducts;
  final List<CountryData> countries;
  final List<CountryProductType> countryProductTypes;
  final PriceCalculationData? priceCalculationData;
  final ReviewPriceResponse? reviewPriceResponse;
  final bool isLoading;
  final bool isCalculateBtnLoading;
  final bool isReviewBtnLoading;
  final bool isLoggedIn;
  final CountryData? selectedCountry;
  final CountryProductType? selectedProductType;
  final TextEditingController productLinkCon;
  final TextEditingController productPriceCon;
  final TextEditingController sellerShippingFeeCon;
  final TextEditingController weightCon;
  final int? responsePriceId;
  final String? weightUnit;
  final String? dimensionUnit;
  final List<String> dimensionUnits;
  final List<String> weightUnits;
  final TextEditingController dimensionLengthCon;
  final TextEditingController dimensionWidthCon;
  final TextEditingController dimensionHeightCon;
  final TextEditingController itemPriceCon;
  final TextEditingController shippingFeeCon;
  final TextEditingController totalPriceCon;

  const HomeState({
    required this.productLinkCon,
    required this.responsePriceId,
    required this.productPriceCon,
    required this.sellerShippingFeeCon,
    required this.weightCon,
    required this.weightUnit,
    required this.dimensionUnit,
    required this.weightUnits,
    required this.categoryTitles,
    required this.dimensionUnits,
    required this.dimensionLengthCon,
    required this.dimensionWidthCon,
    required this.dimensionHeightCon,
    required this.itemPriceCon,
    required this.reviewPriceResponse,
    required this.shippingFeeCon,
    required this.totalPriceCon,
    required this.countries,
    required this.countryProductTypes,
    required this.priceCalculationData,
    required this.heroBanners,
    required this.featuredCategories,
    required this.bestDealProducts,
    required this.featuredBrands,
    required this.selectedCategory,
    required this.featuredProducts,
    required this.isLoading,
    required this.isCalculateBtnLoading,
    required this.isReviewBtnLoading,
    required this.isLoggedIn,
    required this.selectedCountry,
    required this.selectedProductType,
  });

  HomeState copyWith({
    List<HeroBanner>? heroBanners,
    List<FeaturedCategory>? featuredCategories,
    FeaturedCategory? selectedCategory,
    List<FeaturedCategory>? categoryTitles,
    List<ProductModel>? bestDealProducts,
    List<FeaturedBrand>? featuredBrands,
    List<ProductModel>? featuredProducts,
    List<CountryData>? countries,
    List<CountryProductType>? countryProductTypes,
    PriceCalculationData? priceCalculationData,
    ReviewPriceResponse? reviewPriceResponse,
    bool? isLoggedIn,
    bool? isLoading,
    bool? isCalculateBtnLoading,
    bool? isReviewBtnLoading,
    String? weightUnit,
    String? dimensionUnit,
    List<String>? weightUnits,
    List<String>? dimensionUnits,
    int? responsePriceId,
    CountryData? selectedCountry,
    CountryProductType? selectedProductType,
    TextEditingController? productLinkCon,
    TextEditingController? productPriceCon,
    TextEditingController? sellerShippingFeeCon,
    TextEditingController? weightCon,
    TextEditingController? dimensionLengthCon,
    TextEditingController? dimensionWidthCon,
    TextEditingController? dimensionHeightCon,
    TextEditingController? itemPriceCon,
    TextEditingController? shippingFeeCon,
    TextEditingController? totalPriceCon,
  }) {
    return HomeState(
      heroBanners: heroBanners ?? this.heroBanners,
      featuredCategories: featuredCategories ?? this.featuredCategories,
      categoryTitles: categoryTitles ?? this.categoryTitles,
      reviewPriceResponse: reviewPriceResponse ?? this.reviewPriceResponse,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      bestDealProducts: bestDealProducts ?? this.bestDealProducts,
      featuredBrands: featuredBrands ?? this.featuredBrands,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      countries: countries ?? this.countries,
      countryProductTypes: countryProductTypes ?? this.countryProductTypes,
      priceCalculationData: priceCalculationData ?? this.priceCalculationData,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isCalculateBtnLoading:
          isCalculateBtnLoading ?? this.isCalculateBtnLoading,
      isReviewBtnLoading: isReviewBtnLoading ?? this.isReviewBtnLoading,
      isLoading: isLoading ?? this.isLoading,
      productLinkCon: productLinkCon ?? this.productLinkCon,
      productPriceCon: productPriceCon ?? this.productPriceCon,
      sellerShippingFeeCon: sellerShippingFeeCon ?? this.sellerShippingFeeCon,
      weightCon: weightCon ?? this.weightCon,
      weightUnit: weightUnit ?? this.weightUnit,
      dimensionUnit: dimensionUnit ?? this.dimensionUnit,
      weightUnits: weightUnits ?? this.weightUnits,
      dimensionUnits: dimensionUnits ?? this.dimensionUnits,
      dimensionLengthCon: dimensionLengthCon ?? this.dimensionLengthCon,
      dimensionWidthCon: dimensionWidthCon ?? this.dimensionWidthCon,
      dimensionHeightCon: dimensionHeightCon ?? this.dimensionHeightCon,
      itemPriceCon: itemPriceCon ?? this.itemPriceCon,
      shippingFeeCon: shippingFeeCon ?? this.shippingFeeCon,
      totalPriceCon: totalPriceCon ?? this.totalPriceCon,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedProductType: selectedProductType ?? this.selectedProductType,
      responsePriceId: responsePriceId ?? this.responsePriceId,
    );
  }

  HomeState makeNullableCalculation({
    PriceCalculationData? priceCalculationData,
    ReviewPriceResponse? reviewPriceResponse,
  }) {
    return HomeState(
      heroBanners: heroBanners,
      featuredCategories: featuredCategories,
      categoryTitles: categoryTitles,
      reviewPriceResponse: null,
      selectedCategory: selectedCategory,
      bestDealProducts: bestDealProducts,
      featuredBrands: featuredBrands,
      featuredProducts: featuredProducts,
      countries: countries,
      countryProductTypes: countryProductTypes,
      priceCalculationData: null,
      isLoggedIn: isLoggedIn,
      isCalculateBtnLoading: isCalculateBtnLoading,
      isReviewBtnLoading: isReviewBtnLoading,
      isLoading: isLoading,
      productLinkCon: productLinkCon,
      productPriceCon: productPriceCon,
      sellerShippingFeeCon: sellerShippingFeeCon,
      weightCon: weightCon,
      weightUnit: weightUnit,
      dimensionUnit: dimensionUnit,
      weightUnits: weightUnits,
      dimensionUnits: dimensionUnits,
      dimensionLengthCon: dimensionLengthCon,
      dimensionWidthCon: dimensionWidthCon,
      dimensionHeightCon: dimensionHeightCon,
      itemPriceCon: itemPriceCon,
      shippingFeeCon: shippingFeeCon,
      totalPriceCon: totalPriceCon,
      selectedCountry: selectedCountry,
      selectedProductType: selectedProductType,
      responsePriceId: responsePriceId,
    );
  }
}

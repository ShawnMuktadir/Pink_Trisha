import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/constant/app_url.dart';
import 'package:pink_by_trisha_app/data_provider/api_client.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_categories/model/category_response.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_top_brands/controller/brand_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_top_brands/model/brand_response.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/controller/product_list_state.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/model/product_list_response.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/model/screen_source_data.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/network_connection.dart';

import '../../../../../../../utils/enum.dart';

final productListController =
    StateNotifierProvider<ProductListController, ProductListState>(
        (ref) => ProductListController());

class ProductListController extends StateNotifier<ProductListState> {
  ProductListController()
      : super(ProductListState(
            products: const [],
            selectedCategory: null,
            selectedSubcategory: null,
            selectedBrands: const [],
            selectedCountries: const [],
            minPriceCon: TextEditingController(),
            maxPriceCon: TextEditingController(),
            isLoading: false,
            isProductsLoading: false,
            screenSourceData: null,
            slugValue: '',
            categories: [],
            productCount: 15));

  final ApiClient _apiClient = ApiClient();
  int categoryIdValue = 1;
  final int take = 15;
  int skip = 0;

  // int currentPage = 1; // To track the current active page
  int totalCount = 0; // Total products from API

  void nextPage(int currentPage) {
    int totalProducts = state.productCount; // Total number of products
    int take = 15; // Items per page

    // Ensure that the page number starts at 1 (not 0)
    int newSkip = (currentPage - 1) * take;

    // Prevent `skip` from exceeding totalProducts
    if (newSkip >= totalProducts) {
      print("No more pages available.");
      return;
    }

    // Update skip value
    skip = newSkip;

    print("Navigating to next page: $currentPage");
    print("Updated skip value: $skip");
    print("Total products available: $totalProducts");

    // Fetch the next set of products
    getProductListResponse();
  }

  void previousPage(int currentPage) {
    // Ensure skip is never negative
    if (currentPage == 1) {
      skip = 0; // Page 1 must always have skip = 0
    } else {
      skip =
          (currentPage - 1) * 15; // Correct calculation for page 2 and beyond
    }
    print("Navigating to page $currentPage, skip: $skip");
    getProductListResponse();
  }

  void goToPage(int page) {
    //currentPage = page;
    skip = (page - 1) * 10;
    getProductListResponse();
  }

  Future<void> initMethods(
      {required ScreenSourceData sourceData,
      required BuildContext context}) async {
    skip = 0;
    // currentPage = 1;
    totalCount = 0;
    state = state.copyWith(screenSourceData: sourceData);
    // final categoryCon = context.read(categoryController.notifier);
    final brandCon = context.read(brandController.notifier);

    state = state.copyWith(
        selectedCategory: CategoryData(), selectedSubcategory: Subcategories());
    Future(() {
      getProductListResponse();
      // categoryCon.getCategory();
      getCategory();
      brandCon.getBrand();
    });
  }

  void callSearch(String data) async {
    skip = 0;
    state = state.copyWith(
      slugValue: data,
    );
    state = state.copyWith(
        screenSourceData: ScreenSourceData(sourceType: SourceType.search));
    getProductListResponse();
  }

  void refresh() {
    skip = 0;
    state = state.copyWith(
        screenSourceData: ScreenSourceData(sourceType: SourceType.all));
    getProductListResponse();
  }

  void callFilter() async {
    skip = 0;
    state = state.copyWith(
        screenSourceData: ScreenSourceData(sourceType: SourceType.filter));
    getProductListResponse();
  }

  Future<void> getProductListResponse() async {
    state = state.copyWith(isLoading: true);
    print("getProductListResponse");
    final sourceData = state.screenSourceData!;
    // Convert the list of brandIds to a comma-separated string
    // final brandIdsString = brandIds.join(',');
    var url = "";
    if (sourceData.sourceType == SourceType.all) {
      url = AppUrl.productList.url
          .replaceFirst('{take}', take.toString())
          .replaceFirst('{skip}', skip.toString());
    } else if (sourceData.sourceType == SourceType.search) {
      url = AppUrl.productSearchUrl.url
          .replaceFirst('{search}', state.slugValue..trim())
          .replaceFirst('{take}', take.toString())
          .replaceFirst('{skip}', skip.toString());
    } else if (sourceData.sourceType == SourceType.filter) {
      // final selectedCategories = state.selectedCategories;
      final selectedCategoryId = state.selectedCategory?.id;
      final selectedBrands = state.selectedBrands;
      final selectedCountries = state.selectedCountries;
      final minPrice = state.minPriceCon.text;
      final maxPrice = state.maxPriceCon.text;

      // Convert the lists to comma-separated strings
      final categoryIdString = selectedCategoryId?.toString() ?? "";
      final subcategoryIdString =
          state.selectedSubcategory?.id?.toString() ?? "";
      final brandIdsString =
          selectedBrands.map((e) => e.id.toString()).join(',');
      final selectedCountriesString =
          selectedCountries.map((e) => e.id.toString()).join(',');

      url = AppUrl.productFilterUrl.url
          .replaceFirst('{categoryId}', categoryIdString)
          .replaceFirst('{subcategoryId}', subcategoryIdString)
          .replaceFirst('{brandIds}', brandIdsString)
          //  .replaceFirst('{typeId}', '') // Replace with actual typeId if needed
          .replaceFirst('{minPrice}', minPrice ?? '')
          .replaceFirst('{maxPrice}', maxPrice ?? '')
          .replaceFirst('{sortBy}', '') // Replace with actual sortBy if needed
          .replaceFirst('{take}', take.toString())
          .replaceFirst('{skip}', skip.toString());
    } else if (sourceData.sourceType == SourceType.brand) {
      final brandIdsString = sourceData.sourceId?.toString() ?? "";
      url = AppUrl.brandProducts.url
          .replaceFirst('{brandId}', brandIdsString)
          .replaceFirst('{take}', take.toString())
          .replaceFirst('{skip}', skip.toString());
    } else if (sourceData.sourceType == SourceType.category) {
      final categoryIdsString = sourceData.sourceId?.toString() ?? "";
      url = AppUrl.categoryProducts.url
          .replaceFirst('{categoryId}', categoryIdsString)
          .replaceFirst('{take}', take.toString())
          .replaceFirst('{skip}', skip.toString());
    } else {
      print("getProductListResponse");

      url = AppUrl.productList.url
          .replaceFirst('{take}', take.toString())
          .replaceFirst('{skip}', skip.toString());
    }

    print("response of product lis start");
    await _apiClient
        .request(
      url: url,
      method: MethodType.GET,
      onSuccessFunction: (response) {
        final ProductListResponse productListBannerResponse =
            ProductListResponse.fromJson(response.data);
        final data = productListBannerResponse.data;
        "response $response".log();
        print("response of product list is :  $response");
        totalCount =
            productListBannerResponse.totalCount ?? 20; // Update total count
        if (kDebugMode) {
          print(totalCount);
        }
        state = state.copyWith(
            isLoading: false, products: data, productCount: totalCount);
      },
    )
        .catchError((e) {
      "error $e".log();
    });
    state = state.copyWith(isLoading: false);
  }

  // Future<void> reqFilterResponse({
  //   required int take,
  //   required int skip,
  // }) async {
  //   state = state.copyWith(isLoading: true);

  //   // Extract the required parameters from the state
  //   final selectedCategories = state.selectedCategories;
  //   final selectedBrands = state.selectedBrands;
  //   final selectedCountries = state.selectedCountries;
  //   final minPrice = state.minPriceCon.text;
  //   final maxPrice = state.maxPriceCon.text;

  //   // Convert the lists to comma-separated strings
  //   final categoryIdsString =
  //       selectedCategories.map((e) => e.id.toString()).join(',');
  //   final brandIdsString = selectedBrands.map((e) => e.id.toString()).join(',');
  //   final countryIdsString =
  //       selectedCountries.map((e) => e.id.toString()).join(',');

  //   final url = AppUrl.productFilterUrl.url
  //       .replaceFirst('{categoryId}', categoryIdsString)
  //       .replaceFirst('{brandIds}', brandIdsString)
  //       //  .replaceFirst('{typeId}', '') // Replace with actual typeId if needed
  //       .replaceFirst('{minPrice}', minPrice ?? '')
  //       .replaceFirst('{maxPrice}', maxPrice ?? '')
  //       .replaceFirst('{sortBy}', '') // Replace with actual sortBy if needed
  //       .replaceFirst('{take}', take.toString())
  //       .replaceFirst('{skip}', skip.toString());
  //   print("url is $url ...");
  //   "response $url".log();
  //   await _apiClient
  //       .request(
  //     url: url,
  //     method: Method.GET,
  //     onSuccessFunction: (response) {
  //       final ProductListResponse productListBannerResponse =
  //           ProductListResponse.fromJson(response.data);
  //       final data = productListBannerResponse.data;
  //       "response $response".log();
  //       state = state.copyWith(isLoading: false, products: data);
  //     },
  //   )
  //       .catchError((e) {
  //     "error $e".log();
  //     state = state.copyWith(isLoading: false);
  //   });
  // }

  void toogleCategoryBox(CategoryData categoryData) {
    // Check if the categoryData with the same id exists in selectedCategories
    state = state.copyWith(
        selectedCategory: categoryData,
        selectedSubcategory: Subcategories(id: null));
  }

  void toogleSubcategoryBox(Subcategories subcategories) {
    // Check if the categoryData with the same id exists in selectedCategories
    state = state.copyWith(
      selectedSubcategory: subcategories,
    );
  }

  // void toogleCategoryBox(CategoryData categoryData) {
  //   // Check if the categoryData with the same id exists in selectedCategories
  //   bool isExistingCategory = state.selectedCategories
  //       .any((existingCategory) => existingCategory.id == categoryData.id);

  //   // Create a new list by removing or adding the categoryData based on its existence
  //   final updatedCategories = isExistingCategory
  //       ? state.selectedCategories
  //           .where((existingCategory) => existingCategory.id != categoryData.id)
  //           .toList()
  //       : [...state.selectedCategories, categoryData];

  //   state = state.copyWith(
  //     selectedCategories: updatedCategories,
  //   );
  // }

  void toogleBrandBox(BrandData brandData) {
    // Check if the brandData with the same id exists in selectedBrands
    bool isExistingBrand = state.selectedBrands
        .any((existingBrand) => existingBrand.id == brandData.id);

    // Create a new list by removing or adding the brandData based on its existence
    final updatedBrands = isExistingBrand
        ? state.selectedBrands
            .where((existingBrand) => existingBrand.id != brandData.id)
            .toList()
        : [...state.selectedBrands, brandData];

    state = state.copyWith(
      selectedBrands: updatedBrands,
    );
  }

  bool isSelectedCategory(CategoryData categoryData) {
    final hasData = state.selectedCategory?.id == categoryData.id;

    return hasData;
  }

  bool isSelectedSubcategory(Subcategories subcategories) {
    final hasData = state.selectedSubcategory?.id == subcategories.id;

    return hasData;
  }

  bool isSelectedBrand(BrandData brandData) {
    final hasData = state.selectedBrands
        .where((element) => element.id == brandData.id)
        .toList()
        .isNotEmpty;

    return hasData;
  }

  //final ApiClient _apiClient = ApiClient();

  Future<void> getCategory({bool isLoading = false}) async {
    // state = state.copyWith(isLoading: state.categories.isEmpty || isLoading);

    await _apiClient
        .request(
            url: AppUrl.category.url,
            method: MethodType.GET,
            onSuccessFunction: (response) {
              final CategoryResponse categoryResponse =
                  CategoryResponse.fromJson(response.data);
              // print(object)

              state = state.copyWith(
                categories: categoryResponse.data ?? [],
              );
            })
        .catchError((e) {
      "error $e".log();
    });
  }
}

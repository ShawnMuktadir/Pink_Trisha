import 'package:flutter/cupertino.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_categories/model/category_response.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_top_brands/model/brand_response.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/model/home_country_response.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/model/product_list_response.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/model/screen_source_data.dart';

@immutable
class ProductListState {
  final int productCount;
  final List<Product> products;
  final List<CategoryData> categories;
  final CategoryData? selectedCategory;
  final Subcategories? selectedSubcategory;
  final List<BrandData> selectedBrands;
  final List<CountryData> selectedCountries;
  final TextEditingController minPriceCon;
  final TextEditingController maxPriceCon;
  final ScreenSourceData? screenSourceData;
  final bool isLoading;
  final bool isProductsLoading;
  final String slugValue;

  // Constructor with required parameters and optional named parameters
  const ProductListState({
    required this.slugValue,
    required this.productCount,
    required this.products,
    required this.selectedCategory,
    required this.categories,
    required this.selectedSubcategory,
    required this.screenSourceData,
    required this.selectedBrands,
    required this.selectedCountries,
    required this.minPriceCon,
    required this.maxPriceCon,
    required this.isLoading,
    required this.isProductsLoading,
  });

  // CopyWith method to create a new instance of the class with updated values
  ProductListState copyWith(
      {List<Product>? products,
      CategoryData? selectedCategory,
      Subcategories? selectedSubcategory,
      List<CategoryData>? categories,
      List<BrandData>? selectedBrands,
      List<CountryData>? selectedCountries,
      TextEditingController? searchCon,
      TextEditingController? minPriceCon,
      TextEditingController? maxPriceCon,
      ScreenSourceData? screenSourceData,
      bool? isLoading,
      bool? isProductsLoading,
      int? productCount,
      String? slugValue}) {
    return ProductListState(
      products: products ?? this.products,
      productCount: productCount ?? this.productCount,
      slugValue: slugValue ?? this.slugValue,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedSubcategory: selectedSubcategory ?? this.selectedSubcategory,
      categories: categories ?? this.categories,
      selectedBrands: selectedBrands ?? this.selectedBrands,
      selectedCountries: selectedCountries ?? this.selectedCountries,
      screenSourceData: screenSourceData ?? this.screenSourceData,
      minPriceCon: minPriceCon ?? this.minPriceCon,
      maxPriceCon: maxPriceCon ?? this.maxPriceCon,
      isLoading: isLoading ?? this.isLoading,
      isProductsLoading: isProductsLoading ?? this.isProductsLoading,
    );
  }
}

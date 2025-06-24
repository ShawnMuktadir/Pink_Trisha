import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/model/product_list_response.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/model/product_details_response.dart';
import 'package:pink_by_trisha_app/utils/math_util.dart';

class SelectedAttributeModel {
  final int attributeId;
  final String attributeName;
  final int attributeValueId;
  final double? price;
  final String attributeValueName;
  final double? offerPrice;
  final double? priceInUSD;
  final double? offerPriceInUSD;
  final int? quantity;
  final String? imageUrl;

  SelectedAttributeModel({
    required this.attributeId,
    required this.attributeName,
    required this.attributeValueId,
    required this.price,
    required this.attributeValueName,
    required this.offerPrice,
    required this.priceInUSD,
    required this.offerPriceInUSD,
    this.quantity,
    this.imageUrl,
  });

  factory SelectedAttributeModel.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print('product price Raw offerPrice: ${json['offerPrice']}');
      print('product price Parsed offerPrice: ${parseToDouble(json['offerPrice'])}');
    }


    return SelectedAttributeModel(
      attributeId: json['attributeId'],
      attributeName: json['attributeName'],
      attributeValueId: json['attributeValueId'],
      price: parseToDouble(json['price']),
      attributeValueName: json['attributeValueName'],
      offerPrice: parseToDouble(json['offerPrice']),
      priceInUSD: parseToDouble(json['priceInUSD']),
      offerPriceInUSD: parseToDouble(json['offerPriceInUSD']),
      quantity: json['quantity'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attributeId': attributeId,
      'attributeName': attributeName,
      'attributeValueId': attributeValueId,
      'price': price,
      'attributeValueName': attributeValueName,
      'offerPrice': offerPrice,
      'priceInUSD': priceInUSD,
      'offerPriceInUSD': offerPriceInUSD,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }
}

class VariantArgument {
  final double? price;
  final double? offerPrice;
  final double? priceInUSD;
  final double? offerPriceInUSD;
  final int? quantity;
  final String? imageUrl;

  VariantArgument(
      {required this.price,
      required this.offerPrice,
      required this.priceInUSD,
      required this.offerPriceInUSD,
      required this.quantity,
      required this.imageUrl});

  factory VariantArgument.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print('VariantArgument.fromJson() → Raw JSON: $json');
    }

    return VariantArgument(
      price: parseToDouble(json['price']),
      offerPrice: parseToDouble(json['offerPrice']),
      priceInUSD: parseToDouble(json['priceInUSD']),
      offerPriceInUSD: parseToDouble(json['offerPriceInUSD']),
      quantity: json['quantity'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'offerPrice': offerPrice,
      'priceInUSD': priceInUSD,
      'offerPriceInUSD': offerPriceInUSD,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }
}

@immutable
class ProductDetailsState {
  final ProductDetailsData? productDetailsData;
  final List<Product> relatedProducts;
  final VariantArgument? variantArgument;
  final List<ProductDetailsVariant> selectedProductVariants;
  final int currentSlipPageIndex;
  final bool isLoading;
  final bool isRelatedProductsLoading;
  final int currentProductQuantity;
  final int currentCheckoutMethodIndex;
  final ScrollController scrollController;
  final ScrollController slipScrollController;
  final ScrollController titleScrollController;
  final PageController slipPageController;
  final List<String> pageTitles;
  final List<Widget> pages;
  final List<SelectedAttributeModel> currentAttributeValueId;

  const ProductDetailsState({
    required this.currentProductQuantity,
    required this.currentCheckoutMethodIndex,
    required this.currentAttributeValueId,
    required this.productDetailsData,
    required this.selectedProductVariants,
    required this.scrollController,
    required this.slipScrollController,
    required this.variantArgument,
    required this.titleScrollController,
    required this.relatedProducts,
    required this.isLoading,
    required this.currentSlipPageIndex,
    required this.pageTitles,
    required this.pages,
    required this.slipPageController,
    required this.isRelatedProductsLoading,
  });

  ProductDetailsState copyWith({
    int? currentProductQuantity,
    int? currentCheckoutMethodIndex,
    List<ProductDetailsVariant>? selectedProductVariants,
    ProductDetailsData? productDetailsData,
    List<Product>? relatedProducts,
    bool? isRelatedProductsLoading,
    int? currentSlipPageIndex,
    ScrollController? scrollController,
    ScrollController? slipScrollController,
    ScrollController? titleScrollController,
    PageController? slipPageController,
    List<String>? pageTitles,
    List<Widget>? pages,
    VariantArgument? variantArgument,
    List<SelectedAttributeModel>? currentAttributeValueId,
    bool? isLoading,
  }) {
    return ProductDetailsState(
      currentAttributeValueId:
          currentAttributeValueId ?? this.currentAttributeValueId,
      currentProductQuantity:
          currentProductQuantity ?? this.currentProductQuantity,
      variantArgument: variantArgument ?? this.variantArgument,
      currentCheckoutMethodIndex:
          currentCheckoutMethodIndex ?? this.currentCheckoutMethodIndex,
      productDetailsData: productDetailsData ?? this.productDetailsData,
      selectedProductVariants:
          selectedProductVariants ?? this.selectedProductVariants,
      slipScrollController: slipScrollController ?? this.slipScrollController,
      scrollController: scrollController ?? this.scrollController,
      titleScrollController:
          titleScrollController ?? this.titleScrollController,
      slipPageController: slipPageController ?? this.slipPageController,
      pageTitles: pageTitles ?? this.pageTitles,
      pages: pages ?? this.pages,
      relatedProducts: relatedProducts ?? this.relatedProducts,
      isLoading: isLoading ?? this.isLoading,
      currentSlipPageIndex: currentSlipPageIndex ?? this.currentSlipPageIndex,
      isRelatedProductsLoading:
          isRelatedProductsLoading ?? this.isRelatedProductsLoading,
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/constant/app_url.dart';
import 'package:pink_by_trisha_app/data_provider/api_client.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/components/product_details_slip.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/controller/product_details_state.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/model/product_details_response.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/model/related_products_response.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';

import '../../../../../../../utils/enum.dart';

final productDetailsController = StateNotifierProvider.autoDispose
    .family<ProductDetailsController, ProductDetailsState, int>(
  (ref, id) => ProductDetailsController(id: id),
);

class ProductDetailsController extends StateNotifier<ProductDetailsState> {
  ProductDetailsController({required this.id})
      : super(ProductDetailsState(
          productDetailsData: null,
          relatedProducts: const [],
          isLoading: false,
          isRelatedProductsLoading: false,
          currentSlipPageIndex: 0,
          slipPageController: PageController(),
          pageTitles: const [
            "Product Details",
            "Product Warranty",
            "Product Return Policy"
          ],
          currentCheckoutMethodIndex: 0,
          pages: [
            ProductDetailsPage(
              id: id,
            ),
            ProductWarrantyPage(
              id: id,
            ),
            ProductReturnPolicyPage(
              id: id,
            ),
          ],
          scrollController: ScrollController(),
          slipScrollController: ScrollController(),
          titleScrollController: ScrollController(),
          currentProductQuantity: 1,
          selectedProductVariants: const [],
          currentAttributeValueId: const [],
          variantArgument: null,
        )) {
    initializeMethods();
  }

  final int id;
  int totalVariants = 0;

  final List<String> pageTitles = [];

  void toggleAttributes(SelectedAttributeModel selectedAttributeModel) {
    List<SelectedAttributeModel> updatedList =
        List.from(state.currentAttributeValueId);

    // Check if the attributeId already exists in the list
    int indexToRemove = -1;
    state = state.copyWith(
        variantArgument: VariantArgument(
            price: selectedAttributeModel.price,
            offerPrice: selectedAttributeModel.offerPrice,
            priceInUSD: selectedAttributeModel.priceInUSD,
            offerPriceInUSD: selectedAttributeModel.offerPriceInUSD,
            quantity: selectedAttributeModel.quantity,
            imageUrl: selectedAttributeModel.imageUrl));
    for (int i = 0; i < updatedList.length; i++) {
      if (updatedList[i].attributeId == selectedAttributeModel.attributeId) {
        // AttributeId exists, mark the index to remove
        indexToRemove = i;
        break;
      }
    }

    // If attributeId exists, remove it
    if (indexToRemove != -1) {
      updatedList.removeAt(indexToRemove);
    }

    // Add the new entry
    updatedList.add(selectedAttributeModel);

    // Print the updated list for debugging
    List<ProductDetailsVariant> selectedproductVariants = [];
    for (var id in updatedList) {
      state.productDetailsData?.productVariants
          ?.where((data) =>
              data.id == id.attributeId &&
              data.attribute?.id == id.attributeValueId)
          .toList();
      // selectedproductVariants.add(id);
      print(
          "attributeId is: ${id.attributeId}, attributeValueId is: ${id.attributeValueId}..");
    }

    // Update the state with the modified list
    state = state.copyWith(
        currentAttributeValueId: updatedList,
        selectedproductVariants: selectedproductVariants);
  }

  // late List<Widget>  pages = [

  //   ];
  // @override
  // void initState() {
  //   super.initState();

  //   _currentIndex = 0;
  //   _pageController = PageController(initialPage: _currentIndex);

  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _scrollToTitle(_currentIndex);
  //   });

  //   _pageController.addListener(() {

  //       state.currentSlipPageIndex = ;
  //     state = state.copyWith(currentSlipPageIndex: _pageController.page!.round());

  //     _scrollToTitle(_currentIndex);
  //   });
  // }

  void incrementQuantity() {
    print("incrementQuantity");
    if (state.currentProductQuantity < 10) {
      state = state.copyWith(
          currentProductQuantity: state.currentProductQuantity + 1);

      print("Quantity ${state.currentProductQuantity}");
    }
  }

  void decrementQuantity() {
    print("decrementQuantity");
    if (state.currentProductQuantity > 1) {
      state = state.copyWith(
          currentProductQuantity: state.currentProductQuantity - 1);
    }
  }

  void initializeMethods() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToTitle(state.currentSlipPageIndex);
    });
    state.slipPageController.addListener(() {
      state = state.copyWith(
          currentSlipPageIndex: state.slipPageController.page!.round());
      scrollToTitle(state.currentSlipPageIndex);
    });
    state.slipScrollController.addListener(_handleInnerListScroll);
  }

  void _handleInnerListScroll() {
    if (state.slipScrollController.position.pixels == 0) {
      state.scrollController.animateTo(
        state.scrollController.position.pixels - 400,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    } else if (state.slipScrollController.position.pixels ==
        state.slipScrollController.position.maxScrollExtent) {
      state.scrollController.animateTo(
        state.scrollController.position.pixels + 400,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    }
  }

  void scrollToTitle(int index) {
    if (kDebugMode) print("Page index $index");
    if (index >= 0 && index < 3) {
      if (state.titleScrollController.hasClients) {
        state.titleScrollController.animateTo(
          (index * index) * 260.0,
          duration: const Duration(milliseconds: 1),
          curve: Curves.fastLinearToSlowEaseIn,
        );
      }
    }
    state = state.copyWith(currentSlipPageIndex: index);
  }

  // void scrollToTitle(int index) {
  //   if (kDebugMode) print("Page index $index");
  //   if (index >= 0 && index < 3) {
  //     state.titleScrollController.animateTo(
  //       (index * index) * 260.0,
  //       duration: const Duration(milliseconds: 1),
  //       curve: Curves.fastLinearToSlowEaseIn,
  //     );
  //     // if (_scrollController.position.pixels != (index * index) * 220.0) {
  //     // }
  //   }
  // }

  final ApiClient _apiClient = ApiClient();

  TextEditingController searchCon = TextEditingController();

  String slugValue = "";
  int categoryIdValue = 1;

  Future<void> getProductDetailsResponse({required String slug}) async {
    print("slug is $slug");
    slugValue = slug;
    print("slugvalue is $slugValue");
    state = state.copyWith(isLoading: true);
    final url = AppUrl.productDetails.url.replaceAll("{slug}", slugValue);

    await _apiClient
        .request(
      url: url,
      method: MethodType.GET,
      onSuccessFunction: (response) {
        final ProductDetailsResponse productDetailsResponse =
            ProductDetailsResponse.fromJson(response.data);
        final data = productDetailsResponse.data;
        "response $response".log();
        state = state.copyWith(isLoading: false, productDetailsData: data);
        if (data?.category?.id != null) {
          getRelatedProductsResponse(categoryId: data!.category!.id!);
        }
      },
    )
        .catchError((e) {
      "error $e".log();
    });
    state = state.copyWith(isLoading: false);
  }

  Future<void> getRelatedProductsResponse({required int categoryId}) async {
    categoryIdValue = categoryId;
    state = state.copyWith(isRelatedProductsLoading: true);
    var url = AppUrl.relatedProducts.url
        .replaceFirst('{slug}', slugValue)
        .replaceFirst('{search}', searchCon.text.trim())
        .replaceFirst('{categoryId}', categoryIdValue.toString());
    print("The url is : ");
    print(url);
    await _apiClient
        .request(
      url: url,
      method: MethodType.GET,
      onSuccessFunction: (response) {
        print("The url 2 is : ");
        print("The url 2 is : ");
        print(url);
        final RelatedProductsResponse relatedProductsResponse =
            RelatedProductsResponse.fromJson(response.data);
        final data = relatedProductsResponse.data;
        "response $response".log();
        state = state.copyWith(
            isRelatedProductsLoading: false, relatedProducts: data);
      },
    )
        .catchError((e) {
      print("The url 2 is : $url and the error ");
      "error $e".log();
    });
    state = state.copyWith(isRelatedProductsLoading: false);
  }

  Future<void> reloadAllApis() async {
    await getProductDetailsResponse(slug: slugValue);
  }

  void setCheckOutMethod(int index) {
    state = state.copyWith(currentCheckoutMethodIndex: index);
  }

  @override
  void dispose() {
    state.slipPageController.dispose();
    state.scrollController.dispose();
    state.titleScrollController.dispose();
    super.dispose();
  }
}

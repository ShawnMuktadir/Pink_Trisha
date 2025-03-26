import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_loader.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/controller/wish_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_search/home_search.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/components/home_logo_with_background.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/components/pagination_buttons.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/components/product_list.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/components/search_for_title.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/model/screen_source_data.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

import 'controller/product_list_controller.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.screenSourceData})
      : super(key: key);
  final ScreenSourceData screenSourceData;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late PageController _pageController;
  int activeButton = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    final controller = context.read(productListController.notifier);
    Future(() {
      controller.initMethods(
          sourceData: widget.screenSourceData, context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final state = ref.watch(productListController);
      final wishState = ref.watch(wishController);
      final controller = ref.read(productListController.notifier);
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: GlobalTopLoader(
            isLoading:
                wishState.loaderScreenType == LoaderScreenType.productList,
            child: Container(
              width: context.width,
              constraints: BoxConstraints(
                minHeight: context.height,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    KColor.homeGradientStart.color,
                    KColor.homeGradientEnd.color,
                  ],
                ),
              ),
              child: Column(
                children: [
                  const HomeLogoWithBackground(),
                  const HomeSearch(),
                  Expanded(
                    child: Column(
                      children: [
                        state.screenSourceData?.sourceType ==
                                    SourceType.search &&
                                state.slugValue.isNotEmpty
                            ? SearchForTitle(
                                slug: state.slugValue,
                              )
                            : const SizedBox.shrink(),
                        ProductList(
                          pageController: _pageController,
                          onRefresh: () {
                            setState(() {
                              activeButton = 1;
                            });
                          },
                          // totalButtons: (state.products.length / 10).ceil() + 1,
                        ),
                        if (state.productCount != 0)
                          PaginationButtons(
                            totalCount: state.productCount,
                            activeButton: activeButton,
                            onButtonPressed: (newActiveButton) {
                              setState(() {
                                activeButton = newActiveButton;
                              });
                              _pageController.animateToPage(
                                newActiveButton > 1 ? newActiveButton - 1 : 1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            onNextPage: (pageNumber) =>
                                controller.nextPage(pageNumber),
                            onPreviousPage: (pageNumber) => controller.previousPage(pageNumber),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_search/home_search.dart';
// import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/components/home_logo_with_background.dart';
// import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/components/pagination_buttons.dart';
// import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/components/product_list.dart';
// import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/components/search_for_title.dart';
// import 'package:pink_by_trisha_app/utils/extension.dart';
// import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

// import '../../../../product/controller/product_list_controller.dart';
// import '../../../controller/product_details_controller.dart';
// import 'related_product_list.dart';
// import 'related_search.dart';

// class RelatedProductSeeAll extends StatefulWidget {
//   final int categoryId;
//   const RelatedProductSeeAll({
//     Key? key,
//     required this.categoryId
//   }) : super(key: key);

//   @override
//   State<RelatedProductSeeAll> createState() => _ProductScreenState();
// }

// class _ProductScreenState extends State<RelatedProductSeeAll> {

//   late PageController _pageController;
//   int activeButton = 1;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _pageController = PageController(initialPage: 0);
//     final controller = context.read(productDetailsController.notifier);
//     final productController = context.read(productListController.notifier);
//     Future(() {
//       controller.getRelatedProductsResponse(categoryId: widget.categoryId);
//       productController.getProductListResponse(skip: 0, take: 50);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//         builder: (context, ref, child) {
//           final state = ref.watch(productDetailsController);
//           final controller = ref.read(productDetailsController.notifier);
//           return Scaffold(
//             resizeToAvoidBottomInset: false,
//             body: SafeArea(
//               child: Container(
//                 width: context.width,
//                 constraints: BoxConstraints(
//                   minHeight: context.height,
//                 ),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       KColor.homeGradientStart.color,
//                       KColor.homeGradientEnd.color,
//                     ],
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     const HomeLogoWithBackground(),
//                     RelatedProductSearch(categoryId: widget.categoryId),
//                     Expanded(
//                       child: RefreshIndicator(
//                         onRefresh: ()async{
//                           Future(() async{
//                             await controller.getRelatedProductsResponse(categoryId: widget.categoryId);
//                           });
//                         },
//                         child: Column(
//                           children: [
//                             const SearchForTitle(),
//                             RelatedProductList(
//                               categoryId: widget.categoryId,
//                               pageController: _pageController,
//                               totalButtons: (state.relatedProducts.length / 10).ceil() + 1,
//                             ),
//                             PaginationButtons(
//                               totalButtons: (state.relatedProducts.length / 10).ceil() + 1,
//                               activeButton: activeButton,
//                               onButtonPressed: (newActiveButton){
//                                 setState(() {
//                                   activeButton = newActiveButton;
//                                 });
//                                 _pageController.animateToPage(
//                                   newActiveButton - 1,
//                                   duration: const Duration(milliseconds: 1000),
//                                   curve: Curves.easeInOut,
//                                 );},
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }
//     );
//   }
// }

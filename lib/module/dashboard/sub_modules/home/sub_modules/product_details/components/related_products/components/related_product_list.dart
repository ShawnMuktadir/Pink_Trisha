// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pink_by_trisha_app/global/widget/global_product_card.dart';
// import 'package:pink_by_trisha_app/utils/extension.dart';

// import '../../../../product/controller/product_list_controller.dart';
// import '../../../controller/product_details_controller.dart';

// class RelatedProductList extends StatelessWidget {
//   final int categoryId;
//   final PageController pageController;
//   final int totalButtons;
//   const RelatedProductList({
//     super.key,
//     required this.categoryId,
//     required this.pageController,
//     required this.totalButtons
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//         builder: (context, ref, child) {
//           final state = ref.watch(productDetailsController);
//           final controller = ref.read(productDetailsController.notifier);
//           final productState = ref.watch(productListController);

//           // return Expanded(
//           //   child: PageView.builder(
//           //       controller: pageController,
//           //       physics: const NeverScrollableScrollPhysics(),
//           //       itemBuilder: (context, index){
//           //         int startIndex = index * 10;
//           //         int endIndex = (index + 1) * 10;
//           //         int productEndIndex = (index + 1) * 10;
//           //
//           //         endIndex = endIndex > state.relatedProducts.length
//           //             ? state.relatedProducts.length
//           //             : endIndex;
//           //
//           //         productEndIndex = productEndIndex > state.relatedProducts.length
//           //             ? state.relatedProducts.length
//           //             : productEndIndex;
//           //
//           //         if(state.relatedProducts.isNotEmpty){
//           //           if(state.isLoading){
//           //             return const Center(child: CircularProgressIndicator());
//           //           } else{
//           //             if(index == totalButtons - 1){
//           //               return const Center(child: Text("Data Not Found!"));
//           //             } else{
//           //               return state.isLoading
//           //                   ? const Center(child: CircularProgressIndicator())
//           //                   : RefreshIndicator(
//           //                 onRefresh: ()async{
//           //                   Future(() async{
//           //                     await controller.getRelatedProductsResponse(categoryId: categoryId);
//           //                   });
//           //                 },
//           //                 child: GridView.builder(
//           //                     itemCount: endIndex - startIndex,
//           //                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           //                         crossAxisCount: 2,
//           //                         mainAxisExtent: 260),
//           //                     padding: const EdgeInsets.only(top: 20),
//           //                     itemBuilder: (ctx, itemIndex){
//           //                       int productIndex = startIndex + itemIndex;
//           //                       if(productIndex < state.relatedProducts.length){
//           //                         return Container(
//           //                           width: context.width / 2,
//           //                           padding: EdgeInsets.symmetric(
//           //                             vertical: 10.h,
//           //                             horizontal: 14.w,
//           //                           ),
//           //                           child: GlobalProductCard(
//           //                             imageUrl: state.relatedProducts[productIndex].imageUrl,
//           //                             isSelected: true,
//           //                             title: state.relatedProducts[productIndex].name,
//           //                             subTitle: state.relatedProducts[productIndex].shortDescription,
//           //                             price: state.relatedProducts[productIndex].price,
//           //                             offerPrice: state.relatedProducts[productIndex].offerPrice,
//           //                             slug: state.relatedProducts[productIndex].slug ?? "",
//           //                             // isSelected: itemIndex == 0 || itemIndex == 3 || itemIndex == 4, slug: '',
//           //                           ),
//           //                         );
//           //                       } else{
//           //                         return Container();
//           //                       }
//           //                     }
//           //                  )
//           //               );
//           //             }
//           //           }
//           //         } else{
//           //           return GridView.builder(
//           //               itemCount: productEndIndex - startIndex,
//           //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           //                   crossAxisCount: 2,
//           //                   mainAxisExtent: 260),
//           //               padding: const EdgeInsets.only(top: 20),
//           //               itemBuilder: (ctx, itemIndex){
//           //                 int productIndex = startIndex + itemIndex;
//           //                 if(productIndex < productState.products.length){
//           //                   return Container(
//           //                     width: context.width / 2,
//           //                     padding: EdgeInsets.symmetric(
//           //                       vertical: 10.h,
//           //                       horizontal: 14.w,
//           //                     ),
//           //                     child: GlobalProductCard(
//           //                       imageUrl: productState.products[productIndex].imageUrl,
//           //                       isSelected: true,
//           //                       title: productState.products[productIndex].name,
//           //                       subTitle: productState.products[productIndex].shortDescription,
//           //                       price: productState.products[productIndex].price,
//           //                       offerPrice: productState.products[productIndex].offerPrice,
//           //                       slug: productState.products[productIndex].slug ?? "",
//           //                       // isSelected: itemIndex == 0 || itemIndex == 3 || itemIndex == 4, slug: '',
//           //                     ),
//           //                   );
//           //                 } else{
//           //                   return Container();
//           //                 }
//           //               }
//           //           );
//           //         }
//           //       }
//           //   ),
//           // );

//           return Expanded(
//             child: PageView.builder(
//                 controller: pageController,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index){
//                   int startIndex = index * 10;
//                   int endIndex = (index + 1) * 10;

//                   endIndex = endIndex > state.relatedProducts.length
//                       ? state.relatedProducts.length
//                       : endIndex;

//                   if(state.relatedProducts.isNotEmpty){
//                     if(state.isLoading){
//                       return const Center(child: CircularProgressIndicator());
//                     } else{
//                       if(index == totalButtons - 1){
//                         return const Center(child: Text("Data Not Found!"));
//                       } else{
//                         return state.isLoading
//                             ? const Center(child: CircularProgressIndicator())
//                             : RefreshIndicator(
//                                 onRefresh: ()async{
//                                   Future(() async{
//                                     await controller.getRelatedProductsResponse(categoryId: categoryId);
//                                   });
//                                 },
//                               child: GridView.builder(
//                               itemCount: endIndex - startIndex,
//                               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 2,
//                                   mainAxisExtent: 260),
//                               padding: const EdgeInsets.only(top: 20),
//                               itemBuilder: (ctx, itemIndex){
//                                 int productIndex = startIndex + itemIndex;
//                                 if(productIndex < state.relatedProducts.length){
//                                   return Container(
//                                     width: context.width / 2,
//                                     padding: EdgeInsets.symmetric(
//                                       vertical: 10.h,
//                                       horizontal: 14.w,
//                                     ),
//                                     child: GlobalProductCard(
//                                       imageUrl: state.relatedProducts[productIndex].imageUrl,
//                                       id: state.relatedProducts[productIndex].id!,
//                                       isSelected: true,
//                                       title: state.relatedProducts[productIndex].name,
//                                       subTitle: state.relatedProducts[productIndex].shortDescription,
//                                       price: state.relatedProducts[productIndex].price,
//                                       offerPrice: state.relatedProducts[productIndex].offerPrice,
//                                       slug: state.relatedProducts[productIndex].slug ?? "",
//                                       // isSelected: itemIndex == 0 || itemIndex == 3 || itemIndex == 4, slug: '',
//                                     ),
//                                   );
//                                 } else{
//                                   return Container();
//                                 }
//                               }
//                                                       ),
//                             );
//                       }
//                     }
//                   } else{
//                     return const Center(child: Text("Data Not Found!"));
//                   }
//                 }
//             ),
//           );
//         }
//     );
//   }
// }

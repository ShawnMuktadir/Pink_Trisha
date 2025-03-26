// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pink_by_trisha_app/global/widget/global_image_loader.dart';
// import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
// import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/filter_page.dart';
// import 'package:pink_by_trisha_app/utils/extension.dart';
// import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
// import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';
// import '../../../../product/controller/product_list_controller.dart';
// import '../../../controller/product_details_controller.dart';

// class RelatedProductSearch extends StatefulWidget {
//   final int categoryId;
//   const RelatedProductSearch({
//     Key? key,
//     required this.categoryId
//   }) : super(key: key);

//   @override
//   State<RelatedProductSearch> createState() => _RelatedProductSearchState();
// }

// class _RelatedProductSearchState extends State<RelatedProductSearch> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//         builder: (context, ref, child){
//           final controller = ref.read(productDetailsController.notifier);
//           final productController = ref.read(productListController.notifier);
//           final state = ref.watch(productDetailsController);

//           return Padding(
//             padding: EdgeInsets.symmetric(
//               vertical: 10.h,
//               horizontal: 20.w,
//             ),
//             child: Container(
//               height: 48.h,
//               width: context.width,
//               padding: EdgeInsets.only(left: 16.w, right: 6.w),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12.r),
//                 color: KColor.white.color,
//               ),
//               child: Row(
//                 children: [
//                   GlobalSvgLoader(
//                     imagePath: KAssetName.icSearchsvg.imagePath,
//                     height: 24.h,
//                     width: 24.h,
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10.w),
//                       child: TextField(
//                         controller: state.productController.searchCon,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintText: "Search Product",
//                         ),
//                         textInputAction: TextInputAction.search,
//                         onSubmitted: (val)async{
//                           await productController.getProductListResponse(
//                               take: 10, skip: 0, context: context);
//                           // await controller.getRelatedProductsResponse(categoryId: widget.categoryId);
//                         },
//                         onChanged: (val) async{
//                           await productController.getProductListResponse(
//                               take: 10, skip: 0, context: context);
//                           // await controller.getRelatedProductsResponse(categoryId: widget.categoryId);
//                         },
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       showAlertFilterDialogue(context);
//                     },
//                     child: GlobalImageLoader(
//                       imagePath: KAssetName.icFilterpng.imagePath,
//                       height: 36.h,
//                       width: 40.w,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         }
//     );
//   }
// }

// void showAlertFilterDialogue(BuildContext context) {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: true,
//     barrierLabel: "ljkl",
//     pageBuilder: (_, __, ___) {
//       return Padding(
//         padding: const EdgeInsets.only(left: 30),
//         child: Material(
//           color: Colors.transparent, // Set the color to transparent
//           child: Container(
//             height: double.infinity,
//             width: MediaQuery.of(context).size.width,
//             color: Colors.white,
//             child: const FilterPage(),
//           ),
//         ),
//       );
//     },
//   );
// }

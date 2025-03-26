import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/method/datetime_formated.dart';
import 'package:pink_by_trisha_app/global/widget/global_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_container.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/my_order/model/my_order_model.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/styles/styles.dart';

class OrderCard extends StatelessWidget {
  final MyOrderData orderData;
  const OrderCard({super.key, required this.orderData});
  @override
  Widget build(BuildContext context) {
    return GlobalContainer(
        width: double.infinity,
        borderRadius: 8.r,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Center(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Order ID:',
                            style: KTextStyle.customTextStyle(
                              color: KColor.deepGrey.color,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 0.09,
                            ),
                          ),
                          TextSpan(
                            text: ' #${orderData.id ?? ''}',
                            style: KTextStyle.customTextStyle(
                              color: KColor.deep2.color,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 0.09,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'BDT ${orderData.subTotal}',
                      textAlign: TextAlign.right,
                      style: KTextStyle.customTextStyle(
                        color: KColor.deep2.color,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        height: 0.09,
                      ),
                    )
                  ],
                ),
                const VerticalSpace(
                  height: 6,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Status:',
                              style: KTextStyle.customTextStyle(
                                color: KColor.deepGrey.color,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                height: 0.09,
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                              style: KTextStyle.customTextStyle(
                                color: KColor.deep2.color,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                height: 0.09,
                              ),
                            ),
                            TextSpan(
                              text: orderData.status ?? '',
                              style: KTextStyle.customTextStyle(
                                color: KColor.deepPrimary.color,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                height: 0.09,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const VerticalSpace(
                        height: 8,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Date: ',
                              style: KTextStyle.customTextStyle(
                                color: KColor.deepGrey.color,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                height: 0.09,
                              ),
                            ),
                            TextSpan(
                              text: DateTimeFormatter.showDateOnly.format(
                                      DateTime.parse(
                                          orderData.createdAt ?? '')) ??
                                  '',
                              style: KTextStyle.customTextStyle(
                                color: KColor.deep2.color,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                height: 0.09,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
            Positioned(
                right: 0,
                bottom: 0,
                child: GlobalButton(
                  btnHeight: 32,
                  onPressed: () {
                    Navigation.push(context,
                        appRoutes: AppRoutes.orderDetails,
                        arguments: orderData.id.toString());
                  },
                  buttonText: "View Order",
                  textFontSize: 14,
                  textFontWeight: FontWeight.w600,
                  padding: const EdgeInsets.all(0),
                  textFontHeight: 0.08,
                ))
          ],
        ));
  }
}

// class OrderCardText extends StatelessWidget {
//   const OrderCardText({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text.rich(
//               TextSpan(
//                 children: [
//                   TextSpan(
//                     text: 'Order ID:',
//                     style: KTextStyle.customTextStyle(
//                       color: KColor.deepGrey.color,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       height: 0.09,
//                     ),
//                   ),
//                   TextSpan(
//                     text: ' #2467905',
//                     style: KTextStyle.customTextStyle(
//                       color: KColor.deep2.color,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       height: 0.09,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Text(
//               '\$25000',
//               textAlign: TextAlign.right,
//               style: KTextStyle.customTextStyle(
//                 color: KColor.deep2.color,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//                 height: 0.09,
//               ),
//             )
//           ],
//         ),
//         const VerticalSpace(
//           height: 6,
//         ),
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text.rich(
//                 TextSpan(
//                   children: [
//                     TextSpan(
//                       text: 'Status:',
//                       style: KTextStyle.customTextStyle(
//                         color: KColor.deepGrey.color,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         height: 0.09,
//                       ),
//                     ),
//                     TextSpan(
//                       text: ' ',
//                       style: KTextStyle.customTextStyle(
//                         color: KColor.deep2.color,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         height: 0.09,
//                       ),
//                     ),
//                     TextSpan(
//                       text: 'Delivered',
//                       style: KTextStyle.customTextStyle(
//                         color: KColor.deepPrimary.color,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         height: 0.09,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const VerticalSpace(
//                 height: 8,
//               ),
//               Text.rich(
//                 TextSpan(
//                   children: [
//                     TextSpan(
//                       text: 'Date:',
//                       style: KTextStyle.customTextStyle(
//                         color: KColor.deepGrey.color,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         height: 0.09,
//                       ),
//                     ),
//                     TextSpan(
//                       text: ' 23/09/23',
//                       style: KTextStyle.customTextStyle(
//                         color: KColor.deep2.color,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         height: 0.09,
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

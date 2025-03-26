// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pink_by_trisha_app/global/widget/global_back_button.dart';
// import 'package:pink_by_trisha_app/global/widget/global_background.dart';
// import 'package:pink_by_trisha_app/global/widget/global_space.dart';
// import 'package:pink_by_trisha_app/global/widget/global_text.dart';
// import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/f_a_q/components/question_dropdown.dart';
// import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

// class FAQScreen extends StatefulWidget {
//   const FAQScreen({super.key});

//   @override
//   State<FAQScreen> createState() => _FAQScreenState();
// }

// class _FAQScreenState extends State<FAQScreen> {

//   bool isClick = false;

//   @override
//   Widget build(BuildContext context) {
//     return GlobalBackground(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const GlobalBackButton(title: "FAQ"),
//           const SizedBox(height: 15),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 5, right: 24, left: 24),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const GlobalText(
//                           str: 'Have questions?',
//                           color: Colors.black,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           height: 0.09,
//                         ),
//                         VerticalSpace(
//                           height: 8.h,
//                         ),
//                         const GlobalText(
//                           str: 'We are always here for you',
//                           color: Colors.black,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           height: 0.10,
//                         ),
//                         VerticalSpace(
//                           height: 4.h,
//                         ),
//                         GlobalText(
//                           str: 'You can find answers asked by other people. Or can contact us through phone!',
//                           color: KColor.deepGrey.color,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           height: 0.10,
//                         ),
//                       ],
//                     ),
//                   ),
//                   ListView.builder(
//                     itemCount: 5,
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemBuilder: (ctx, index){
//                         return QuestionAndAnswer(
//                           question: questionText,
//                           answer: answerText,
//                           isExpanded: isClick,
//                         );
//                       }
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// const String questionText = "How do I Cancel My Order";
// const String answerText =
//     "As a customer, you can cancel your order before the delivery cut-off time. Payment will be refunded. Orders can't be canceled during delivery. If deliveries are delayed, rescheduling or cancellation options are available.";

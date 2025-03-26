import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_bordered_container.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.title,
    required this.iconName,
    required this.borderColor
  });

  final String title;
  final String iconName;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return GlobalBorderedContainer(
        height: 60,
        borderColor: borderColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlobalSvgLoader(width: 24, height: 24, imagePath: iconName),
            const HorizontalSpace(
              width: 8,
            ),
            GlobalText(
              str: title,
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              height: 0.09,
            ),
          ],
        ));
  }
}


// class CategoryCard extends StatefulWidget {
//   CategoryCard({
//     super.key,
//     required this.title,
//     required this.iconName,
//     required this.isSelect,
//     required this.isSelectValue
//   });
//
//   final String title;
//   final String iconName;
//   String isSelect;
//   final String isSelectValue;
//
//   @override
//   State<CategoryCard> createState() => _CategoryCardState();
// }
//
// class _CategoryCardState extends State<CategoryCard> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     print('Build - isSelect: ${widget.isSelect}, widget.isSelectValue: ${widget.isSelectValue}');
//     return Padding(
//       padding: const EdgeInsets.only(
//         top: 16.0,
//       ),
//       child: GestureDetector(
//         onTap: (){
//           print('isSelect: ${widget.isSelect}, widget.isSelectValue: ${widget.isSelectValue}');
//           setState(() {
//             widget.isSelect = widget.isSelectValue;
//           });
//         },
//         child: GlobalBorderedContainer(
//             height: 60,
//             // borderColor: isSelect == widget.isSelectValue ? KColor.primary.color : KColor.transparent.color,
//             borderColor: widget.isSelect == widget.isSelectValue ? Colors.pink : Colors.transparent,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GlobalSvgLoader(width: 24, height: 24, imagePath: widget.iconName),
//                 const HorizontalSpace(
//                   width: 8,
//                 ),
//                 GlobalText(
//                   str: widget.title,
//                   color: Colors.black,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                   height: 0.09,
//                 ),
//               ],
//             )),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/controller/product_list_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/filter_title.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class FilterPrice extends StatelessWidget {
  const FilterPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller = ref.read(productListController.notifier);
        final state = ref.watch(productListController);
        return Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilterTitle(
                title: "Price",
              ),
              Row(
                children: [
                  MinMaxBox(
                    title: "Min",
                    textEditingController: state.minPriceCon,
                  ),
                  HorizontalSpace(
                    width: 12,
                  ),
                  MinMaxBox(
                    title: "Max",
                    textEditingController: state.maxPriceCon,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class MinMaxBox extends StatefulWidget {
  const MinMaxBox(
      {Key? key, required this.title, required this.textEditingController})
      : super(key: key);
  final String title;
  final TextEditingController textEditingController;

  @override
  _MinMaxBoxState createState() => _MinMaxBoxState();
}

class _MinMaxBoxState extends State<MinMaxBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 36,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: KColor.deep3.color,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      padding: const EdgeInsets.only(left: 12),
      child: Center(
        child: TextField(
          controller: widget.textEditingController,
          keyboardType:
              TextInputType.number, // Adjust the keyboard type if needed
          decoration: InputDecoration(
            hintText: widget.title, // Use title as hint text
            hintStyle: TextStyle(
              color: KColor.deep3.color,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
            // contentPadding: EdgeInsets.symmetric(vertical: 8),
          ),
          style: TextStyle(
            color: Colors.black, // Adjust text color if needed
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          textAlignVertical: TextAlignVertical.center,
        ),
      ),
    );
  }
}

// class MinMaxBox extends StatelessWidget {
//   const MinMaxBox({super.key, required this.title});
//   final String title;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 120,
//       height: 36,
//       decoration: ShapeDecoration(
//         shape: RoundedRectangleBorder(
//           side: BorderSide(
//             width: 1,
//             color: KColor.deep3.color,
//           ),
//           borderRadius: BorderRadius.circular(4),
//         ),
//       ),
//       padding: const EdgeInsets.only(
//         // top: 11,
//         left: 12,
//         //  bottom: 9,
//       ),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: GlobalText(
//           str: title,
//           color: KColor.deep3.color,
//           fontSize: 12,
//           fontWeight: FontWeight.w400,
//           height: 0.11,
//         ),
//       ),
//     );
//     ;
//   }
// }

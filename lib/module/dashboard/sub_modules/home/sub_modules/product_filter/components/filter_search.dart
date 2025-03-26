import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/filter_page.dart';
import 'package:pink_by_trisha_app/utils/styles/styles.dart';

class FilterSearch extends StatelessWidget {
  const FilterSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      width: 240,
      //   height: 45,
      decoration: BoxDecoration(
        color: KColor.searchBackg.color,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search Product",
                  contentPadding: EdgeInsets.zero,
                  hintStyle: KTextStyle.customTextStyle(
                    color: KColor.deep3.color,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 0.16,
                  )),
            ),
          ),
          GlobalSvgLoader(
            imagePath: KAssetName.icSearchSmallsvg.imagePath,
            height: 16.h,
            width: 16.w,
          ),
        ],
      ),
    );
  }
}

void showAlertFilterDialogue(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "ljkl",
    pageBuilder: (_, __, ___) {
      return Dialog(
        alignment: Alignment.topRight,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: FilterPage(),
        ),
      );
    },
  );
}

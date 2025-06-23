import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_image_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_categories/model/category_response.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/model/screen_source_data.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import '../../../../../utils/styles/k_colors.dart';
import '../../home/components/home_categories/controller/category_controller.dart';

class CategoryListSection extends StatefulWidget {
  const CategoryListSection({super.key});

  @override
  State<CategoryListSection> createState() => _CategoryListSectionState();
}

class _CategoryListSectionState extends State<CategoryListSection> {
  @override
  void initState() {
    super.initState();
    final controller = context.read(categoryController.notifier);
    Future(() async {
      await controller.getCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final controller = ref.read(categoryController.notifier);
      final state = ref.watch(categoryController);

      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: state.isLoading
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
              )
            : state.cateAllData.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GlobalText(
                        str: "No Category found",
                        color: KColor.deepGrey.color,
                      ),
                    ),
                  )
                : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.builder(
                      //padding: const EdgeInsets.symmetric(vertical: 6),
                      itemCount: state.cateAllData.length,
                      shrinkWrap: false,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.85, // Control width:height ratio
                      ),
                      itemBuilder: (context, index) {
                        return CategoryItem(state.cateAllData[index]);
                      },
                    ),
                ),
      );
    });
  }
}

class CategoryItem extends StatelessWidget {
  final CategoryData categoryData;

  const CategoryItem(this.categoryData, {super.key});

  @override
  Widget build(BuildContext context) {
    final image = categoryData.imageUrl;

    return GestureDetector(
      onTap: () {
        Navigation.push(
          context,
          appRoutes: AppRoutes.product,
          arguments: ScreenSourceData(
            sourceType: SourceType.category,
            sourceId: categoryData.id,
            sourceName: categoryData.name,
          ),
        );
      },
      child: Container(
        width: 100.h,
        height: 140,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Stack(
            children: [
              /// Title
              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: GlobalText(
                  str: categoryData.name ?? '',
                  color: const Color(0xFF2C2328),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              ),

              /// SVG Background
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: GlobalSvgLoader(
                    imagePath: KAssetName.icCategoryBackgroundsvg.imagePath,
                    fit: BoxFit.fitHeight,
                    height: 80,
                  ),
                ),
              ),

              /// Foreground Image
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: GlobalImageLoader(
                    imagePath: image ?? KAssetName.icEmptyImage2png.imagePath,
                    imageFor: image != null ? ImageFor.network : ImageFor.asset,
                    height: 74,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ],
          ),
        ),
      )
      ,
    );
  }
}

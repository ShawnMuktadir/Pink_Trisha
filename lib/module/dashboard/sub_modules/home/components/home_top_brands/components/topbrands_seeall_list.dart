import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/model/screen_source_data.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';

import '../../../../../../../global/widget/global_bordered_container.dart';
import '../../../../../../../utils/styles/k_colors.dart';
import '../controller/brand_controller.dart';

class TopBrandsSeeAllList extends StatefulWidget {
  const TopBrandsSeeAllList({super.key});

  @override
  State<TopBrandsSeeAllList> createState() => _TopBrandsSeeAllListState();
}

class _TopBrandsSeeAllListState extends State<TopBrandsSeeAllList> {
  // int selectIndex = 0;

  @override
  void initState() {
    super.initState();
    final controller = context.read(brandController.notifier);
    Future(() async {
      await controller.getBrand();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final controller = ref.read(brandController.notifier);
      final state = ref.watch(brandController);
      return Expanded(
        child: GridView.builder(
            itemCount: state.topBrandsList.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 16, mainAxisExtent: 76),
            itemBuilder: (ctx, index) {
              final brand = state.topBrandsList[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        state.selectIndex = index;
                      });
                      Navigation.push(context,
                          appRoutes: AppRoutes.product,
                          arguments: ScreenSourceData(
                              sourceType: SourceType.brand,
                              sourceId: brand.id,
                              sourceName: brand.name));
                    },
                    child: Padding(
                        padding: EdgeInsets.only(top: index.isOdd ? 16 : 0),
                        child: GlobalBorderedContainer(
                            height: 60,
                            borderColor: state.selectIndex == index
                                ? KColor.primary.color
                                : Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                    '${state.topBrandsList[index].imageUrl}',
                                    height: 24.h,
                                    width: 102.w),
                                // const HorizontalSpace(
                                //   width: 8,
                                // ),
                                // GlobalText(
                                //   str: '${state.topBrandsList[index].name}',
                                //   color: Colors.black,
                                //   fontSize: 18,
                                //   fontWeight: FontWeight.w500,
                                //   height: 0.09,
                                // ),
                              ],
                            ))),
                  ),
                ],
              );
            }),
      );
    });
  }
}

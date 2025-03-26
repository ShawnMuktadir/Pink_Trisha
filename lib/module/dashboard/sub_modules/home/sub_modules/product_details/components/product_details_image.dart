import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_image_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_product_card.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/controller/product_details_controller.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/styles/styles.dart';

class ImageSwiper extends StatefulWidget {
  const ImageSwiper({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<ImageSwiper> createState() => _ImageSwiperState();
}

class _ImageSwiperState extends State<ImageSwiper> {
  int currentIndex = 0;

  // late List<ProductDetailsImage>? images;
  // final String? selectedImage;
  // final dynamic discount;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        print("_ImageSwiperState called 1");
        final controller =
            ref.read(productDetailsController(widget.id).notifier);
        final state = ref.watch(productDetailsController(widget.id));
        if (state.variantArgument != null &&
            state.productDetailsData?.productImages != null) {
          currentIndex =
              state.productDetailsData!.productImages!.indexWhere((element) {
            print(
                "_ImageSwiperState called ${element.src}  $currentIndex ${state.variantArgument?.imageUrl}");
            return element.src == state.variantArgument?.imageUrl;
          });
        }
        print("_ImageSwiperState called index $currentIndex");
        return Padding(
          padding: const EdgeInsets.only(top: 30, right: 24, left: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: GestureDetector(
                      onTap: () {
                        Navigation.pop(context);
                      },
                      child: GlobalSvgLoader(
                          imagePath: KAssetName.icArrowBacksvg.imagePath),
                    ),
                  ),
                  state.productDetailsData?.offerPrice != 0 &&
                          state.productDetailsData?.price != null &&
                          state.productDetailsData?.offerPrice != null
                      ? DiscountShow(
                          saveTk: calculateSaveTk(
                              state.productDetailsData?.price!,
                              state.productDetailsData?.offerPrice!),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WhiteCircleButton(
                      onTap: () {
                        decrementIndex();
                      },
                      assetName: KAssetName.icArrowLeftsvg.imagePath),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 12, right: 16, left: 16),
                      child: GlobalImageLoader(
                        imageFor: state.productDetailsData!.productImages ==
                                    null ||
                                state.productDetailsData!.productImages!.isEmpty
                            ? ImageFor.asset
                            : ImageFor.network,
                        imagePath:
                            state.productDetailsData!.productImages!.isNotEmpty
                                ? state.productDetailsData!
                                    .productImages![currentIndex].src
                                : KAssetName.icEmptyImage2png.imagePath,
                        height: 220,
                        width: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  WhiteCircleButton(
                      onTap: () {
                        incrementIndex(
                            state.productDetailsData!.productImages!.length);
                      },
                      assetName: KAssetName.icArrowRightsvg.imagePath),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void incrementIndex(int length) {
    final newIndex = currentIndex + 1;

    setState(() {
      currentIndex = newIndex <= length - 1 ? newIndex : currentIndex;
    });
  }

  void decrementIndex() {
    final newIndex = currentIndex - 1;

    setState(() {
      currentIndex = newIndex >= 0 ? newIndex : currentIndex;
    });
  }
}

class WhiteCircleButton extends StatelessWidget {
  final String assetName;
  final VoidCallback? onTap;

  const WhiteCircleButton({
    super.key,
    required this.assetName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: CircleBorder(),
        ),
        child: Center(
          child: GlobalSvgLoader(
            width: 21.33,
            height: 21.33,
            imagePath: assetName,
          ),
        ),
      ),
    );
  }
}

class DiscountBox extends StatelessWidget {
  const DiscountBox({super.key, required this.discount});

  final int discount;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Container(
          width: 67.w,
          height: 25.h,
          padding: const EdgeInsets.symmetric(horizontal: 6.08, vertical: 2.43),
          decoration: ShapeDecoration(
            color: KColor.backgroundDeep.color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GlobalText(
                str: '$discount% OFF',
                textAlign: TextAlign.center,
                color: Colors.white,
                fontSize: 10,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
                height: 0.12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

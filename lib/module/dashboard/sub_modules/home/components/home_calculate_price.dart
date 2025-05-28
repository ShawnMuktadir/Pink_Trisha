import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_image_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_review_price.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/controller/home_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/model/home_country_response.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

import '../../../../../utils/currency_country_util.dart';

//final List<String> countries = [];
// final countries = ["BAN", "USA", "UAE"];

class HomeCalculatePrice extends ConsumerWidget {
  const HomeCalculatePrice({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final state = ref.watch(homeController);
        final controller = ref.read(homeController.notifier);

        return Container(
          width: context.width,
          margin: EdgeInsets.only(top: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: const GlobalText(
                  str: "Calculate Your Product Price",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 0.09,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                width: context.width,
                margin: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 5.h,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 20.h,
                ),
                decoration: BoxDecoration(
                  color: KColor.white.color,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GlobalText(
                          str: "Select Country :",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 0.11,
                        ),
                        //  Spacer(),
                        CountrySelection()
                      ],
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    const GlobalText(
                      str: "Select Product Type",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 0.10,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    const ProductTypeSelection(),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      children: [
                        const GlobalText(
                          str: "Product Link",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 0.10,
                        ),
                        GlobalText(
                          str: "*",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: KColor.red.color,
                          height: 0.10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    SizedBox(
                      // height: 48.h,
                      child: Center(
                          child: TextField(
                        enabled: state.reviewPriceResponse == null,
                        controller: state.productLinkCon,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: KColor.border2.color),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: KColor.border2.color),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: KColor.primary.color),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    const ProductPriceField(),
                    SizedBox(
                      height: 12.h,
                    ),
                    const SellerShippingFeeField(),
                    SizedBox(
                      height: 12.h,
                    ),
                    const WeightField(),
                    SizedBox(
                      height: 12.h,
                    ),
                    //dimension
                    DimensionField(),
                    SizedBox(
                      height: 25.h,
                    ),
                    state.reviewPriceResponse == null
                        ? GlobalButton(
                            isLoading: state.isCalculateBtnLoading,
                            onPressed: () {
                              controller.reqHomePriceCalculation(context);
                            },
                            buttonText: "Calculate")
                        : const SizedBox(),
                    state.priceCalculationData != null
                        ? const HomeReviewPrice()
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DimensionField extends StatefulWidget {
  const DimensionField({super.key});

  @override
  State<DimensionField> createState() => _DimensionFieldState();
}

class _DimensionFieldState extends State<DimensionField> {
  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;
  bool hasFocus = false;

  @override
  void initState() {
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode1.addListener(() {
      update();
    });
    focusNode2.addListener(() {
      update();
    });
    focusNode3.addListener(() {
      update();
    });
    super.initState();
  }

  update() {
    hasFocus =
        focusNode1.hasFocus || focusNode2.hasFocus || focusNode3.hasFocus;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final state = ref.watch(homeController);
        final controller = ref.read(homeController.notifier);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GlobalText(
              str: "Dimension",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 0.10,
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              height: 48.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                border: Border.all(
                    color:
                        hasFocus ? KColor.primary.color : KColor.border2.color,
                    width: 1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                  child: Row(
                children: [
                  ShortTextField(
                    enabled: state.reviewPriceResponse == null,
                    textEditingController: state.dimensionLengthCon,
                    hint: "Length",
                    focusNode: focusNode1,
                    hasFocus: hasFocus,
                  ),
                  ShortTextField(
                    enabled: state.reviewPriceResponse == null,
                    textEditingController: state.dimensionWidthCon,
                    hint: "Width",
                    focusNode: focusNode2,
                    hasFocus: hasFocus,
                  ),
                  ShortTextField(
                    enabled: state.reviewPriceResponse == null,
                    textEditingController: state.dimensionHeightCon,
                    hint: "Height",
                    focusNode: focusNode3,
                    hasFocus: hasFocus,
                  ),
                  Expanded(
                    //    width: 50.w,
                    child: DropdownButtonFormField<String>(
                      value: state.dimensionUnit ?? state.dimensionUnits.first,
                      //      hint: const GlobalText(str: "Inc"),
                      items: state.dimensionUnits.map((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: GlobalText(str: unit),
                        );
                      }).toList(),
                      onChanged: state.reviewPriceResponse == null
                          ? (value) {
                              controller.onDimensionUnitDropdownChange(
                                  data: value);
                            }
                          : null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              )),
            )
          ],
        );
      },
    );
  }
}

class WeightField extends StatefulWidget {
  const WeightField({super.key});

  @override
  State<WeightField> createState() => _WeightFieldState();
}

class _WeightFieldState extends State<WeightField> {
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final state = ref.watch(homeController);
        final controller = ref.read(homeController.notifier);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GlobalText(
              str: "Weight",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 0.10,
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              height: 48.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                border: Border.all(
                    color: focusNode.hasFocus
                        ? KColor.primary.color
                        : KColor.border2.color,
                    width: 1),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Center(
                  child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: focusNode,
                      enabled: state.reviewPriceResponse == null,
                      controller: state.weightCon,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 10.w,
                      right: 12.w,
                    ),
                    width: 1.w,
                    color: focusNode.hasFocus
                        ? KColor.primary.color
                        : KColor.border2.color,
                  ),
                  SizedBox(
                    width: 55,
                    child: DropdownButtonFormField<String>(
                      value: state.weightUnit ?? state.weightUnits.first,
                      //   hint: GlobalText(str: ""),
                      items: state.weightUnits.map((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: GlobalText(str: unit),
                        );
                      }).toList(),
                      onChanged: state.reviewPriceResponse == null
                          ? (value) {
                              controller.onWeightUnitDropdownChange(
                                  data: value);
                            }
                          : null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              )),
            )
          ],
        );
      },
    );
  }
}

class SellerShippingFeeField extends StatefulWidget {
  const SellerShippingFeeField({super.key});

  @override
  State<SellerShippingFeeField> createState() => _SellerShippingFeeFieldState();
}

class _SellerShippingFeeFieldState extends State<SellerShippingFeeField> {
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final state = ref.watch(homeController);
        final controller = ref.read(homeController.notifier);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GlobalText(
              str: "Seller Shipping Fee",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 0.10,
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              height: 48.h,
              padding: const EdgeInsets.only(left: 10, right: 20),
              decoration: BoxDecoration(
                border: Border.all(
                    color: focusNode.hasFocus
                        ? KColor.primary.color
                        : KColor.border2.color,
                    width: 1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                  child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: focusNode,
                      enabled: state.reviewPriceResponse == null,
                      controller: state.sellerShippingFeeCon,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(0),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      right: 19.w,
                    ),
                    width: 1.w,
                    color: focusNode.hasFocus
                        ? KColor.primary.color
                        : KColor.border2.color,
                  ),
                  GlobalText(
                    str: state.selectedCountry?.currencyISOCode ?? "",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: KColor.grey.color,
                    height: 0.10,
                  ),
                ],
              )),
            )
          ],
        );
      },
    );
  }
}

class ProductPriceField extends StatefulWidget {
  const ProductPriceField({super.key});

  @override
  State<ProductPriceField> createState() => _ProductPriceFieldState();
}

class _ProductPriceFieldState extends State<ProductPriceField> {
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final state = ref.watch(homeController);
        final controller = ref.read(homeController.notifier);

        return Column(
          children: [
            Row(
              children: [
                const GlobalText(
                  str: "Product Price",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 0.10,
                ),
                GlobalText(
                  str: "*",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: KColor.red.color,
                  height: 0.10,
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              height: 48.h,
              padding: const EdgeInsets.only(left: 10, right: 20),
              decoration: BoxDecoration(
                border: Border.all(
                    color: focusNode.hasFocus
                        ? KColor.primary.color
                        : KColor.border2.color,
                    width: 1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                  child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: focusNode,
                      enabled: state.reviewPriceResponse == null,
                      controller: state.productPriceCon,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(0),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      right: 19.w,
                    ),
                    width: 1.w,
                    color: focusNode.hasFocus
                        ? KColor.primary.color
                        : KColor.border2.color,
                  ),
                  GlobalText(
                    str: state.selectedCountry?.currencyISOCode ?? "",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: KColor.grey.color,
                    height: 0.10,
                  ),
                ],
              )),
            )
          ],
        );
      },
    );
  }
}

class CountrySelection extends StatelessWidget {
  const CountrySelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final state = ref.watch(homeController);
        final controller = ref.read(homeController.notifier);

        return Container(
          width: 137,
          height: 30,
          decoration: ShapeDecoration(
            color: const Color(0xFFFBFBFF),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFEEF3F7)),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<CountryData>(
                    value: state.selectedCountry,
                    underline: Container(),
                    // Remove the default underline
                    icon: const Icon(Icons.arrow_drop_down,
                        color: Color(0xFF2C2328)),
                    style: const TextStyle(
                      color: Color(0xFFFBFBFF),
                    ),
                    isExpanded: true,
                    // Default value
                    items: state.countries.map((country) {
                      return DropdownMenuItem<CountryData>(
                        value: country,
                        child: Row(
                          children: [
                            GlobalImageLoader(
                              imagePath: getFlagUrl(country.currencyISOCode),
                              // must map properly
                              height: 16,
                              width: 24,
                              fit: BoxFit.cover,
                              imageFor: ImageFor.network,
                            ),
                            const SizedBox(width: 8),
                            GlobalText(
                              str: country.name ?? "",
                              color: KColor.deep2.color,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: state.reviewPriceResponse == null
                        ? (newValue) {
                            controller.onCountryDropdownChange(data: newValue);
                            if (newValue?.id != null) {
                              controller.getHomeProductTypesResponse(
                                  onDemandCountryId: newValue!.id!);
                            }
                            if (kDebugMode) {
                              print(newValue?.name ?? "");
                            }
                          }
                        : null,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String getFlagUrl(String? currencyCode) {
    final countryCode =
        currencyToCountryCode[currencyCode?.toUpperCase()] ?? 'us';
    return "https://flagcdn.com/w40/$countryCode.png";
  }
}

class ProductTypeSelection extends StatelessWidget {
  const ProductTypeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final state = ref.watch(homeController);
        final controller = ref.read(homeController.notifier);

        return SizedBox(
          child: Center(
            child: DropdownButtonFormField<CountryProductType>(
              padding: EdgeInsets.zero,
              value: state.selectedProductType,
              items: state.countryProductTypes.map((type) {
                return DropdownMenuItem<CountryProductType>(
                  value: type,
                  child: GlobalText(
                    str: type.name ?? "",
                    color: const Color(0xFF666465),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                );
              }).toList(),
              onChanged: state.reviewPriceResponse == null
                  ? (newValue) {
                      controller.onProductTypeDropdownChange(data: newValue);
                    }
                  : null,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: KColor.primary.color),
                    borderRadius: BorderRadius.circular(8)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: KColor.border2.color),
                    borderRadius: BorderRadius.circular(8)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: KColor.border2.color,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 0, horizontal: 10), // Adjust as needed
              ),
            ),
          ),
        );
      },
    );
  }
}

// class WeightSelection extends StatelessWidget {
//   const WeightSelection({super.key}); // Add your weight unit options here

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (_, WidgetRef ref, __) {
//         final state = ref.watch(homeController);
//         final controller = ref.read(homeController.notifier);
//         return
//       },
//     );
//   }
// }

// class DimensionSelection extends StatelessWidget {
//   const DimensionSelection({super.key}); // Add your weight unit options here

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (_, WidgetRef ref, __) {
//         final state = ref.watch(homeController);
//         final controller = ref.read(homeController.notifier);

//         return;
//       },
//     );
//   }
// }

class ShortTextField extends StatelessWidget {
  const ShortTextField({
    super.key,
    required this.textEditingController,
    required this.hint,
    required this.enabled,
    required this.focusNode,
    required this.hasFocus,
  });

  final TextEditingController textEditingController;
  final String hint;
  final bool enabled;
  final bool hasFocus;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: focusNode,
              enabled: enabled,
              keyboardType: TextInputType.number,
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: 16,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 10.w,
              right: 12.w,
            ),
            width: 1.w,
            color: hasFocus ? KColor.primary.color : KColor.border2.color,
          ),
        ],
      ),
    );
  }
}

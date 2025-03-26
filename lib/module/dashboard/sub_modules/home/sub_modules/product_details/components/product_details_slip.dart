import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/controller/product_details_controller.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class ProductDetailsSlip extends StatefulWidget {
  const ProductDetailsSlip(
      {super.key,
      required this.detailsDescription,
      required this.warrantyDescription,
      required this.returnPolicyDescription,
      required this.id});

  final int id;
  final String detailsDescription;
  final String warrantyDescription;
  final String returnPolicyDescription;

  @override
  State<ProductDetailsSlip> createState() => _ProductDetailsSlipState();
}

class _ProductDetailsSlipState extends State<ProductDetailsSlip> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller =
            ref.read(productDetailsController(widget.id).notifier);
        final state = ref.watch(productDetailsController(widget.id));

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            Stack(
              children: [
                Positioned(
                  bottom: 2,
                  child: Container(
                    height: 1.h,
                    width: MediaQuery.sizeOf(context).width,
                    margin: const EdgeInsets.only(left: 24),
                    color: const Color(0xFFC1C1C1),
                  ),
                ),
                SizedBox(
                  height: 55,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 1,
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            controller.scrollToTitle(index);

                            // state.slipPageController.animateToPage(index,
                            //     duration: const Duration(milliseconds: 300),
                            //     curve: Curves.easeInOut);

                            setState(() {
                              currentIndex = index;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 24, right: 100),
                                child: Center(
                                  child: GlobalText(
                                    str: state.pageTitles[index],
                                    color: currentIndex == index
                                        ? KColor.deep2.color
                                        : KColor.deep3.color,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    height: 0.09,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 26),
                              Container(
                                height: 4,
                                width: 55,
                                margin:
                                    const EdgeInsets.only(left: 24, right: 70),
                                decoration: BoxDecoration(
                                    color: currentIndex == index
                                        ? KColor.deepPrimary.color
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10)),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
            Container(child: state.pages[state.currentSlipPageIndex]
                //height: 400,
                // height: widget.detailsDescription.length * .61,

                ),
          ],
        );
      },
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller = ref.read(productDetailsController(id).notifier);
        final state = ref.watch(productDetailsController(id));
        return Padding(
          padding: const EdgeInsets.only(top: 26, bottom: 28, left: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state.productDetailsData!.longDescription != null &&
                      state.productDetailsData!.longDescription!.isNotEmpty
                  ? Html(
                      data: _cleanHtml(
                          state.productDetailsData!.longDescription!),
                    )
                  : Center(
                      child: GlobalText(
                        str: 'Empty Data',
                        color: KColor.grey.color,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }

  /// **Helper function to clean the HTML content**
  String _cleanHtml(String html) {
    // Remove first and last quote if present
    if (html.startsWith('"') && html.endsWith('"')) {
      html = html.substring(1, html.length - 1);
    }

    // Replace unwanted escape characters
    return html.replaceAll("\\n", "").replaceAll("\\", "").trim();
  }
}

class ProductWarrantyPage extends StatelessWidget {
  const ProductWarrantyPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller = ref.read(productDetailsController(id).notifier);
        final state = ref.watch(productDetailsController(id));
        return Padding(
          padding: const EdgeInsets.only(top: 26, bottom: 28, left: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state.productDetailsData!.productWarranty != null &&
                      state.productDetailsData!.productWarranty!.isNotEmpty
                  ? HtmlWidget(
                      state.productDetailsData?.productWarranty ?? "",
                    )
                  : Center(
                      child: GlobalText(
                        str: 'Empty Data',
                        color: KColor.grey.color,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}

class ProductReturnPolicyPage extends StatelessWidget {
  const ProductReturnPolicyPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller = ref.read(productDetailsController(id).notifier);
        final state = ref.watch(productDetailsController(id));
        return Padding(
          padding: const EdgeInsets.only(top: 26, bottom: 28, left: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state.productDetailsData!.productReturnPolicy != null &&
                      state.productDetailsData!.productReturnPolicy!.isNotEmpty
                  ? HtmlWidget(
                      state.productDetailsData?.productReturnPolicy ?? "",
                    )
                  : Center(
                      child: GlobalText(
                        str: 'Empty Data',
                        color: KColor.grey.color,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}

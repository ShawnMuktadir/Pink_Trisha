import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';

class PaginationButtons extends StatefulWidget {
  final int totalCount;
  final int activeButton;
  final Function(int) onButtonPressed;
  final Function(int) onNextPage;
  final Function(int) onPreviousPage;

  const PaginationButtons({
    super.key,
    required this.totalCount,
    required this.activeButton,
    required this.onButtonPressed,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  @override
  State<PaginationButtons> createState() => _PaginationButtonsState();
}

class _PaginationButtonsState extends State<PaginationButtons> {
  // Track loaded pages to avoid redundant loading
  final Set<int> _loadedPages = {1};

  @override
  Widget build(BuildContext context) {
    int totalPages = (widget.totalCount / 15).ceil();
    List<Widget> buttons = [];

    int startPage = (widget.activeButton - 1).clamp(1, totalPages);
    int endPage = (startPage + 3).clamp(startPage, totalPages);

    for (int i = startPage; i <= endPage; i++) {
      buttons.add(
        PaginationButton(
          number: i,
          isActive: i == widget.activeButton,
          onPressed: () {
            print("totalPages: $totalPages");
            print("startPage: $startPage, endPage: $endPage");
            if (i > widget.activeButton) {
              widget.onNextPage(i);
            } else if (i < widget.activeButton) {
              widget.onPreviousPage(i);
            }
            _loadedPages.add(i); // Mark this page as loaded
            widget.onButtonPressed(i);
            // }
          },
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PaginationArrowButton(
            onTap: () {
              if (widget.activeButton > 1) {
                widget.onPreviousPage(widget.activeButton);
                widget.onButtonPressed(widget.activeButton - 1);
                _loadedPages.add(widget.activeButton - 1);
              }
            },
            isLeftArrow: true,
          ),
          ...buttons,
          PaginationArrowButton(
            onTap: () {
              if (widget.activeButton < totalPages) {
                widget.onNextPage(widget.activeButton);
                widget.onButtonPressed(widget.activeButton + 1);
                _loadedPages.add(widget.activeButton + 1);
              }
            },
            isLeftArrow: false,
          ),
        ],
      ),
    );
  }
}

class PaginationButton extends StatelessWidget {
  final int number;
  final bool isActive;
  final VoidCallback? onPressed;

  const PaginationButton({
    super.key,
    required this.number,
    this.isActive = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 30,
          height: 30,
          decoration: ShapeDecoration(
            color: isActive ? const Color(0xFFF553B0) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            shadows: isActive
                ? [
                    const BoxShadow(
                      color: Color(0x1926374A),
                      blurRadius: 60,
                      offset: Offset(0, 30),
                      spreadRadius: 5,
                    )
                  ]
                : null,
          ),
          child: Center(
            child: GlobalText(
              str: number == -1 ? '..' : number.toString(),
              color: isActive ? Colors.white : const Color(0xFF666465),
              fontSize: isActive ? 12 : 14,
              fontFamily: 'Poppins',
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }
}

class PaginationArrowButton extends StatelessWidget {
  const PaginationArrowButton(
      {super.key, required this.isLeftArrow, required this.onTap});
  final bool isLeftArrow;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          shadows: isLeftArrow
              ? [
                  const BoxShadow(
                    color: Color(0x1926374A),
                    blurRadius: 60,
                    offset: Offset(0, 30),
                    spreadRadius: 5,
                  )
                ]
              : null,
        ),
        child: Center(
          child: GlobalSvgLoader(
              height: 10.h,
              width: 10.w,
              imagePath: isLeftArrow
                  ? KAssetName.icArrowLeftsvg.imagePath
                  : KAssetName.icArrowRightsvg.imagePath),
        ),
      ),
    );
  }
}

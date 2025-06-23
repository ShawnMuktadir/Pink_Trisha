import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';

import '../../utils/styles/styles.dart';
import 'global_text.dart';

class GlobalButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool isRounded;
  final bool isEnabled;
  final double? btnWidth;
  final double? btnHeight;
  final int roundedBorderRadius;
  final Color? btnBackgroundActiveColor;
  final double? textFontSize;
  final FontWeight? textFontWeight;
  final double? textFontHeight;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final bool isPlusButton;
  final bool isLoading;

  const GlobalButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.isRounded = true,
    this.isLoading = false,
    this.isEnabled = true,
    this.btnWidth,
    this.roundedBorderRadius = 8,
    this.btnBackgroundActiveColor,
    this.textFontSize,
    this.padding,
    this.isPlusButton = false,
    this.textFontWeight,
    this.textFontHeight,
    this.textColor,
    this.btnHeight,
  });

  @override
  Widget build(BuildContext context) {
    Color btnColor = btnBackgroundActiveColor ?? KColor.accent.color;

    return SizedBox(
      width: btnWidth ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
            (states) {
              return RoundedRectangleBorder(
                borderRadius: isRounded
                    ? BorderRadius.circular(
                        roundedBorderRadius.r,
                      )
                    : BorderRadius.zero,
              );
            },
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) =>
                onPressed != null ? btnColor : KColor.divider.color,
          ),
          elevation: WidgetStateProperty.resolveWith(
            (states) => 0.0,
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(12),
          child: isLoading
              ? SizedBox(
                  height: textFontSize != null ? (textFontSize! + 4) : 22,
                  width: textFontSize != null ? (textFontSize! + 4) : 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: textColor ?? KColor.white.color,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (isPlusButton)
                      GlobalSvgLoader(
                        imagePath: KAssetName.icPlusWhitesvg.imagePath,
                        width: 24.w,
                        height: 24.h,
                      ),
                    //if (isPlusButton) const SizedBox(width: 8),
                    Flexible(
                      child: GlobalText(
                        str: buttonText,
                        fontWeight: textFontWeight ?? FontWeight.w600,
                        fontSize: textFontSize ?? 14,
                        color: textColor ?? KColor.white.color,
                        height: textFontHeight ?? 0.09,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

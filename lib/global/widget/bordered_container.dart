import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class BorderedContainer extends StatelessWidget {
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final Color backgroundColor;
  final double? width;
  final double? height;
  final Color? borderColor;

  const BorderedContainer({
    super.key,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(11),
    required this.child,
    this.width,
    this.height,
    this.backgroundColor = Colors.white,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor ?? KColor.border.color),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(child: child),
    );
  }
}

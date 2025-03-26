import 'package:flutter/material.dart';

class GlobalBorderedContainer extends StatelessWidget {
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  final Color backgroundColor;
  final double? width;
  final double? height;
  final Color borderColor;

  const GlobalBorderedContainer({
    Key? key,
    this.borderRadius = 16.0,
    this.padding,
    required this.child,
    this.width,
    this.height,
    this.backgroundColor = Colors.white,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: 1.0),
      ),
      child: child,
    );
  }
}

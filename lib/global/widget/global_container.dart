import 'package:flutter/material.dart';

class GlobalContainer extends StatelessWidget {
  final double borderRadius;
  final BorderRadius? borderCornerRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Widget child;
  final Color backgroundColor;
  final double? width;
  final double? height;
  final void Function()? onTap;
  const GlobalContainer({
    super.key,
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.all(20),
    this.margin = const EdgeInsets.all(0),
    required this.child,
    this.width,
    this.height,
    this.backgroundColor = Colors.white,
    this.borderCornerRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: onTap==null? padding:null,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderCornerRadius ?? BorderRadius.circular(borderRadius),
      ),
      child: onTap == null
          ? child
          : Material(
            color: backgroundColor,
              borderRadius:
                  borderCornerRadius ?? BorderRadius.circular(borderRadius),
              child: InkWell(
                  borderRadius:
                      borderCornerRadius ?? BorderRadius.circular(borderRadius),
                  onTap: () {
                    onTap!();
                  },
                  child: Padding(
                    padding: padding,
                    child: child,
                  ))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class GlobalBackground extends StatelessWidget {
  const GlobalBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          width: context.width,
          constraints: BoxConstraints(
            minHeight: context.height,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                KColor.homeGradientStart.color,
                KColor.homeGradientEnd.color,
              ],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

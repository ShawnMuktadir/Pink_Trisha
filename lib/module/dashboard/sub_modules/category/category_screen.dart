import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/category/components/category_back_button.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/category/components/category_list.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.fromPush});
  final bool fromPush;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            children: [
              CategoryBackButton(
                fromPush: fromPush,
              ),
              SizedBox(
                height: 20,
              ),
              CategoryListSection(),
            ],
          ),
        ),
      ),
    );
  }
}

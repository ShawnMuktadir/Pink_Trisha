import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

import 'top_brands_back_button.dart';
import 'topbrands_seeall_list.dart';

class TopBrandsSeeAll extends StatelessWidget {
  const TopBrandsSeeAll({Key? key}) : super(key: key);

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
          child: const Column(
            children: [
              TopBrandsBackButton(),
              TopBrandsSeeAllList(),
            ],
          ),
        ),
      ),
    );
  }
}

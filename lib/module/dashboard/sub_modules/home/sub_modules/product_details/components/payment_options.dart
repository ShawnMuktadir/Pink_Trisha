import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/global_double_circle.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class PaymentOptions extends StatefulWidget {
  const PaymentOptions({super.key});

  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  bool isPreorder = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 24),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isPreorder = true; // Toggle the selected state
              });
            },
            child: RowOption(
              label: 'Pre Order',
              isSelected: isPreorder,
            ),
          ),
          VerticalSpace(height: 21),
          GestureDetector(
            onTap: () {
              setState(() {
                isPreorder = false; // Toggle the selected state
              });
            },
            child: RowOption(
              label: 'Full Payment',
              isSelected: !isPreorder, // Inverse of isPreorder
            ),
          ),
        ],
      ),
    );
  }
}

class RowOption extends StatelessWidget {
  final String label;
  final bool isSelected;

  const RowOption({
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GlobalDoubleCircle(
          color: isSelected ? KColor.deepPrimary.color : Color(0xFF666465),
        ),
        HorizontalSpace(width: 10),
        GlobalText(
          str: label,
          color: isSelected ? Color(0xFF2F80ED) : Color(0xFF2F80ED),
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          height: 0.09,
        )
      ],
    );
  }
}

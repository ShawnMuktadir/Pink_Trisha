import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_in/controller/signin_controller.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class BigTitle extends StatelessWidget {
  final String text;
  final double fontSize;

  const BigTitle(this.text, {super.key, this.fontSize = 24});

  @override
  Widget build(BuildContext context) {
    return GlobalText(
      str: text,
      fontSize: fontSize,
      color: KColor.deep.color,
      height: 0.06,
      textAlign: TextAlign.center,
    );
  }
}

class LineText extends StatelessWidget {
  final String text;

  const LineText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Line()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GlobalText(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: KColor.grey.color,
            str: text,
            fontFamily: 'Nunito Sans',
            height: 0,
            letterSpacing: 0.42,
            textAlign: TextAlign.center,
          ),
        ),
        const Expanded(child: Line()),
      ],
    );
  }
}

class Line extends StatelessWidget {
  const Line({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.7,
      color: KColor.line.color,
    );
  }
}

class CheckIcon extends StatefulWidget {
  const CheckIcon({super.key});

  @override
  State<CheckIcon> createState() => _CheckIconState();
}

class _CheckIconState extends State<CheckIcon> {
  // bool isSelect = true;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (ctx, ref, child) {
      final controller = ref.read(signInController.notifier);
      return GestureDetector(
        onTap: () {
          setState(() {
            controller.isSelect = !controller.isSelect;
            print(controller.isSelect);
          });
        },
        child: Container(
          width: 16.0,
          height: 16.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: controller.isSelect == true
                  ? const Color(0xFF00BE7E)
                  : Colors.transparent,
              border: Border.all(
                width: 1,
                color: controller.isSelect == false
                    ? Colors.grey
                    : Colors.transparent,
              )),
          child: controller.isSelect == true
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 12.0,
                )
              : const SizedBox.shrink(),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/styles/styles.dart';

class QuestionAndAnswer extends StatefulWidget {
  QuestionAndAnswer(
      {super.key,
      required this.question,
      required this.answer,
      required this.isExpanded});
  final String question;
  final String answer;
  late bool isExpanded;

  @override
  State<QuestionAndAnswer> createState() => _QuestionAndAnswerState();
}

class _QuestionAndAnswerState extends State<QuestionAndAnswer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 16, right: 24, left: 24),
        child: Container(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: KColor.border2.color),
              borderRadius: BorderRadius.circular(8),
            ),
            shadows: [
              BoxShadow(
                color: KColor.deep5.color,
                blurRadius: 3,
                offset: const Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              // Question(
              //   question: question,
              //   isExpanded: isExpanded,
              // ),
              Padding(
                padding: EdgeInsets.only(
                    top: 14, right: 16, left: 14, bottom: widget.isExpanded ? 12 : 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GlobalText(
                      str: widget.question,
                      color: KColor.deep2.color,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 0.10,
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          widget.isExpanded = !widget.isExpanded;
                        });
                      },
                      child: GlobalSvgLoader(
                          height: 20,
                          width: 20,
                          imagePath: widget.isExpanded == true
                              ? KAssetName.icArrowUpsvg.imagePath
                              : KAssetName.icArrowDownsvg.imagePath),
                    )
                  ],
                ),
              ),
              widget.isExpanded
                  ? Answer(
                      answer: widget.answer,
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ));
  }
}

class Answer extends StatelessWidget {
  const Answer({super.key, required this.answer});
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18.18, left: 13.82, bottom: 16),
      child: GlobalText(
        str:
            'As a customer, you can cancel your order before the delivery cut-off time. Payment will be refunded. Orders can\'t be canceled during delivery. If deliveries are delayed, rescheduling or cancellation options are available.',
        textAlign: TextAlign.justify,
        color: KColor.deepGrey.color,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 0.11,
      ),
    );
  }
}

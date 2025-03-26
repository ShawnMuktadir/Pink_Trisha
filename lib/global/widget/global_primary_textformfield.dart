import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/global/widget/global_textformfield.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_in/views/components/auth_textformfield.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class GlobalPrimaryTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String title;
  final String hint;
  final TextInputType textInputType;
  final String? initialValue;
  final String? validationLabel;
  final bool? enabled;
  final bool isRequired;
  final Color? borderColor;
  const GlobalPrimaryTextFormField(
      {super.key,
      this.controller,
      required this.title,
      required this.hint,
      this.validationLabel,
      this.initialValue,
      this.enabled,
      required this.textInputType,
      this.isRequired = true,
      this.borderColor});

  @override
  State<GlobalPrimaryTextFormField> createState() =>
      _GlobalPrimaryTextFormFieldState();
}

class _GlobalPrimaryTextFormFieldState
    extends State<GlobalPrimaryTextFormField> {
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                GlobalText(
                  str: widget.title,
                  color: KColor.deep2.color,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 0.09,
                ),
                widget.isRequired
                    ? GlobalText(
                        str: "*",
                        color: KColor.deepPrimary.color,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 0.09,
                      )
                    : const SizedBox.shrink(),
              ],
            )),
        const SizedBox(
          height: 4,
        ),
        GlobalTextFormField(
            controller: widget.controller,
            hintText: widget.hint,
            initialValue: widget.initialValue,
            borderWidth: 1,
            validator: (value) {
              if (!widget.isRequired) return null;
              if (value == null || value.isEmpty) {
                return '${widget.validationLabel ?? widget.title} is required';
              }
              return null;
            },
            labelText: widget.hint,
            enabled: widget.enabled,
            textInputType: widget.textInputType,
            obscureText: widget.title == password && isObscureText,
            //  borderColor:borderColor ?? KColor.deep5.color,
            suffixIcon: widget.title == password
                ? IconButton(
                    onPressed: () {
                      isObscureText = !isObscureText;
                      setState(() {});
                    },
                    icon: isObscureText
                        ? const Icon(Icons.visibility_off_outlined)
                        : const Icon(Icons.visibility_outlined),
                  )
                : null),
      ],
    );
  }
}

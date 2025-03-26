import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';

import '../../utils/styles/k_colors.dart';
import '../../utils/styles/k_text_style.dart';

class GlobalTextFormField extends StatefulWidget {
  final bool? obscureText;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxlength;
  final AutovalidateMode? autovalidateMode;
  final bool? readOnly;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderWidth;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final bool? mandatoryLabel;
  final TextStyle? style;
  final int? line;
  final bool? enabled;
  final String? initialValue;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;

  const GlobalTextFormField({
    Key? key,
    this.obscureText,
    this.textInputType,
    this.controller,
    this.validator,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.maxlength,
    this.initialValue,
    this.autovalidateMode,
    this.readOnly,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.mandatoryLabel,
    this.labelStyle,
    this.line = 1,
    this.enabled,
    this.style,
    this.onChanged,
    this.textInputAction = TextInputAction.done,
    this.borderColor,
    this.borderWidth,
  }) : super(key: key);

  @override
  State<GlobalTextFormField> createState() => _GlobalTextFormFieldState();
}

class _GlobalTextFormFieldState extends State<GlobalTextFormField> {
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  bool isVisible = false;
  // bool isObsecure = true;
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  void validateField(String value) {
    if (widget.validator != null) {
      final currentState = _fieldKey.currentState;
      currentState?.validate();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _fieldKey,
      focusNode: _focusNode,
      initialValue: widget.initialValue,
      maxLines: widget.line,
      style: widget.style ??
          KTextStyle.customTextStyle(
            color: KColor.black.color,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 0.10,
          ),
      autovalidateMode: widget.autovalidateMode,
      obscureText: widget.obscureText ?? false,
      obscuringCharacter: '*',
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      cursorColor: KColor.black.color,
      keyboardType: widget.textInputType ?? TextInputType.text,
      onChanged: (value) {
        widget.onChanged != null ? widget.onChanged!(value) : null;
        validateField(value);
      },
      maxLength: widget.maxlength,
      enabled: widget.enabled,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          top: 14.h,
          bottom: 14.h,
          left: 14.w,
          right: 14.w,
        ),
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        label: widget.mandatoryLabel == true
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GlobalText(
                    str: widget.labelText ?? "",
                    color: KColor.grey2.color,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0.10,
                  ),
                  const Text('*', style: TextStyle(color: Colors.red)),
                ],
              )
            : GlobalText(
                str: widget.labelText ?? "",
                color: KColor.grey2.color,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 0.10,
              ),
        labelStyle: widget.labelStyle,
        filled: true,
        counterText: "",
        fillColor: KColor.white.color,
        suffixIcon: widget.suffixIcon,
        suffixIconColor: KColor.deepGrey.color,
        hintStyle: widget.hintStyle ??
            KTextStyle.customTextStyle(
              color: KColor.grey2.color,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 0.10,
            ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.borderColor ?? KColor.border2.color,
              width: widget.borderWidth ?? .50.w),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: KColor.primary.color, width: 1.w),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: KColor.red.color, width: 1.w),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              8,
            ),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: KColor.red.color, width: 1.w),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              8,
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              color: widget.borderColor ?? KColor.border2.color,
              width: widget.borderWidth ?? .50.w),
        ),
      ),
      validator: widget.validator,
      readOnly: widget.readOnly ?? false,
    );
  }
}

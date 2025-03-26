import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/global/widget/global_textformfield.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

const String signIn = "Sign In";
const String facebook = "Continue with Facebook";
const String google = "Continue with Google";
const String or = "Or";
const String login = "Login";
const String signUp = "SignUp";
const String name = "Name";
const String nameHint = "Your name";
const String email = "Email";
const String emailHint = "Your Email";
const String phoneNo = "Phone No";
const String phoneNoHint = "Type phone no";
const String password = "Password";
const String passwordHint = "Type password";

class AuthTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String title;
  final String hint;
  final Widget? sufixIcon;
  final TextInputType textInputType;
  final bool isPasswordField;
  final String? Function(String?)? validator;

  const AuthTextFormField(
      {super.key,
      this.controller,
      required this.title,
      required this.hint,
      this.sufixIcon,
      this.validator,
      this.isPasswordField = false,
      required this.textInputType});

  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    if (widget.isPasswordField) isVisible = true;
  }

  // bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: GlobalText(
              str: widget.title,
              color: KColor.deep2.color,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 0.09,
            )),
        const SizedBox(
          height: 4,
        ),
        GlobalTextFormField(
          controller: widget.controller,
          hintText: widget.hint,
          labelText: widget.hint,
          textInputType: widget.textInputType,
          // obscureText: widget.title == password && isObscureText,
          obscureText: isVisible,
          validator: widget.validator,
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: Icon(
                    isVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                )
              : widget.sufixIcon,
          // suffixIcon: widget.title == password
          //     ? IconButton(
          //         onPressed: () {
          //           setState(() {
          //             isObscureText = !isObscureText;
          //           });
          //         },
          //         icon: isObscureText == true
          //             ? const Icon(Icons.visibility_off_outlined)
          //             : const Icon(Icons.visibility_outlined),
          //       )
          //     : null
        ),
      ],
    );
  }
}

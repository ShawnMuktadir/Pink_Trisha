import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_bordered_container.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class GlobalLoader extends StatelessWidget {
  const GlobalLoader({super.key, this.text = "Loading..."});

  final String text;

  @override
  Widget build(BuildContext context) {
    return GlobalBorderedContainer(
      borderColor: KColor.grey.color.withOpacity(.5),
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          SizedBox(width: 10),
          GlobalText(str: text)
        ],
      ),
    );
  }
}

class GlobalTopLoader extends StatelessWidget {
  const GlobalTopLoader(
      {super.key,
      this.text = "Loading...",
      this.isLoading = false,
      required this.child});

  final String text;
  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        isLoading
            ? Container(
                color: KColor.grey.color.withOpacity(.2),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: GlobalLoader(
                    text: text,
                  ),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}

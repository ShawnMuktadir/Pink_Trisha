import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

import '../controller/profile_controller.dart';

class PhoneNumber extends ConsumerWidget {
  const PhoneNumber({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileController);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GlobalText(
        str: state.fetchProfile?.phoneNumber ?? "",
        color: KColor.deep2.color,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 0.09,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_back_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_background.dart';
import 'package:pink_by_trisha_app/global/widget/global_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_primary_logo.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/help_and_support/components/faq_button.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/help_and_support/components/help_title.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/help_and_support/components/support_details.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/styles/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void makePhoneCall(String phoneNumber) async {
      final Uri phoneCall = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(phoneCall)) {
        await launchUrl(phoneCall);
      } else {
        throw 'Could not launch $phoneCall';
      }
    }

    return GlobalBackground(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GlobalBackButton(title: "Help & Support"),
            Padding(
              padding: const EdgeInsets.only(
                right: 23,
                left: 25,
              ),
              child: Column(
                children: [
                  const VerticalSpace(
                    height: 16,
                  ),
                  const HelpTitle(),
                  const VerticalSpace(
                    height: 12,
                  ),
                  const SupportDetails(),
                  const VerticalSpace(
                    height: 80,
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const GlobalPrimaryLogo(
                          height: 40,
                          width: 200,
                        ),
                        const VerticalSpace(
                          height: 7,
                        ),
                        GlobalText(
                          str: '24/7 Helpline',
                          color: KColor.deep2.color,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 0.07,
                        ),
                        const VerticalSpace(
                          height: 7,
                        ),
                        GlobalText(
                          str:
                              'Always there to help you, no\nmatter the time zone',
                          textAlign: TextAlign.center,
                          color: KColor.deep3.color,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 0.10,
                        ),
                      ],
                    ),
                  ),
                  VerticalSpace(
                    height: 40.h,
                  ),
                  Row(
                    children: [
                      const Expanded(child: FAQButton()),
                      HorizontalSpace(
                        width: 15.w,
                      ),
                      Expanded(
                          child: GlobalButton(
                              onPressed: () {
                                makePhoneCall('+8801858949651');
                              },
                              buttonText: 'Call Us'))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

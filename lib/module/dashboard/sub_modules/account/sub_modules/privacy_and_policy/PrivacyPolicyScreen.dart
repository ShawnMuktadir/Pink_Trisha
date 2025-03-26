import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_back_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_background.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GlobalBackButton(title: "Privacy Policy"),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 24, left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        "pinktrisha.com (“we,” “our,” or “us”) is committed to protecting your privacy. This Privacy Policy outlines how we collect, use, disclose, and safeguard your information when you visit our website.",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    privacyItem("1. Information We Collect", [
                      "**a. Financial Transactions**: When engaging in financial transactions on our site, you may need to provide credit card details, security code, telephone number, and billing address.",
                      "**b. Registration as a PinkTrisha Member**: We may request personal information such as your name, email address, mailing address, and date of birth.",
                      "**c. Sign-Up for Emails**: If you subscribe to our emails, we may ask for your name and email address.",
                      "**d. Interactive Forums**: Any information you post publicly will be considered shared with consent.",
                      "**e. Social Networking Activities**: Our site may receive information when you share content related to us on social media.",
                    ]),
                    privacyItem("2. How We Use Your Information", [
                      "• To provide and maintain our services.",
                      "• To enhance user experience and optimize our website.",
                      "• To send transactional and promotional communications (if opted-in).",
                      "• To comply with legal obligations.",
                      "• To detect and prevent fraudulent or unauthorized activities.",
                    ]),
                    privacyItem("3. Sharing Your Information", [
                      "**Service Providers**: We share data with trusted third-party vendors for hosting, analytics, and payment processing.",
                      "**Legal Compliance**: Information may be shared when required by law.",
                      "**Business Transfers**: In case of a merger, acquisition, or sale of assets.",
                      "We will not sell or rent your personal data without explicit consent.",
                    ]),
                    privacyItem("4. Data Retention", [
                      "• We retain personal data only as long as necessary for service fulfillment or legal requirements.",
                      "• Non-personal data may be used for analytics and service improvements.",
                    ]),
                    privacyItem("5. Your Rights", [
                      "**Access**: Request a copy of the information we hold about you.",
                      "**Correction**: Request updates or corrections to your data.",
                      "**Deletion**: Request deletion of your personal data.",
                      "**Withdrawal of Consent**: Withdraw consent for data processing where applicable.",
                      "To exercise your rights, contact us at pinktrisha2020@gmail.com.",
                    ]),
                    privacyItem("6. Security Measures", [
                      "• We use industry-standard security practices to safeguard your data, including encryption and secure storage.",
                      "• However, no method of transmission over the internet is entirely secure.",
                    ]),
                    privacyItem("7. Changes to This Privacy Policy", [
                      "• We may update this Privacy Policy periodically to reflect changes in our practices or legal requirements.",
                      "• The 'Effective Date' at the top will indicate the latest revision.",
                    ]),
                    privacyItem("8. Contact Us", [
                      "**Email**: pinktrisha2020@gmail.com",
                      "**Phone**: +88 01700 946 982",
                      "**Mailing Address**: 124 Hazaribagh Tannery Area, Zigatola, Hazaribagh, Dhaka, PO: 1209",
                    ]),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper function to render each section
  Widget privacyItem(String title, List<String> contents) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          ...contents.map(
                (content) => Padding(
              padding: const EdgeInsets.only(left: 20, top: 4),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                  children: _parseBoldText(content),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper function to parse bold text
  List<TextSpan> _parseBoldText(String text) {
    final RegExp boldPattern = RegExp(r'\*\*(.*?)\*\*'); // Detect **bold text**
    final List<TextSpan> spans = [];
    int lastMatchEnd = 0;

    for (final match in boldPattern.allMatches(text)) {
      // Normal text before the match
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }
      // Bold text
      spans.add(
        TextSpan(
          text: match.group(1),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
      lastMatchEnd = match.end;
    }

    // Remaining normal text after last match
    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return spans;
  }

  // Helper function
  Widget bulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("• ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_back_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_background.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GlobalBackButton(title: "Terms & Conditions"),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 24, left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 12.0,
                        top: 12.0,
                        bottom: 12.0,
                      ),
                      child: Text(
                        "Welcome to Pink Trisha's e-commerce platform. By using our website, you agree to comply with and be bound by the following terms and conditions.",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    termsItem("1. Definitions:", [
                      "1.1 \"Pink Trisha\" refers to our e-commerce platform.",
                      "1.2 \"Customer\" refers to anyone using our website to purchase products.",
                    ]),
                    termsItem("2. Product Information:", [
                      "2.1 Pink Trisha endeavors to provide accurate and up-to-date information about products. However, we do not guarantee the accuracy, completeness, or reliability of product descriptions, pricing, or availability.",
                    ]),
                    termsItem("3. Ordering Process:", [
                      "3.1 Placing an order on Pink Trisha constitutes an offer to purchase the selected products.",
                      "3.2 We reserve the right to refuse or cancel any order for any reason, including but not limited to product availability, errors in product or pricing information, or suspicion of fraudulent activity.",
                    ]),
                    termsItem("4. Pricing and Payment:", [
                      "4.1 Prices are listed in the currency specified on the website.",
                      "4.2 Pink Trisha reserves the right to change prices at any time without notice.",
                      "4.3 Payment can be made using the available payment methods on our website. Payment information is handled securely.",
                    ]),
                    termsItem("5. Shipping and Delivery:", [
                      "5.1 We ship products from abroad. Customers are responsible for any customs duties or taxes incurred during international shipping.",
                      "5.2 Estimated delivery times are provided as a guide. Pink Trisha is not responsible for delays caused by customs, transportation, or other factors beyond our control.",
                    ]),
                    termsItem("6. Returns and Refunds:", [
                      "6.1 Our returns and refunds policy is available on the website. Customers are encouraged to review it before making a purchase.",
                      "6.2 Returned items must be in their original condition, and customers are responsible for return shipping costs.",
                    ]),
                    termsItem("7. Privacy and Data Protection:", [
                      "7.1 Pink Trisha respects customer privacy. Our privacy policy outlines how we collect, use, and protect customer information.",
                    ]),
                    termsItem(
                        "8. Intellectual Property and Your Submissions:", [
                      "8.1 All content on the Pink Trisha website, including images, logos, and product descriptions, is the property of Pink Trisha and is protected by intellectual property laws.",
                      "8.2 Anything that you submit to the Site and/or provide to us, including but not limited to, questions, reviews, comments, and suggestions (collectively, \"Submissions\") will become our sole and exclusive property and shall not be returned to you.",
                    ]),
                    termsItem("9. Events Beyond Our Control:", [
                      "9.1 We shall not be held liable for any delays or failures to meet our obligations under these terms if such delays or failures result from causes beyond our reasonable control. This provision does not affect your statutory rights.",
                    ]),
                    termsItem("10. Termination:", [
                      "10.1 In addition to other legal or equitable remedies, we reserve the right to immediately terminate these Terms and Conditions or revoke any or all rights granted under them without prior notice.",
                      "10.2 Upon termination, you must cease all access and use of the Site. We may also immediately revoke any passwords or account identifications issued to you.",
                    ]),
                    termsItem("11. Estimated Delivery Date:", [
                      "11.1 The Estimated Delivery Date (EDD) provided when an item is associated with a traveler is not a guaranteed delivery date; it is an estimate. The EDD may be subject to change based on unforeseeable circumstances such as natural disasters, flight delays, travel restrictions, flight/travel bans, accidents, or virus outbreaks.",
                    ]),
                    SizedBox(height: 20),
                    Text(
                      "We hope these Terms and Conditions are helpful for your understanding of our policies. If you have any further questions, feel free to contact our customer support team.",
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget termsItem(String title, List<String> contents) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          ...contents.map((content) => Padding(
                padding: const EdgeInsets.only(left: 20, top: 4),
                child: Text(content),
              ))
        ],
      ),
    );
  }
}

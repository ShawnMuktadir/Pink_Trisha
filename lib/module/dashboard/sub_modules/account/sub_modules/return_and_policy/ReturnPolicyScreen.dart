import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_back_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_background.dart';

class ReturnPolicyScreen extends StatelessWidget {
  const ReturnPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GlobalBackButton(title: "Return & Refund Policy"),
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
                        "Our return and refund policy ensures a smooth process for customers facing any issues with their orders. Please read the following carefully:",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    returnPolicyItem("1. Home Delivery within Dhaka", [
                      "**Faulty Item Notification**: Notify us at the time of delivery in front of the delivery person if the product is damaged or faulty.",
                      "**Exchange & Refund**: If the product has any kind of damage or fault, we will exchange it within **2-3 days** or issue a **full refund within 24 hours**.",
                    ]),
                    returnPolicyItem("2. Courier Deliveries", [
                      "**Faulty Item Notification**: Notify us upon receiving the product in front of the courier delivery person.",
                      "**Exchange & Refund**: If the product is damaged or faulty, we will exchange it within **2-3 days** or issue a **refund within 24 hours**.",
                    ]),
                    returnPolicyItem("3. Pickup Orders", [
                      "**Check Before Collecting**: If you choose to pick up your order, please check the item while collecting it.",
                      "**Immediate Decision**: If the item has any faults, you may reject it immediately. We will either **repurchase the item** or **issue a full refund**, based on your preference.",
                    ]),
                    returnPolicyItem("4. Cancellation Policy", [
                      "Orders can only be canceled if the traveler has **not yet purchased the item**.",
                      "Once the item is purchased, **cancellation is not possible**.",
                    ]),
                    returnPolicyItem("5. Items Warranty", [
                      "**In Case of Missing Items**: If an item is missing due to shipment delays, luggage loss, or unforeseen circumstances, we offer two options:",
                      "1. **Refund** the full amount.",
                      "2. **Repurchase** the item and send it with the next available traveler.",
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
  Widget returnPolicyItem(String title, List<String> contents) {
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
}

import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_back_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_background.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  bool isClick = false;

  @override
  Widget build(BuildContext context) {
    return GlobalBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GlobalBackButton(title: "FAQ"),
          const SizedBox(height: 15),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  faqItem(
                    "What is PinkByTrisha?",
                    "PinkByTrisha is an online ecommerce platform that offers a curated collection of fashion and lifestyle products. From clothing to accessories, we provide trendy and high-quality items that cater to various tastes and preferences.",
                  ),
                  faqItem(
                    "How can I place an order?",
                    "To place an order, simply browse our website, add desired items to your cart, and proceed to checkout. Follow the prompts to enter your shipping information, select a payment method, and complete your purchase.",
                  ),
                  faqItem(
                    "Is it safe to shop on PinkByTrisha?",
                    "Yes, PinkByTrisha takes your security seriously. We use industry-standard encryption to protect your personal and payment information. Your data is secure, and we do not share it with third parties.",
                  ),
                  faqItem(
                    "What payment methods do you accept?",
                    "We accept a variety of payment methods, including credit/debit cards, bkash, and other secure payment gateways. Choose the option that suits you best during the checkout process.",
                  ),
                  faqItem(
                    "How can I track my order?",
                    "Once your order is shipped, you will receive a confirmation email with a tracking number. You can use this number to track your order in real-time on our website or through the shipping carrier's platform.",
                  ),
                  faqItem(
                    "What is your return policy?",
                    "We have a hassle-free return policy. If you are not satisfied with your purchase, you can return the item(s) within 30 days of receiving your order. Please refer to our 'Returns and Exchanges' page for detailed instructions.",
                  ),
                  faqItem(
                    "Do you ship internationally?",
                    "Yes, we offer international shipping to many countries. Shipping costs and delivery times may vary depending on your location. Customs and duties may apply for international orders. These charges are not included in the product or shipping cost and are the responsibility of the customer. Please check with your local customs office for more information.",
                  ),
                  faqItem(
                    "How do I contact customer support?",
                    "If you have any questions or concerns, our customer support team is here to help. You can reach out via our 'Contact Us' page, and we will respond to your inquiry as soon as possible.",
                  ),
                  faqItem(
                    "Can I cancel or modify my order after placing it?",
                    "We process orders quickly to ensure prompt delivery. Therefore, once an order is placed, it cannot be canceled or modified. Please review your order carefully before completing the purchase.",
                  ),
                  faqItem(
                    "How can I stay updated on promotions and new arrivals?",
                    "To stay in the loop with our latest promotions, new arrivals, and updates, subscribe to our newsletter. You can find the option to subscribe at the bottom of our website. Additionally, follow us on social media for real-time updates.",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Text(
                      "We hope these FAQs help enhance your shopping experience at PinkByTrisha! If you have any further questions, feel free to contact our customer support team.",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget faqItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(answer),
        ],
      ),
    );
  }
}

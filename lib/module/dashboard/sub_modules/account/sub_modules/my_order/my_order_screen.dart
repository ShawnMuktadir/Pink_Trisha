import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_back_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_background.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/my_order/components/order_card.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/my_order/controller/my_order_controller.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({
    super.key,
  });

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  List<String> orderList = [
    " ",
    " ",
    " ",
    " ",
    " ",
  ];

  @override
  void initState() {
    super.initState();
    final controller = context.read(myOrderController.notifier);
    Future(() async {
      await controller.getMyOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final state = ref.watch(myOrderController);
      return GlobalBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GlobalBackButton(title: "My Order"),
            const SizedBox(height: 15),
            state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.orderList.isNotEmpty
                    ? Expanded(
                        child: SingleChildScrollView(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 24, left: 24),
                              child: Column(
                                children:
                                    state.orderList.asMap().entries.map((item) {
                                  return OrderCard(
                                    orderData: item.value,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const Expanded(
                        child: Center(
                        child: Text('No Order Found'),
                      ))
          ],
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_back_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_background.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/model/all_address_model.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/my_order/controller/my_order_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/order_details/components/order_delivery_section.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/order_details/components/order_items.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/order_details/components/order_payment.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/order_details/components/order_shipping_address.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/model/cart_product.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/model/payment_type.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.orderId});
  final String orderId;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    final controller = context.read(myOrderController.notifier);
    Future(() async {
      await controller.getOrderDetails(orderId: widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller = ref.read(myOrderController.notifier);
        final state = ref.watch(myOrderController);

        print("OrderDetailsScreen build started");
        print("isOrderDetailsLoading: ${state.isOrderDetailsLoading}");
        print("orderDetailsResponse: ${state.orderDetailsResponse}");

        return GlobalBackground(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GlobalBackButton(title: "Order Details"),
              state.isOrderDetailsLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : state.orderDetailsResponse == null
                      ? const Center(
                          child: GlobalText(str: "Something went wrong.."),
                        )
                      : Expanded(
                          child: SingleChildScrollView(
                            child: Center(
                              child: Builder(builder: (context) {
                                print("Building order details...");

                                final data = state.orderDetailsResponse!.data!;
                                print("data: $data");

                                final hasItem = data.orderItems != null &&
                                    data.orderItems!.isNotEmpty;
                                print("hasItem: $hasItem");

                                final firstItem =
                                    hasItem ? data.orderItems?.first : null;
                                print("firstItem: $firstItem");

                                return Column(
                                  children: [
                                    OrderDeliverySection(
                                      orderId: widget.orderId,
                                      orderStatus: data.deliveryStatus ?? "",
                                      date:
                                          hasItem ? firstItem?.createdAt : null,
                                    ),
                                    hasItem
                                        ? OrderItemsSection(
                                            cartProducts: [
                                              ...data.orderItems!.map(
                                                (e) {
                                                  print(
                                                      "Processing order item: ${e.product?.name}");
                                                  return CartProduct(
                                                    id: e.product?.id
                                                            ?.toString() ??
                                                        "",
                                                    name: e.product?.name ?? "",
                                                    slug: "slug",
                                                    shortDescription: "",
                                                    imageUrl: e
                                                                .product
                                                                ?.productImages
                                                                ?.isNotEmpty ==
                                                            true
                                                        ? e
                                                            .product!
                                                            .productImages!
                                                            .first
                                                            .src
                                                        : null,
                                                    price: null,
                                                    offerPrice: null,
                                                    productImage: null,
                                                    isPreorder: true,
                                                    quantity: e.quantity ?? 1,
                                                    brandId: null,
                                                    categoryId: 1,
                                                    vendorId: null,
                                                    paymentType: e.product
                                                            ?.paymentType ??
                                                        paymentTypes[0].name,
                                                    nameBn: '',
                                                    currentAttributeValueId: [],
                                                    attributes:
                                                        e.productAttributes,
                                                    variants: e.productVariants,
                                                  );
                                                },
                                              ).toList()
                                            ],
                                          )
                                        : const SizedBox.shrink(),
                                    OrderShippingAddress(
                                      shippingAddress: AllAddressData(
                                        house: "",
                                        addressLine:
                                            data.customerAddressShipping ?? "",
                                        area: data.customerAreaShipping ?? "",
                                        city: data.customerCityShipping ?? "",
                                        postCode: data.customerPostCode ?? "",
                                        country:
                                            data.customerCountryShipping ?? "",
                                      ),
                                    ),
                                    hasItem
                                        ? OrderPaymentTitle(
                                            paymentType: PaymentType(
                                              name:
                                                  firstItem?.paymentType ?? "",
                                              imageLink: null,
                                              title: firstItem?.paymentType ==
                                                      "COD"
                                                  ? "Cash On Delivery"
                                                  : "DVP",
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                    OrderPaymentSummary(
                                      subtotal:


                                          data.subTotal?.toString() ?? "0",
                                      total: data.subTotal?.toString() ?? "0",
                                      shippingCharge: "0",
                                      discount: "0",
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
            ],
          ),
        );
      },
    );
  }
}

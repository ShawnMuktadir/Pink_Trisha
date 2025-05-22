import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pink_by_trisha_app/constant/app_url.dart';
import 'package:pink_by_trisha_app/constant/constant_key.dart';
import 'package:pink_by_trisha_app/data_provider/api_client.dart';
import 'package:pink_by_trisha_app/data_provider/pref_helper.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/model/all_address_model.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/my_order/model/order_data.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/controller/cart_state.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/model/cart_product.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/model/payment_type.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/controller/product_details_state.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/view_util.dart';

final cartController =
    StateNotifierProvider<CartController, CartState>((ref) => CartController());

final List<PaymentType> paymentTypes = [
  PaymentType(title: 'Pay Online', name: 'DVP', index: 0),
  //PaymentType(title: 'Cash on Delivery', name: 'COD', index: 1),
];

class CartController extends StateNotifier<CartState> {
  CartController()
      : super(CartState(
          isLoading: false,
          isOrderCreateBtnLoading: false,
          cartProducts: const [],
          isCartBtnLoading: false,
          isSSLLoading: false,
          subtotal: 0,
          shippingFee: 0,
          discount: 0,
          paymentType:
              PaymentType(title: "Cash on Delivery", name: "COD", index: 1),
          // Ensure COD is Default
          billingAddress: null,
          currencyType: "BDT",
          shippingAddress: null,
          isAcceptedTAP: false,
          isSameBillingAndShipping: false,
          trxNumber: '',
          trxID: '',
          paymentTypes: [
            PaymentType(title: "Pay Online", name: "DVP", index: 0),
            PaymentType(title: "Cash on Delivery", name: "COD", index: 1),
          ],
        )) {
    print("Initial Payment Type: ${state.paymentType.name}"); // Debugging
  }

  static const _key = 'selectedCartProducts';
  final ApiClient _apiClient = ApiClient();
  final formKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();

  Future<void> addToCartFromDetails(
      {required BuildContext context, required CartProduct cartProduct}) async {
    await toggleCartButton(cartProduct).then((value) =>
        Navigation.push(context, appRoutes: AppRoutes.shippingAddress));
  }

  bool isLive = false;

  /*Future<void> sslCommerzCall({
    required BuildContext mContext,
    required int orderId,
  }) async {
    // Determine if we are in live or test mode
    bool isLive = AppUrl.base.url == "https://core.pinktrisha.com/";

    state = state.copyWith(isSSLLoading: true);

    final String userId = PrefHelper.getString(AppConstant.USER_ID.key);

    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        // Use IPN URL if required
        // ipn_url: "https://yourwebsite.com/ipn",
        currency: SSLCurrencyType.BDT,
        product_category: "Food",
        sdkType: isLive ? SSLCSdkType.LIVE : SSLCSdkType.TESTBOX,
        // FIXED
        store_id: isLive
            ? AppConstant.SSL_STORE_ID_LIVE.key
            : AppConstant.STORE_ID.key,
        store_passwd: isLive
            ? AppConstant.SSL_STORE_PASSWORD_LIVE.key
            : AppConstant.STORE_PASSWORD.key,
        total_amount: state.subtotal,
        tran_id: "REF${DateTime.now().millisecondsSinceEpoch}$userId",
      ),
    );

    try {
      SSLCTransactionInfoModel result = await sslcommerz.payNow();

      // Debugging response
      debugPrint("Raw Response Before Parsing: ${result.toJson()}");

      if (result == null || result.status == null) {
        debugPrint("Transaction status is null. Check your API credentials.");
        Fluttertoast.showToast(
          msg: "Transaction Error: No response from server",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else if (result.status!.toLowerCase() == "failed") {
        debugPrint('SSLCommerz Response: ${jsonEncode(result.toJson())}');
        await paymentFailed(orderId);
        Fluttertoast.showToast(
          msg: "Transaction Failed: ${result.toJson().toString()}",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else if (result.status!.toLowerCase() == "closed") {
        ViewUtil.toast(msg: "Transaction Closed.");
      } else {
        // Success Case
        debugPrint("Success! Status: ${result.status} | trx: ${result.tranId}");
        await paymentSuccess(orderId: orderId, context: mContext);
        state = state.copyWith(
          trxID: result.tranId,
          trxNumber: result.cardNo,
        );
      }
    } catch (e) {
      debugPrint("SSLCommerz Error: ${e.toString()}");
      Fluttertoast.showToast(
        msg: "Payment Error: ${e.toString()}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }

    state = state.copyWith(isSSLLoading: false);

    // Navigate and clear cart after transaction
    Future(() {
      Navigation.popUntil(mContext, 3);
      Navigation.push(mContext,
          appRoutes: AppRoutes.orderConfirm, arguments: orderId.toString());
    });

    clearAllFromCart();
  }*/

  Future<void> sslCommerzCall({
    required BuildContext mContext,
    required int orderId,
  }) async {
    bool isLive = AppUrl.base.url == "https://core.pinktrisha.com/";

    state = state.copyWith(isSSLLoading: true);

    final String userId = PrefHelper.getString(AppConstant.USER_ID.key);

    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        currency: SSLCurrencyType.BDT,
        product_category: "Food",
        sdkType: isLive ? SSLCSdkType.LIVE : SSLCSdkType.TESTBOX,
        store_id: isLive
            ? AppConstant.SSL_STORE_ID_LIVE.key
            : AppConstant.STORE_ID.key,
        store_passwd: isLive
            ? AppConstant.SSL_STORE_PASSWORD_LIVE.key
            : AppConstant.STORE_PASSWORD.key,
        total_amount: state.subtotal,
        tran_id: "REF${DateTime.now().millisecondsSinceEpoch}$userId",
      ),
    );

    SSLCTransactionInfoModel? transaction;
    bool paymentWasSuccessful = false;

    try {
      debugPrint("Launching SSLCommerz payment...");
      var response = await sslcommerz.payNow();
      debugPrint("Received response: $response");

      if (response == null) {
        debugPrint("Null response received. Payment might have failed silently.");
        Fluttertoast.showToast(
          msg: "Payment could not be started. Please try again.",
          backgroundColor: Colors.orange,
          textColor: Colors.white,
        );
        state = state.copyWith(isSSLLoading: false);
        return;
      }

      debugPrint("Raw Response: $response");
      debugPrint("Response Type: ${response.runtimeType}");

      if (response is SSLCTransactionInfoModel) {
        transaction = response;
        debugPrint("Transaction Parsed: ${jsonEncode(transaction.toJson())}");
      } else {
        debugPrint("Unexpected response type: ${response.runtimeType}");
        Fluttertoast.showToast(
          msg: "Unexpected response from payment gateway.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        state = state.copyWith(isSSLLoading: false);
        return;
      }

      final status = transaction.status?.toLowerCase();
      debugPrint("Transaction Status: $status");

      if (status == null) {
        debugPrint("Transaction status is null. Possibly server issue.");
        Fluttertoast.showToast(
          msg: "Transaction Error: No response from server.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else if (status == "failed") {
        debugPrint("Transaction Failed: ${jsonEncode(transaction.toJson())}");
        await paymentFailed(orderId);
        Fluttertoast.showToast(
          msg: "Your payment failed. Please try again.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else if (status == "closed") {
        debugPrint("Transaction closed by user.");
        ViewUtil.toast(msg: "Transaction was closed before completion.");
      } else {
        debugPrint("Payment Successful!");
        debugPrint("Transaction ID: ${transaction.tranId}");
        debugPrint("Card Number: ${transaction.cardNo}");
        await paymentSuccess(orderId: orderId, context: mContext);

        state = state.copyWith(
          trxID: transaction.tranId,
          trxNumber: transaction.cardNo,
        );

        paymentWasSuccessful = true;
      }
    } catch (e, s) {
      debugPrint("Exception occurred: $e");
      debugPrint("Stacktrace: $s");
      Fluttertoast.showToast(
        msg: "Payment Error: ${e.toString()}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      showDialog(
        context: mContext,
        builder: (context) => AlertDialog(
          title: Text("Payment Error"),
          content: Text("Something went wrong while initiating the payment. Please check your internet or try again."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }

    state = state.copyWith(isSSLLoading: false);

    if (paymentWasSuccessful) {
      debugPrint("Navigating to Order Confirmation...");
      Future(() {
        Navigation.popUntil(mContext, 3);
        Navigation.push(
          mContext,
          appRoutes: AppRoutes.orderConfirm,
          arguments: orderId.toString(),
        );
      });

      clearAllFromCart();
    } else {
      debugPrint("Payment failed or was cancelled. Navigation skipped.");
    }
  }

  void clearPayments() {
    state = state.copyWith(
      trxID: "",
      trxNumber: "",
    );
  }

  Future<void> paymentSuccess(
      {required BuildContext context, required int orderId}) async {
    try {
      final url = AppUrl.paymentSuccess.url
          .replaceFirst('{orderId}', orderId.toString());

      await _apiClient.request(
          url: url,
          method: MethodType.POST,
          // token: PrefHelper.getString(AppConstant.TOKEN.key),
          onSuccessFunction: (response) {
            print('Response: ${jsonEncode(response.data)}');
            if (response.statusCode == 200) {
              ViewUtil.toast(
                msg: "Transaction Successfully done.",
              );
            } else {
              ViewUtil.toast(
                msg: "Something went wrong!",
              );
            }
          });
    } catch (e, s) {
      print("error is : $e");
    }
  }

  Future<void> paymentFailed(int orderId) async {
    try {
      final url = AppUrl.paymentFailed.url
          .replaceFirst('{orderId}', orderId.toString());

      await _apiClient.request(
          url: url,
          method: MethodType.POST,
          // token: PrefHelper.getString(AppConstant.TOKEN.key),
          onSuccessFunction: (response) {
            print('Response: ${jsonEncode(response.data)}');
            if (response.statusCode == 200) {
              ViewUtil.toast(
                msg: "Transaction Failed.",
              );
            } else {
              ViewUtil.toast(
                msg: "Something went wrong!",
              );
            }
          });
      //  }
    } catch (e, s) {
      print("error is : $e");
    }
  }

  Map<String, String> convertListToMap(
      List<SelectedAttributeModel> variantSelected) {
    Map<String, String> resultMap = {};

    for (var variant in variantSelected) {
      if (variant.attributeName.isNotEmpty &&
          variant.attributeName.isNotEmpty) {
        resultMap[variant.attributeName] = variant.attributeValueName;
      }
    }

    return resultMap;
  }

  Future<void> reqCreateOrder(BuildContext context) async {
    try {
      print("==== Starting reqCreateOrder ====");

      state = state.copyWith(isOrderCreateBtnLoading: true);
      print("isOrderCreateBtnLoading set to true");

      List<OrderCreateItem> orderItems = [];

      for (var e in state.cartProducts) {
        Map<String, String> resultMap =
            convertListToMap(e.currentAttributeValueId);

        orderItems.add(OrderCreateItem(
          quantity: e.quantity,
          id: int.tryParse(e.id)!,
          variantSelected: resultMap,
          productDetail: OrderCreateProductDetail(
            id: int.tryParse(e.id)!,
            name: e.name,
            brandId: e.brandId,
            categoryId: e.categoryId ?? 1,
            imageUrl: e.imageUrl ?? "",
            offerPrice: e.offerPrice,
            paymentType: e.paymentType,
            price: e.price,
            shortDescription: e.shortDescription ?? "",
            slug: e.slug ?? "",
            vendorId: e.vendorId,
            quantity: e.quantity,
            variantSelected: resultMap,
            nameBn: e.nameBn,
          ),
        ));
      }

      print(
          "\nAll cart products processed. Total order items: ${orderItems.length}");

      // Fix: Use the selected payment type from state instead of recalculating
      String finalPaymentType = state.paymentType.name ?? "COD";
      print("Final payment type selected: $finalPaymentType");

      OrderCreateData orderData = OrderCreateData(
        customerAddress: state.shippingAddress?.address ?? "",
        customerAddressShipping: state.shippingAddress?.address ?? "",
        customerArea: state.shippingAddress?.area ?? "",
        customerAreaShipping: state.shippingAddress?.area ?? "",
        customerCity: state.shippingAddress?.city ?? "",
        customerCityShipping: state.shippingAddress?.city ?? "",
        customerCountry: state.shippingAddress?.country ?? "",
        customerCountryCode: state.shippingAddress?.countryCode ?? "",
        customerCountryCodeShipping: state.shippingAddress?.countryCode ?? "",
        customerCountryShipping: state.shippingAddress?.country ?? "",
        customerId: int.parse(PrefHelper.getString(AppConstant.USER_ID.key)),
        customerName: state.shippingAddress?.address ?? "",
        customerNameShipping: state.shippingAddress?.address ?? "",
        customerPhoneNumberShipping: state.shippingAddress?.phoneNumber ?? "",
        customerPostCode: state.shippingAddress?.postCode ?? "",
        customerPostCodeShipping: state.shippingAddress?.postCode ?? "",
        customerState: state.shippingAddress?.state ?? "",
        customerStateShipping: state.shippingAddress?.state ?? "",
        discountAmount: state.discount.toDouble(),
        note: "",
        orderItems: orderItems,
        paymentType: finalPaymentType,
        // Use the dynamically determined payment type
        currencyType: state.currencyType ?? "",
        couponId: null,
        rewardCheck: false,
        customerEmail: PrefHelper.getString(AppConstant.EMAIL.key),
      );

      print("\nOrder data prepared:");
      print(orderData.toMap());

      await _apiClient.request(
        url: AppUrl.orderCreate.url,
        method: MethodType.POST,
        data: orderData.toMap(),
        token: PrefHelper.getString(AppConstant.TOKEN.key),
        onSuccessFunction: (response) {
          print("\nOrder creation response received:");
          print(jsonEncode(response.data));

          if (finalPaymentType == "COD") {
            print("Payment type is Cash on Delivery (COD).");
            ViewUtil.SSLSnackbar("Order created successfully!");
            Navigation.popUntil(context, 3);
            Navigation.push(context,
                appRoutes: AppRoutes.orderConfirm,
                arguments: response.data["data"]["id"].toString());
            clearAllFromCart();
          } else {
            print(
                "Payment type is Online (DVP), proceeding with SSLCommerz payment.");
            int? orderId = response.data["data"]["orderId"];
            if (orderId != null) {
              sslCommerzCall(orderId: orderId, mContext: context);
            } else {
              ViewUtil.SSLSnackbar("Order Id not found!");
            }
          }
        },
      );
    } catch (e, s) {
      print("\n Error occurred during order creation:");
      print("Error: $e");
      print("StackTrace: $s");
    }

    state = state.copyWith(isOrderCreateBtnLoading: false);
    print("isOrderCreateBtnLoading set to false");
    print("==== reqCreateOrder finished ====");
  }

  void incrementQuantity(String slug) {
    print("incrementQuantity");
    final productIndex =
        state.cartProducts.indexWhere((element) => element.slug == slug);
    if (productIndex != -1 && state.cartProducts[productIndex].quantity < 20) {
      final product = state.cartProducts[productIndex];
      final updatedProduct = product.copyWith(quantity: product.quantity + 1);
      final updatedCartProducts = List<CartProduct>.from(state.cartProducts);
      updatedCartProducts[productIndex] = updatedProduct;
      updateCartProducts(updatedCartProducts);
    }
  }

  void decrementQuantity(String slug) {
    print("decrementQuantity");
    final productIndex =
        state.cartProducts.indexWhere((element) => element.slug == slug);
    if (productIndex != -1 && state.cartProducts[productIndex].quantity == 1) {
      List<CartProduct> updatedCartProducts = List.from(state.cartProducts);

      if (updatedCartProducts.any((product) => product.slug == slug)) {
        updatedCartProducts.removeWhere((product) => product.slug == slug);
        updateCartProducts(updatedCartProducts);
        return;
      }
    }

    if (productIndex != -1 && state.cartProducts[productIndex].quantity > 1) {
      final product = state.cartProducts[productIndex];
      final updatedProduct = product.copyWith(quantity: product.quantity - 1);
      final updatedCartProducts = List<CartProduct>.from(state.cartProducts);
      updatedCartProducts[productIndex] = updatedProduct;
      updateCartProducts(updatedCartProducts);
    }
  }

  void deleteCart(String slug) {
    List<CartProduct> updatedCartProducts = List.from(state.cartProducts);

    if (updatedCartProducts.any((product) => product.slug == slug)) {
      updatedCartProducts.removeWhere((product) => product.slug == slug);
      updateCartProducts(updatedCartProducts);
      return;
    }
  }

  Future<void> getCartProducts({bool isLoading = true}) async {
    try {
      print("Fetching Cart Products...");

      state = state.copyWith(isLoading: true);

      final jsonString = PrefHelper.getString(_key);

      if (jsonString == null || jsonString.isEmpty) {
        print("Cart is empty.");
        return;
      }

      final List<CartProduct> cartProducts = jsonDecode(jsonString)
          .cast<Map<String, dynamic>>()
          .map<CartProduct>((json) => CartProduct.fromJson(json))
          .toList();

      double newSubtotal =
          calculateSubtotal(cartProducts); // Correct subtotal with offer prices

      print("error");
      print("error " +
          PrefHelper.getBool(AppConstant.IS_SWITCHED.key).toString());

      // Restore payment switch value
      final bool isPayOnline = PrefHelper.getBool(AppConstant.IS_SWITCHED.key);
      final paymentType = isPayOnline
          ? PaymentType(title: "Pay Online", name: "DVP", index: 0)
          : PaymentType(title: "Cash on Delivery", name: "COD", index: 1);

      state = state.copyWith(
          cartProducts: cartProducts,
          subtotal: newSubtotal,
          paymentType: paymentType // Restore saved payment type here
          );

      print("Updated Cart Subtotal: $newSubtotal");
    } catch (e) {
      print("Error fetching cart products: $e");
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> updateCartProducts(List<CartProduct> updatedCartProducts) async {
    try {
      print("Updating Cart Products...");

      final list = List<Map<String, dynamic>>.from(
          updatedCartProducts.map((product) => product.toJson()));

      print("Saving to PrefHelper...");
      await PrefHelper.setString(_key, jsonEncode(list));

      print("Fetching Updated Cart Products...");
      await getCartProducts(); // This will refresh cart state

      // Update state with new cart and recalculate `hasOnlinePayment`
      bool hasOnlinePayment =
          updatedCartProducts.any((item) => item.paymentType == "DVP");

      state = state.copyWith(
        cartProducts: updatedCartProducts,
        isCartBtnLoading: false,
        isLoading: false,
        paymentType: hasOnlinePayment
            ? PaymentType(title: "Pay Online", name: "DVP", index: 0)
            : PaymentType(
                title: "Cash on Delivery",
                name: "COD",
                index: 1), // Auto-update payment type
      );
      await PrefHelper.setBool(AppConstant.IS_SWITCHED.key, hasOnlinePayment);
      print("Updated Cart with hasOnlinePayment: $hasOnlinePayment");
    } on Exception catch (e) {
      print("Error in updateCartProducts: $e");
    }
  }

  Future<void> clearAllFromCart() async {
    await PrefHelper.setString(_key, "");
    state = state.copyWith(
      isLoading: false,
      isOrderCreateBtnLoading: false,
      cartProducts: const [],
      isCartBtnLoading: false,
      subtotal: 0,
      shippingFee: 0,
      discount: 0,
      paymentType:
          PaymentType(title: "Cash on Delivery", name: "COD", index: 1),
      billingAddress: null,
      currencyType: "BDT",
      shippingAddress: null,
      isAcceptedTAP: false,
      isSameBillingAndShipping: false,
    );
  }

  double calculateSubtotal(List<CartProduct> cartProducts) {
    double subtotal = 0.0;

    for (var product in cartProducts) {
      // Keep original logic: Use offer price if available; otherwise, use the regular price
      double offerPrice = double.parse(product.price == 0
          ? product.offerPrice.toString()
          : product.price.toString());

      print("Product: ${product.name} | Offer Price: ${product.offerPrice} "
          "| Final Price Used: $offerPrice");

      // Apply DVP logic while keeping the original logic intact
      if (product.paymentType == "DVP") {
        subtotal += (offerPrice / 2) * product.quantity; // Half price for DVP
        print("DVP Product Applied | Adjusted Price: ${(offerPrice / 2)}");
      } else {
        subtotal += offerPrice * product.quantity; // Full price for non-DVP
        print("Regular Product Applied | Price: $offerPrice");
      }
    }
    print("calc 7 | Final Subtotal: $subtotal");
    return subtotal;
  }

  Future<void> toggleCartButton(CartProduct cartProduct) async {
    print(
        "toggleCartButton ${cartProduct.currentAttributeValueId.length}  ${cartProduct.currentAttributeValueId} ");
    state = state.copyWith(isCartBtnLoading: true);
    try {
      List<CartProduct> updatedCartProducts = List.from(state.cartProducts);

      if (updatedCartProducts
          .any((product) => product.slug == cartProduct.slug)) {
        updatedCartProducts
            .removeWhere((product) => product.slug == cartProduct.slug);
      } else {
        updatedCartProducts.add(cartProduct);
      }
      await updateCartProducts(updatedCartProducts);
    } on Exception catch (e) {
      print("Error is: $e");
    }
    state = state.copyWith(isCartBtnLoading: false);
  }

  bool isInCart(String slug) {
    return state.cartProducts
        .where((element) => element.slug == slug)
        .isNotEmpty;
  }

  void setSameShippingAndBilling(bool value) async {
    state = state.copyWith(isSameBillingAndShipping: value);
  }

  void setTermsAndPrivacyPolicy(bool value) async {
    state = state.copyWith(isAcceptedTAP: value);
  }

  void setPaymentTypeIndex(PaymentType paymentType) {
    print("Updating payment type to: ${paymentType.name}"); // Debugging
    state = state.copyWith(
        paymentType: paymentType); // Properly update payment type
  }

  void setTermsAccepted(bool isAccepted) {
    state = state.copyWith(isAcceptedTAP: isAccepted);
  }

  // Check if all items have only COD payment type
  bool isOnlyCODPaymentType() {
    return state.cartProducts.every((item) => item.paymentType == "COD");
  }

  // Check if at least one item requires online payment
  bool hasOnlinePayment() {
    return state.cartProducts.any((item) => item.paymentType == "DVP");
  }

  void setBillingAddress(AllAddressData addressData) async {
    state = state.copyWith(billingAddress: addressData);
  }

  void setShippingAddress(
      {required AllAddressData addressData,
      required BuildContext context}) async {
    state = state.copyWith(
        shippingAddress: addressData, billingAddress: addressData);
    Navigation.push(context, appRoutes: AppRoutes.addPaymentOption);
  }
}

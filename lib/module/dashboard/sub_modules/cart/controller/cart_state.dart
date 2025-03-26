import '../../account/sub_modules/address/model/all_address_model.dart';
import '../model/cart_product.dart';
import '../model/payment_type.dart';

class CartState {
  final bool isLoading;
  final bool isOrderCreateBtnLoading;
  final bool isAcceptedTAP;
  final bool isSameBillingAndShipping;
  final bool isCartBtnLoading;
  final bool isSSLLoading;
  final List<CartProduct> cartProducts;
  final double subtotal;
  final double discount;
  final double shippingFee;
  final PaymentType paymentType;
  final String trxID;
  final String trxNumber;
  final String? currencyType;
  final AllAddressData? shippingAddress;
  final AllAddressData? billingAddress;
  final List<PaymentType> paymentTypes;

  // Main Constructor (NO DEFAULT VALUES HERE)
  CartState({
    required this.isAcceptedTAP,
    required this.isSameBillingAndShipping,
    required this.isLoading,
    required this.isSSLLoading,
    required this.isOrderCreateBtnLoading,
    required this.isCartBtnLoading,
    required this.trxID,
    required this.trxNumber,
    required this.cartProducts,
    required this.shippingAddress,
    required this.billingAddress,
    required this.currencyType,
    required this.subtotal,
    required this.discount,
    required this.shippingFee,
    required this.paymentType,
    required this.paymentTypes,
  });

  // Named Constructor for Default Values
  factory CartState.initial() {
    return CartState(
      isAcceptedTAP: false,
      isSameBillingAndShipping: true,
      isLoading: false,
      isSSLLoading: false,
      isOrderCreateBtnLoading: false,
      isCartBtnLoading: false,
      trxID: "",
      trxNumber: "",
      cartProducts: [],
      shippingAddress: null,
      billingAddress: null,
      currencyType: null,
      subtotal: 0.0,
      discount: 0.0,
      shippingFee: 0.0,
      paymentType:
      PaymentType(title: "Cash on Delivery", name: "COD", index: 1),
      // Default COD
      paymentTypes: [
        PaymentType(title: "Pay Online", name: "DVP", index: 0),
        PaymentType(title: "Cash on Delivery", name: "COD", index: 1),
      ], // Default list
    );
  }

  // CopyWith method to modify state
  CartState copyWith({
    bool? isLoading,
    bool? isAcceptedTAP,
    bool? isSameBillingAndShipping,
    bool? isCartBtnLoading,
    bool? isSSLLoading,
    bool? isOrderCreateBtnLoading,
    PaymentType? paymentType,
    String? currencyType,
    String? trxNumber,
    String? trxID,
    List<CartProduct>? cartProducts,
    AllAddressData? shippingAddress,
    AllAddressData? billingAddress,
    double? subtotal,
    double? discount,
    double? shippingFee,
    List<PaymentType>? paymentTypes,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      trxNumber: trxNumber ?? this.trxNumber,
      trxID: trxID ?? this.trxID,
      isSSLLoading: isSSLLoading ?? this.isSSLLoading,
      isOrderCreateBtnLoading:
          isOrderCreateBtnLoading ?? this.isOrderCreateBtnLoading,
      isAcceptedTAP: isAcceptedTAP ?? this.isAcceptedTAP,
      isSameBillingAndShipping:
          isSameBillingAndShipping ?? this.isSameBillingAndShipping,
      isCartBtnLoading: isCartBtnLoading ?? this.isCartBtnLoading,
      paymentType: paymentType ?? this.paymentType,
      currencyType: currencyType ?? this.currencyType,
      cartProducts: cartProducts ?? this.cartProducts,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      billingAddress: billingAddress ?? this.billingAddress,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      shippingFee: shippingFee ?? this.shippingFee,
      paymentTypes: paymentTypes ?? this.paymentTypes,
    );
  }
}

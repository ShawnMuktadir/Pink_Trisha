class OrderDetailsResponse {
  int? statusCode;
  String? message;
  OrderDetailsData? data;

  OrderDetailsResponse({this.statusCode, this.message, this.data});

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    return OrderDetailsResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      data:
          json['data'] != null ? OrderDetailsData.fromJson(json['data']) : null,
    );
  }
}

class OrderDetailsData {
  String? deliveryStatus;
  String? customerCity;
  String? customerName;
  String? customerCountry;
  String? customerPostCode;
  String? customerPhoneNumberShipping;
  String? customerAddressShipping;
  String? customerAreaShipping;
  String? customerCityShipping;
  String? customerCountryShipping;
  int? subTotal;
  List<OrderDetailsItem>? orderItems;

  OrderDetailsData({
    this.deliveryStatus,
    this.customerCity,
    this.customerName,
    this.customerCountry,
    this.customerPostCode,
    this.customerPhoneNumberShipping,
    this.customerAddressShipping,
    this.customerAreaShipping,
    this.customerCityShipping,
    this.customerCountryShipping,
    this.subTotal,
    this.orderItems,
  });

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) {
    return OrderDetailsData(
      deliveryStatus: json['deliveryStatus'],
      customerCity: json['customerCity'],
      customerName: json['customerName'],
      customerCountry: json['customerCountry'],
      customerPostCode: json['customerPostCode'],
      customerPhoneNumberShipping: json['customerPhoneNumberShipping'],
      customerAddressShipping: json['customerAddressShipping'],
      customerAreaShipping: json['customerAreaShipping'],
      customerCityShipping: json['customerCityShipping'],
      customerCountryShipping: json['customerCountryShipping'],
      subTotal: json['subTotal'],
      orderItems: json['orderItems'] != null
          ? (json['orderItems'] as List)
              .map((item) => OrderDetailsItem.fromJson(item))
              .toList()
          : null,
    );
  }
}

class OrderDetailsItem {
  DateTime? createdAt;
  int? quantity;
  int? productId;
  String? productName;
  int? productPrice;
  int? productOfferPrice;
  int? productOfferPriceInUSD;
  int? productPriceInUSD;
  String? paymentType;
  String? productNameBn;
  int? orderId;
  String? deliveryStatus;
  List<String>?
      productVariants; // You can replace 'dynamic' with the actual type of productVariants
  List<String>?
      productAttributes; // You can replace 'dynamic' with the actual type of productAttributes
  OrderDetailsPayment? order;
  OrderDetailsProduct? product;

  OrderDetailsItem({
    this.createdAt,
    this.quantity,
    this.productId,
    this.productName,
    this.productPrice,
    this.productOfferPrice,
    this.productOfferPriceInUSD,
    this.productPriceInUSD,
    this.paymentType,
    this.productNameBn,
    this.orderId,
    this.deliveryStatus,
    this.productVariants,
    this.productAttributes,
    this.order,
    this.product,
  });

  factory OrderDetailsItem.fromJson(Map<String, dynamic> json) {
    return OrderDetailsItem(
      createdAt: DateTime.tryParse(json['createdAt']),
      quantity: json['quantity'],
      productId: json['productId'],
      productName: json['productName'],
      productPrice: json['productPrice'],
      productOfferPrice: json['productOfferPrice'],
      productOfferPriceInUSD: json['productOfferPriceInUSD'],
      productPriceInUSD: json['productPriceInUSD'],
      paymentType: json['paymentType'],
      productNameBn: json['productNameBn'],
      orderId: json['orderId'],
      deliveryStatus: json['deliveryStatus'],
      productVariants: json['productVariants'] != null
          ? (json['productVariants'] as List)
              .map((item) => item.toString())
              .toList()
          : null,
      productAttributes: json['productAttributes'] != null
          ? (json['productAttributes'] as List)
              .map((item) => item.toString())
              .toList()
          : null,
      order: json['order'] != null
          ? OrderDetailsPayment.fromJson(json['order'])
          : null,
      product: json['product'] != null
          ? OrderDetailsProduct.fromJson(json['product'])
          : null,
    );
  }
}

class OrderDetailsPayment {
  List<dynamic>?
      orderPayments; // You can replace 'dynamic' with the actual type of orderPayments

  OrderDetailsPayment({this.orderPayments});

  factory OrderDetailsPayment.fromJson(Map<String, dynamic> json) {
    return OrderDetailsPayment(
      orderPayments: json['orderPayments'],
    );
  }
}

class OrderDetailsProduct {
  String? name;
  String? imageUrl;
  int? id;
  String? paymentType;
  int? price;
  int? priceInUSD;
  int? offerPrice;
  int? offerPriceInUSD;
  List<OrderDetailsProductImage>?
      productImages; // You can replace 'dynamic' with the actual type of productImages
  int? estimatedDeliveryDayNumber;

  OrderDetailsProduct({
    this.name,
    this.imageUrl,
    this.id,
    this.paymentType,
    this.price,
    this.priceInUSD,
    this.offerPrice,
    this.offerPriceInUSD,
    this.productImages,
    this.estimatedDeliveryDayNumber,
  });

  factory OrderDetailsProduct.fromJson(Map<String, dynamic> json) {
    return OrderDetailsProduct(
      name: json['name'],
      imageUrl: json['imageUrl'],
      id: json['id'],
      paymentType: json['paymentType'],
      price: json['price'],
      priceInUSD: json['priceInUSD'],
      offerPrice: json['offerPrice'],
      offerPriceInUSD: json['offerPriceInUSD'],
      productImages: json['productImages'] != null
          ? (json['productImages'] as List)
              .map((item) => OrderDetailsProductImage.fromJson(item))
              .toList()
          : null,
      estimatedDeliveryDayNumber: json['estimatedDeliveryDayNumber'],
    );
  }
}

class OrderDetailsProductImage {
  String? src;

  OrderDetailsProductImage({this.src});

  factory OrderDetailsProductImage.fromJson(Map<String, dynamic> json) {
    return OrderDetailsProductImage(
      src: json['src'],
    );
  }
}

class HomePriceCalculationSendData {
  final int onDemandCountryId;
  final int onDemandProductTypeId;
  final double productPrice;
  final double sellerShippingFee;
  final double weight;
  final String weightUnit;

  HomePriceCalculationSendData({
    required this.onDemandCountryId,
    required this.onDemandProductTypeId,
    required this.productPrice,
    required this.sellerShippingFee,
    required this.weight,
    required this.weightUnit,
  });

  Map<String, dynamic> toMap() {
    return {
      'onDemandCountryId': onDemandCountryId,
      'onDemandProductTypeId': onDemandProductTypeId,
      'productPrice': productPrice,
      'sellerShippingFee': sellerShippingFee,
      'weight': weight,
      'weightUnit': weightUnit,
    };
  }
}

class HomePriceCalculationResponse {
  int? statusCode;
  String? message;
  PriceCalculationData? data;

  HomePriceCalculationResponse({this.statusCode, this.message, this.data});

  factory HomePriceCalculationResponse.fromJson(Map<String, dynamic> json) {
    return HomePriceCalculationResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? PriceCalculationData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class PriceCalculationData {
  int? itemPrice;
  int? shippingFee;
  int? pinkByTrishaFee;
  int? totalPrice;

  PriceCalculationData({
    this.itemPrice,
    this.shippingFee,
    this.pinkByTrishaFee,
    this.totalPrice,
  });

  factory PriceCalculationData.fromJson(Map<String, dynamic> json) {
    return PriceCalculationData(
      itemPrice: json['itemPrice'],
      shippingFee: json['shippingFee'],
      pinkByTrishaFee: json['pinkByTrishaFee'],
      totalPrice: json['totalPrice'],
    );
  }
}

class ReviewPriceSendData {
  final String onDemandCountry;
  final String onDemandProductTypeName;
  final String url;
  final double productPrice;
  final String productPriceUnit;
  final double weight;
  final String weightUnit;
  final double sellerShippingFee;
  final int length;
  final int width;
  final int height;
  final String dimensionUnit;
  final double itemPrice;
  final double shippingFee;
  final double pinkByTrishaFee;
  final double totalPrice;
  final String status;

  ReviewPriceSendData({
    required this.onDemandCountry,
    required this.onDemandProductTypeName,
    required this.url,
    required this.productPrice,
    required this.productPriceUnit,
    required this.weight,
    required this.weightUnit,
    required this.sellerShippingFee,
    required this.length,
    required this.width,
    required this.height,
    required this.dimensionUnit,
    required this.itemPrice,
    required this.shippingFee,
    required this.pinkByTrishaFee,
    required this.totalPrice,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      "onDemandCountry": onDemandCountry,
      "onDemandProductTypeName": onDemandProductTypeName,
      "url": url,
      "productPrice": productPrice,
      "productPriceUnit": productPriceUnit,
      "weight": weight,
      "weightUnit": weightUnit,
      "sellerShippingFee": sellerShippingFee,
      "length": length,
      "width": width,
      "height": height,
      "dimensionUnit": dimensionUnit,
      "itemPrice": itemPrice,
      "shippingFee": shippingFee,
      "pinkByTrishaFee": pinkByTrishaFee,
      "totalPrice": totalPrice,
      "status": status,
    };
  }
}

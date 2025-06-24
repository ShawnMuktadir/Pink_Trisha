import '../../../../../utils/math_util.dart';

class ReviewPriceResponse {
  int? statusCode;
  String? message;
  Data? data;

  ReviewPriceResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory ReviewPriceResponse.fromJson(Map<String, dynamic> json) {
    return ReviewPriceResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  int? id;
  int? customerId;
  int? onDemandOrderId;
  String? onDemandCountry;
  String? url;
  String? onDemandProductTypeName;
  double? productPrice;
  String? productPriceUnit;
  double? weight;
  String? weightUnit;
  double? sellerShippingFee;
  double? length;
  double? width;
  double? height;
  String? dimensionUnit;
  double? itemPrice;
  double? shippingFee;
  double? pinkByTrishaFee;
  double? totalPrice;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.customerId,
    this.onDemandOrderId,
    this.onDemandCountry,
    this.url,
    this.onDemandProductTypeName,
    this.productPrice,
    this.productPriceUnit,
    this.weight,
    this.weightUnit,
    this.sellerShippingFee,
    this.length,
    this.width,
    this.height,
    this.dimensionUnit,
    this.itemPrice,
    this.shippingFee,
    this.pinkByTrishaFee,
    this.totalPrice,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      customerId: json['customerId'],
      onDemandOrderId: json['onDemandOrderId'],
      onDemandCountry: json['onDemandCountry'],
      url: json['url'],
      onDemandProductTypeName: json['onDemandProductTypeName'],
      productPrice:  parseToDouble(json['productPrice']),
      productPriceUnit: json['productPriceUnit'],
      weight: json['weight']?.toDouble(),
      weightUnit: json['weightUnit'],
      sellerShippingFee: json['sellerShippingFee']?.toDouble(),
      length: json['length']?.toDouble(),
      width: json['width']?.toDouble(),
      height: json['height']?.toDouble(),
      dimensionUnit: json['dimensionUnit'],
      itemPrice: json['itemPrice']?.toDouble(),
      shippingFee: json['shippingFee']?.toDouble(),
      pinkByTrishaFee: json['pinkByTrishaFee']?.toDouble(),
      totalPrice:  parseToDouble(json['totalPrice']),
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class ReviewPriceConfirmationResponse {
  int? statusCode;
  String? message;
  Data? data;

  ReviewPriceConfirmationResponse({this.statusCode, this.message, this.data});

  factory ReviewPriceConfirmationResponse.fromJson(Map<String, dynamic> json) {
    return ReviewPriceConfirmationResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  int? id;
  int? customerId;
  String? onDemandCountry;
  String? url;
  String? onDemandProductTypeName;
  dynamic productPrice;
  String? productPriceUnit;
  dynamic weight;
  String? weightUnit;
  dynamic sellerShippingFee;
  dynamic length;
  dynamic width;
  dynamic height;
  String? dimensionUnit;
  dynamic itemPrice;
  dynamic shippingFee;
  dynamic pinkByTrishaFee;
  dynamic totalPrice;
  String? orderStatus;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.customerId,
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
    this.orderStatus,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      customerId: json['customerId'],
      onDemandCountry: json['onDemandCountry'],
      url: json['url'],
      onDemandProductTypeName: json['onDemandProductTypeName'],
      productPrice: json['productPrice'],
      productPriceUnit: json['productPriceUnit'],
      weight: json['weight'],
      weightUnit: json['weightUnit'],
      sellerShippingFee: json['sellerShippingFee'],
      length: json['length'],
      width: json['width'],
      height: json['height'],
      dimensionUnit: json['dimensionUnit'],
      itemPrice: json['itemPrice'],
      shippingFee: json['shippingFee'],
      pinkByTrishaFee: json['pinkByTrishaFee'],
      totalPrice: json['totalPrice'],
      orderStatus: json['orderStatus'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class ProductListResponse {
  int? statusCode;
  String? message;
  List<Product>? data;
  int? totalCount;

  ProductListResponse(
      {this.statusCode, this.totalCount, this.message, this.data});

  factory ProductListResponse.fromJson(Map<String, dynamic> json) {
    return ProductListResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      totalCount: json['data']['totalCount'],
      data: (json['data']?['products'] as List<dynamic>?)
          ?.map((product) => Product.fromJson(product))
          .toList(),
    );
  }
}

class Product {
  int id;
  String name;
  dynamic price;
  dynamic offerPrice;
  int? categoryId;
  String? nameBn;
  String? shortDescription;
  String? imageUrl;
  double? priceInUSD;
  double? offerPriceInUSD;
  String? slug;
  int? baseAttributeId;
  int? points;
  int? vendorId;
  int? brandId;
  List<ProductImage>? productImages;
  String? paymentType;
  int? quantity;
  bool? isFeatured;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.offerPrice,
    required this.categoryId,
    this.nameBn,
    this.shortDescription,
    this.imageUrl,
    this.priceInUSD,
    this.offerPriceInUSD,
    this.slug,
    this.baseAttributeId,
    this.points,
    this.vendorId,
    this.brandId,
    this.productImages,
    this.paymentType,
    this.quantity,
    this.isFeatured,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      nameBn: json['nameBn'],
      shortDescription: json['shortDescription'],
      imageUrl: json['imageUrl'],
      price: json['price']?.toDouble(),
      offerPrice: json['offerPrice']?.toDouble(),
      priceInUSD: json['priceInUSD']?.toDouble(),
      offerPriceInUSD: json['offerPriceInUSD']?.toDouble(),
      slug: json['slug'],
      baseAttributeId: json['baseAttributeId'],
      points: json['points'],
      vendorId: json['vendorId'],
      brandId: json['brandId'],
      categoryId: json['categoryId'],
      productImages: json['productImages'] != null
          ? List<ProductImage>.from(
              json['productImages'].map((x) => ProductImage.fromJson(x)))
          : null,
      paymentType: json['paymentType'],
      quantity: json['quantity'],
      isFeatured: json['isFeatured'],
    );
  }
}

// class ProductImage {
//   String? src;

//   ProductImage({
//     this.src,
//   });

//   factory ProductImage.fromJson(Map<String, dynamic> json) {
//     return ProductImage(
//       src: json['src'],
//     );
//   }
// }

class ProductImage {
  int? id;
  int? productId;
  String? src;
  String? alt;
  String? description;
  int? serial;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductImage({
    this.id,
    this.productId,
    this.src,
    this.alt,
    this.description,
    this.serial,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      productId: json['productId'],
      src: json['src'],
      alt: json['alt'],
      description: json['description'],
      serial: json['serial'],
      status: json['status'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}

class Category {
  String? bannerImageUrl;

  Category({this.bannerImageUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      bannerImageUrl: json['bannerImageUrl'],
    );
  }
}

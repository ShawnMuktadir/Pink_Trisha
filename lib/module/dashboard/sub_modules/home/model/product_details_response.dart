class ProductModel {
  int? statusCode;
  String? message;
  ProductData? data;

  ProductModel({this.statusCode, this.message, this.data});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null ? ProductData.fromJson(json['data']) : null,
    );
  }
}

class ProductData {
  int? id;
  String? name;
  String? nameBn;
  String? shortDescription;
  String? imageUrl;
  int? price;
  int? offerPrice;
  String? productReturnPolicy;
  String? productWarranty;
  String? longDescription;
  Category? category;
  List<ProductImageData>? productImages;
  List<ProductVideo>? productVideos;
  List<ProductSpecification>? productSpecifications;
  List<ProductVariant>? productVariants;
  List<dynamic>? attributes;

  ProductData({
    this.id,
    this.name,
    this.nameBn,
    this.shortDescription,
    this.imageUrl,
    this.price,
    this.offerPrice,
    this.productReturnPolicy,
    this.productWarranty,
    this.longDescription,
    this.category,
    this.productImages,
    this.productVideos,
    this.productSpecifications,
    this.productVariants,
    this.attributes,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'],
      name: json['name'],
      nameBn: json['nameBn'],
      shortDescription: json['shortDescription'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      offerPrice: json['offerPrice'],
      productReturnPolicy: json['productReturnPolicy'],
      productWarranty: json['productWarranty'],
      longDescription: json['longDescription'],
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      productImages: (json['productImages'] as List<dynamic>?)
          ?.map((image) => ProductImageData.fromJson(image))
          .toList(),
      productVideos: [],
      productSpecifications: [],
      productVariants: [],
      attributes: json['attributes'],
    );
  }
}

class Category {
  int? id;
  String? bannerImageUrl;

  Category({this.id, this.bannerImageUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      bannerImageUrl: json['bannerImageUrl'],
    );
  }
}

class ProductImageData {
  String? src;
  String? alt;
  String? description;

  ProductImageData({this.src, this.alt, this.description});

  factory ProductImageData.fromJson(Map<String, dynamic> json) {
    return ProductImageData(
      src: json['src'],
      alt: json['alt'],
      description: json['description'],
    );
  }
}

class ProductVideo {}

class ProductSpecification {}

class ProductAttribute {
  final int id;
  final String name;
  final String? nameBn;

  ProductAttribute({
    required this.id,
    required this.name,
    this.nameBn,
  });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) {
    return ProductAttribute(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nameBn: json['nameBn'],
    );
  }
}

class ProductVariant {
  final int id;
  final String name;
  final double price;
  final double offerPrice;
  final int quantity;
  final ProductAttribute attribute;

  ProductVariant({
    required this.id,
    required this.name,
    required this.price,
    required this.offerPrice,
    required this.quantity,
    required this.attribute,
  });
}

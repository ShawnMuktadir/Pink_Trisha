import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/model/product_details_response.dart';

class ProductDetailsResponse {
  final int? statusCode;
  final String? message;
  final ProductDetailsData? data;

  ProductDetailsResponse({this.statusCode, this.message, this.data});

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailsResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? ProductDetailsData.fromJson(json['data'])
          : null,
    );
  }
}

class ProductDetailsData {
  final int? id;
  final int? quantity;
  final String? name;
  final String? nameBn;
  final String? shortDescription;
  final String? longDescription;
  final String? imageUrl;
  final dynamic price;
  final dynamic offerPrice;
  final String? productReturnPolicy;
  final String? productWarranty;
  final int? estimatedDeliveryDayNumber;
  final Category? category;
  final List<ProductDetailsImage>? productImages;
  final List<ProductDetailsSpecification>? productSpecifications;
  final List<ProductDetailsVariant>? productVariants;
  final ProductAttribute? attributes;

  final String? sku;
  final String? paymentType;
  final int? categoryId;
  final int? points;

  ProductDetailsData({
    this.id,
    this.quantity,
    this.name,
    this.nameBn,
    this.shortDescription,
    this.longDescription,
    this.imageUrl,
    this.price,
    this.offerPrice,
    this.productReturnPolicy,
    this.productWarranty,
    this.estimatedDeliveryDayNumber,
    this.category,
    this.productImages,
    this.productSpecifications,
    this.productVariants,
    this.attributes,
    this.sku,
    this.paymentType,
    this.categoryId,
    this.points,
  });

  factory ProductDetailsData.fromJson(Map<String, dynamic> json) {
    return ProductDetailsData(
      id: json['id'],
      quantity: json['quantity'],
      name: json['name'],
      nameBn: json['nameBn'],
      shortDescription: json['shortDescription'],
      longDescription: json['longDescription'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      offerPrice: json['offerPrice'],
      productReturnPolicy: json['productReturnPolicy'],
      productWarranty: json['productWarranty'],
      estimatedDeliveryDayNumber: json['estimatedDeliveryDayNumber'],
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      productImages: (json['productImages'] as List<dynamic>?)
          ?.map((e) => ProductDetailsImage.fromJson(e))
          .toList(),
      productSpecifications: (json['productSpecifications'] as List<dynamic>?)
          ?.map((e) => ProductDetailsSpecification.fromJson(e))
          .toList(),
      productVariants: (json['productVariants'] as List<dynamic>?)
          ?.map((e) => ProductDetailsVariant.fromJson(e))
          .toList(),
      attributes: json['attributes'] != null
          ? ProductAttribute.fromJson(json['attributes'])
          : null,
      sku: json['sku'],
      paymentType: json['paymentType'],
      categoryId: json['categoryId'],
      points: json['points'],
    );
  }
}

class Category {
  final int? id;
  final String? bannerImageUrl;

  Category({this.id, this.bannerImageUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      bannerImageUrl: json['bannerImageUrl'],
    );
  }
}

class ProductDetailsImage {
  final String src;
  final String alt;
  final String description;
  final List<ProductVariant> productVariants;

  ProductDetailsImage({
    required this.src,
    required this.alt,
    required this.description,
    required this.productVariants,
  });

  factory ProductDetailsImage.fromJson(Map<String, dynamic> json) {
    List<ProductVariant> variants = [];
    if (json['productVariants'] != null) {
      variants = List<ProductVariant>.from(json['productVariants']
          .map((variantJson) => ProductVariant.fromJson(variantJson)));
    }
    return ProductDetailsImage(
      src: json['src'] ?? '',
      alt: json['alt'] ?? '',
      description: json['description'] ?? '',
      productVariants: variants,
    );
  }
}

class ProductVariant {
  final int id;

  ProductVariant({
    required this.id,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'] ?? 0,
    );
  }
}

class ProductDetailsSpecification {
  final String? key;
  final String? value;
  final SpecificationTitle? specificationTitle;

  ProductDetailsSpecification({this.key, this.value, this.specificationTitle});

  factory ProductDetailsSpecification.fromJson(Map<String, dynamic> json) {
    return ProductDetailsSpecification(
      key: json['key'],
      value: json['value'],
      specificationTitle: json['specificationTitle'] != null
          ? SpecificationTitle.fromJson(json['specificationTitle'])
          : null,
    );
  }
}

class SpecificationTitle {
  final String? name;
  final String? nameBn;

  SpecificationTitle({this.name, this.nameBn});

  factory SpecificationTitle.fromJson(Map<String, dynamic> json) {
    return SpecificationTitle(
      name: json['name'],
      nameBn: json['nameBn'],
    );
  }
}

class ProductDetailsVariant {
  final int? id;
  final String? name;
  final double? price;
  final double? offerPrice;
  final int? quantity;
  final ProductImageModel? productImage;
  final Attribute? attribute;

  ProductDetailsVariant(
      {this.quantity,
      this.productImage,
      this.id,
      this.name,
      this.price,
      this.offerPrice,
      this.attribute});

  factory ProductDetailsVariant.fromJson(Map<String, dynamic> json) {
    return ProductDetailsVariant(
      id: json['id'],
      name: json['name'],
      price: json['price']?.toDouble(),
      offerPrice: json['offerPrice']?.toDouble(),
      quantity: json['quantity'],
      productImage: json['productImage'] != null
          ? ProductImageModel.fromJson(json['productImage'])
          : null,
      attribute: json['attribute'] != null
          ? Attribute.fromJson(json['attribute'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'offerPrice': offerPrice,
      'quantity': quantity,
      'productImage': productImage?.toJson(),
      'attribute': attribute?.toJson(),
    };
  }
}

class Attribute {
  int? id;
  String? name;
  String? nameBn;

  Attribute({
    this.id,
    this.name,
    this.nameBn,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      id: json['id'],
      name: json['name'],
      nameBn: json['nameBn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameBn': nameBn,
    };
  }
}

class ProductImageModel {
  String? src;
  int? productId;

  ProductImageModel({
    this.src,
    this.productId,
  });

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
      src: json['src'],
      productId: json['productId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'src': src,
      'productId': productId,
    };
  }
}

class Parent {
  int? id;
  String? name;
  int? quantity;

  Parent({
    this.id,
    this.name,
    this.quantity,
  });

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
    );
  }
}

class Child {
  int? id;
  String? name;
  int? quantity;
  Attribute? attribute;
  Parent? parent;
  List<Child>? children;

  Child({
    this.id,
    this.name,
    this.quantity,
    this.attribute,
    this.parent,
    this.children,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      attribute: json['attribute'] != null
          ? Attribute.fromJson(json['attribute'])
          : null,
      parent: json['parent'] != null ? Parent.fromJson(json['parent']) : null,
      children: json['children'] != null
          ? List<Child>.from(json['children'].map((x) => Child.fromJson(x)))
          : null,
    );
  }
}

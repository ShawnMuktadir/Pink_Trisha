import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/model/product_list_response.dart';

class HomeResponse {
  int? statusCode;
  String? message;
  Data? data;

  HomeResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  List<HeroBanner>? heroBanners;
  List<FeaturedCategory>? featuredCategories;
  List<ProductModel>? bestDealProducts;
  List<FeaturedBrand>? featuredBrands;
  List<ProductModel>? featuredProducts;

  Data({
    this.heroBanners,
    this.featuredCategories,
    this.bestDealProducts,
    this.featuredBrands,
    this.featuredProducts,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      heroBanners: (json['heroBanners'] as List<dynamic>?)
          ?.map((banner) => HeroBanner.fromJson(banner))
          .toList(),
      featuredCategories: (json['featuredCategories'] as List<dynamic>?)
          ?.map((category) => FeaturedCategory.fromJson(category))
          .toList(),
      bestDealProducts: (json['bestDealProducts'] as List<dynamic>?)
          ?.map((product) => ProductModel.fromJson(product))
          .toList(),
      featuredBrands: (json['featuredBrands'] as List<dynamic>?)
          ?.map((brand) => FeaturedBrand.fromJson(brand))
          .toList(),
      featuredProducts: (json['featuredProducts'] as List<dynamic>?)
          ?.map((product) => ProductModel.fromJson(product))
          .toList(),
    );
  }
}

class HeroBanner {
  int? id;
  String? title;
  String? subtitle;
  String? description;
  String? imageUrl;
  String? imageUrlMobile;
  String? url;
  int? serial;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  HeroBanner({
    this.id,
    this.title,
    this.subtitle,
    this.description,
    this.imageUrl,
    this.imageUrlMobile,
    this.url,
    this.serial,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory HeroBanner.fromJson(Map<String, dynamic> json) {
    return HeroBanner(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      imageUrlMobile: json['imageUrlMobile'],
      url: json['url'],
      serial: json['serial'],
      status: json['status'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}

class FeaturedCategory {
  int? id;
  String? name;
  String? nameBn;
  String? imageUrl;
  String? imageUrlMobile;
  bool? isFeatured;
  FeaturedCategory({
    this.id,
    this.name,
    this.nameBn,
    this.imageUrl,
    this.imageUrlMobile,
    this.isFeatured,
  });

  factory FeaturedCategory.fromJson(Map<String, dynamic> json) {
    return FeaturedCategory(
      id: json['id'],
      name: json['name'],
      nameBn: json['nameBn'],
      imageUrl: json['imageUrl'],
      imageUrlMobile: json['imageUrlMobile'],
      isFeatured: json['isFeatured'],
    );
  }
}

class ProductModel {
  int? id;
  Product? product;

  ProductModel({
    this.id,
    this.product,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      product:
          json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }
}

class FeaturedBrand {
  int? id;
  String? name;
  String? nameBn;
  String? imageUrl;
  bool? isFeatured;

  FeaturedBrand({
    this.id,
    this.name,
    this.nameBn,
    this.imageUrl,
    this.isFeatured,
  });

  factory FeaturedBrand.fromJson(Map<String, dynamic> json) {
    return FeaturedBrand(
      id: json['id'],
      name: json['name'],
      nameBn: json['nameBn'],
      imageUrl: json['imageUrl'],
      isFeatured: json['isFeatured'],
    );
  }
}

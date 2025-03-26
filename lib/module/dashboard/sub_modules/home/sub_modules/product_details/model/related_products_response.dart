import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/model/product_list_response.dart';

class RelatedProductsResponse {
  int? statusCode;
  String? message;
  List<Product>? data;

  RelatedProductsResponse({this.statusCode, this.message, this.data});

  factory RelatedProductsResponse.fromJson(Map<String, dynamic> json) {
    return RelatedProductsResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((product) => Product.fromJson(product))
          .toList(),
    );
  }
}

// class RelatedProduct {
//   int? id;
//   String? name;
//   String? nameBn;
//   String? slug;
//   String? shortDescription;
//   String? imageUrl;
//   double? price;
//   double? offerPrice;
//   List<ProductImage>? productImages;
//   Category? category;

//   RelatedProduct({
//     this.id,
//     this.name,
//     this.nameBn,
//     this.slug,
//     this.shortDescription,
//     this.imageUrl,
//     this.price,
//     this.offerPrice,
//     this.productImages,
//     this.category,
//   });

//   factory RelatedProduct.fromJson(Map<String, dynamic> json) {
//     return RelatedProduct(
//       id: json['id'],
//       name: json['name'],
//       nameBn: json['nameBn'],
//       slug: json['slug'],
//       shortDescription: json['shortDescription'],
//       imageUrl: json['imageUrl'],
//       price: json['price']?.toDouble(),
//       offerPrice: json['offerPrice']?.toDouble(),
//       productImages: (json['productImages'] as List<dynamic>?)
//           ?.map((image) => ProductImage.fromJson(image))
//           .toList(),
//       category:
//           json['category'] != null ? Category.fromJson(json['category']) : null,
//     );
//   }
// }

// class ProductImage {
//   int? id;
//   int? productId;
//   String? src;
//   String? alt;
//   String? description;
//   int? serial;
//   String? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   ProductImage({
//     this.id,
//     this.productId,
//     this.src,
//     this.alt,
//     this.description,
//     this.serial,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory ProductImage.fromJson(Map<String, dynamic> json) {
//     return ProductImage(
//       id: json['id'],
//       productId: json['productId'],
//       src: json['src'],
//       alt: json['alt'],
//       description: json['description'],
//       serial: json['serial'],
//       status: json['status'],
//       createdAt:
//           json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
//       updatedAt:
//           json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
//     );
//   }
// }

// class Category {
//   String? bannerImageUrl;
//   int id;
//   Category({this.bannerImageUrl, required this.id});

//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       bannerImageUrl: json['bannerImageUrl'],
//       id: json['id'],
//     );
//   }
// }

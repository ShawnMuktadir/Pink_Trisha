import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/model/product_list_response.dart';

class WishListResponse {
  int statusCode;
  String message;
  List<WishItem> data;

  WishListResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory WishListResponse.fromJson(Map<String, dynamic> json) {
    return WishListResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List<dynamic>)
          .map((item) => WishItem.fromJson(item))
          .toList(),
    );
  }
}

class WishItem {
  int id;
  int customerId;
  Product product;

  WishItem({
    required this.id,
    required this.customerId,
    required this.product,
  });

  factory WishItem.fromJson(Map<String, dynamic> json) {
    return WishItem(
      id: json['id'],
      customerId: json['customerId'],
      product: Product.fromJson(json['product']),
    );
  }
}

// class Product {
//   int id;
//   String? name;
//   String? nameBn;
//   String? shortDescription;
//   int price;
//   int offerPrice;
//   int priceInUSD;
//   int offerPriceInUSD;
//   String slug;
//   List<ProductImage> productImages;

//   Product({
//     required this.id,
//     required this.name,
//     this.nameBn,
//     required this.shortDescription,
//     required this.price,
//     required this.offerPrice,
//     required this.priceInUSD,
//     required this.offerPriceInUSD,
//     required this.slug,
//     required this.productImages,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       name: json['name'],
//       nameBn: json['nameBn'],
//       shortDescription: json['shortDescription'],
//       price: json['price'],
//       offerPrice: json['offerPrice'],
//       priceInUSD: json['priceInUSD'],
//       offerPriceInUSD: json['offerPriceInUSD'],
//       slug: json['slug'],
//       productImages: (json['productImages'] as List<dynamic>)
//           .map((image) => ProductImage.fromJson(image))
//           .toList(),
//     );
//   }
// }

// class ProductImage {
//   String? src;

//   ProductImage({required this.src});

//   factory ProductImage.fromJson(Map<String, dynamic> json) {
//     return ProductImage(src: json['src']);
//   }
// }

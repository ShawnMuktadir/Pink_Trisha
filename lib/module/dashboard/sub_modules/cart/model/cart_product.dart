import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/model/payment_type.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/controller/product_details_state.dart';

final List<PaymentType> paymentTypes = [
  PaymentType(
      title: 'bKash',
      name: 'bKash',
      index: 0,
      imageLink: 'link_to_bkash_image'),
  PaymentType(
      title: 'Nagad',
      name: 'Nagad',
      index: 1,
      imageLink: 'link_to_nagad_image'),
  PaymentType(
      title: 'Pay Online',
      name: 'PayOnline',
      index: 2,
      imageLink: 'link_to_payonline_image'),
  PaymentType(
      title: 'Cash on Delivery',
      name: 'COD',
      index: 3,
      imageLink: 'link_to_cod_image'),
];

class CartProduct {
  final String id;
  final String name;
  final dynamic price;
  final dynamic offerPrice;
  final int? categoryId;
  final int? brandId;
  final String? nameBn;
  final String? imageUrl;
  final String? paymentType;
  final String? shortDescription;
  final String? slug;
  final bool isPreorder;
  final String? productImage;
  final int? vendorId;
  final int quantity;
  final List<SelectedAttributeModel> currentAttributeValueId;
  final List<String>? attributes;
  final List<String>? variants;
  CartProduct({
    this.attributes,
    this.variants,
    required this.brandId,
    required this.categoryId,
    required this.paymentType,
    required this.vendorId,
    required this.currentAttributeValueId,
    required this.id,
    required this.name,
    required this.nameBn,
    required this.slug,
    required this.isPreorder,
    required this.shortDescription,
    required this.imageUrl,
    required this.price,
    required this.offerPrice,
    required this.productImage,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameBn': nameBn,
      'slug': slug,
      'shortDescription': shortDescription,
      'imageUrl': imageUrl,
      'price': price,
      'offerPrice': offerPrice,
      'productImage': productImage,
      'quantity': quantity,
      'isPreorder': isPreorder,
      'brandId': brandId,
      'categoryId': categoryId,
      'paymentType': paymentType,
      'vendorId': vendorId,
      'variantSelected':
          currentAttributeValueId.map((variant) => variant.toJson()).toList(),
    };
  }

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['id'],
      name: json['name'],
      nameBn: json['nameBn'],
      slug: json['slug'],
      shortDescription: json['shortDescription'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      offerPrice: json['offerPrice'],
      productImage: json['productImage'],
      quantity: json['quantity'],
      isPreorder: json['isPreorder'],
      brandId: json['brandId'],
      categoryId: json['categoryId'],
      paymentType: json['paymentType'],
      vendorId: json['vendorId'],
      currentAttributeValueId: (json['variantSelected'] as List<dynamic>)
          .map((variantJson) => SelectedAttributeModel.fromJson(variantJson))
          .toList(),
    );
  }

  CartProduct copyWith({
    String? id,
    String? name,
    String? nameBn,
    String? slug,
    String? shortDescription,
    String? imageUrl,
    dynamic price,
    dynamic offerPrice,
    String? productImage,
    int? quantity,
    bool? isPreorder,
    int? brandId,
    int? categoryId,
    String? paymentType,
    int? vendorId,
  }) {
    return CartProduct(
      id: id ?? this.id,
      name: name ?? this.name,
      nameBn: nameBn ?? this.nameBn,
      slug: slug ?? this.slug,
      shortDescription: shortDescription ?? this.shortDescription,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      offerPrice: offerPrice ?? this.offerPrice,
      productImage: productImage ?? this.productImage,
      quantity: quantity ?? this.quantity,
      isPreorder: isPreorder ?? this.isPreorder,
      brandId: brandId ?? this.brandId,
      categoryId: categoryId ?? this.categoryId,
      paymentType: paymentType ?? this.paymentType,
      vendorId: vendorId ?? this.vendorId,
      currentAttributeValueId: currentAttributeValueId,
    );
  }
}

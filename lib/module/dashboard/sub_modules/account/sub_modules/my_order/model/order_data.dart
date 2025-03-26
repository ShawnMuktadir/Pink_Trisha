class OrderCreateData {
  final int customerId;
  final String customerName;
  final String customerCountryCode;
  final String customerAddress;
  final String customerArea;
  final String customerCity;
  final String customerPostCode;
  final String customerState;
  final String customerCountry;
  final String customerNameShipping;
  final String customerCountryCodeShipping;
  final String customerPhoneNumberShipping;
  final String customerAddressShipping;
  final String customerAreaShipping;
  final String customerCityShipping;
  final String customerPostCodeShipping;
  final String customerStateShipping;
  final String customerCountryShipping;
  final String paymentType;
  final int? couponId;
  final double discountAmount;
  final String currencyType;
  final String note;
  final List<OrderCreateItem> orderItems;
  final bool rewardCheck;
  final String customerEmail;

  OrderCreateData({
    required this.customerId,
    required this.customerName,
    required this.customerCountryCode,
    required this.customerAddress,
    required this.customerArea,
    required this.customerCity,
    required this.customerPostCode,
    required this.customerState,
    required this.customerCountry,
    required this.customerNameShipping,
    required this.customerCountryCodeShipping,
    required this.customerPhoneNumberShipping,
    required this.customerAddressShipping,
    required this.customerAreaShipping,
    required this.customerCityShipping,
    required this.customerPostCodeShipping,
    required this.customerStateShipping,
    required this.customerCountryShipping,
    required this.paymentType,
    required this.couponId,
    required this.discountAmount,
    required this.currencyType,
    required this.note,
    required this.orderItems,
    required this.rewardCheck,
    required this.customerEmail,
  });

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'customerCountryCode': customerCountryCode,
      'customerAddress': customerAddress,
      'customerArea': customerArea,
      'customerCity': customerCity,
      'customerPostCode': customerPostCode,
      'customerState': customerState,
      'customerCountry': customerCountry,
      'customerNameShipping': customerNameShipping,
      'customerCountryCodeShipping': customerCountryCodeShipping,
      'customerPhoneNumberShipping': customerPhoneNumberShipping,
      'customerAddressShipping': customerAddressShipping,
      'customerAreaShipping': customerAreaShipping,
      'customerCityShipping': customerCityShipping,
      'customerPostCodeShipping': customerPostCodeShipping,
      'customerStateShipping': customerStateShipping,
      'customerCountryShipping': customerCountryShipping,
      'paymentType': paymentType,
      'couponId': couponId,
      'discountAmount': discountAmount,
      'currencyType': currencyType,
      'note': note,
      'orderItems': orderItems.map((item) => item.toMap()).toList(),
      'rewardCheck': rewardCheck,
      'customerEmail': customerEmail,
    };
  }
}

class OrderCreateItem {
  final int id;
  final Map<String, dynamic> variantSelected;
  final int? quantity;
  final OrderCreateProductDetail productDetail;

  OrderCreateItem({
    required this.id,
    required this.variantSelected,
    required this.quantity,
    required this.productDetail,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'variantSelected': variantSelected,
      'quantity': quantity,
      'productDetail': productDetail.toMap(),
    };
  }
}

class OrderCreateProductDetail {
  final int id;
  final String name;
  final double price;
  final double offerPrice;
  final int categoryId;
  final String? nameBn;
  final int? brandId;
  final String? imageUrl;
  final String? paymentType;
  final String? shortDescription;
  final String? slug;
  final int? vendorId;
  final int? quantity;
  final Map<String, dynamic> variantSelected;

  OrderCreateProductDetail({
    required this.id,
    required this.name,
    required this.nameBn,
    required this.brandId,
    required this.categoryId,
    required this.imageUrl,
    required this.offerPrice,
    required this.paymentType,
    required this.price,
    required this.shortDescription,
    required this.slug,
    required this.vendorId,
    required this.quantity,
    required this.variantSelected,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'offerPrice': offerPrice,
      'categoryId': categoryId,
      "productImages": null,
      "nameBn": null,
      "shortDescription": null,
      "imageUrl": null,
      "priceInUSD": null,
      "offerPriceInUSD": null,
      "slug": null,
      "paymentType": null,
      "points": null,
      "brandId": null,
      "vendorId": null
      // "id": 1,
      // "name": "Sports",
      // "price": 4,
      // "offerPrice": 12,
      // "categoryId": 3,
    };
  }
  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'nameBn': nameBn,
  //     'brandId': brandId,
  //     'categoryId': categoryId,
  //     'imageUrl': imageUrl,
  //     'offerPrice': offerPrice,
  //     'paymentType': paymentType,
  //     'price': price,
  //     'shortDescription': shortDescription,
  //     'slug': slug,
  //     'vendorId': vendorId,
  //     'quantity': quantity,
  //     'variantSelected': variantSelected,
  //   };
  // }
}

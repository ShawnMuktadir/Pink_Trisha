class RelatedProductModel {
  int? statusCode;
  String? message;
  List<RelatedProductData>? data;

  RelatedProductModel({this.statusCode, this.message, this.data});

  RelatedProductModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RelatedProductData>[];
      json['data'].forEach((v) {
        data!.add(RelatedProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RelatedProductData {
  int? id;
  String? name;
  String? nameBn;
  String? slug;
  String? shortDescription;
  String? imageUrl;
  int? price;
  int? offerPrice;
  List<ProductImages>? productImages;
  Category? category;

  RelatedProductData(
      {this.id,
        this.name,
        this.nameBn,
        this.slug,
        this.shortDescription,
        this.imageUrl,
        this.price,
        this.offerPrice,
        this.productImages,
        this.category});

  RelatedProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameBn = json['nameBn'];
    slug = json['slug'];
    shortDescription = json['shortDescription'];
    imageUrl = json['imageUrl'];
    price = json['price'];
    offerPrice = json['offerPrice'];
    if (json['productImages'] != null) {
      productImages = <ProductImages>[];
      json['productImages'].forEach((v) {
        productImages!.add(ProductImages.fromJson(v));
      });
    }
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['nameBn'] = nameBn;
    data['slug'] = slug;
    data['shortDescription'] = shortDescription;
    data['imageUrl'] = imageUrl;
    data['price'] = price;
    data['offerPrice'] = offerPrice;
    if (productImages != null) {
      data['productImages'] =
          productImages!.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class ProductImages {
  int? id;
  int? productId;
  String? src;
  String? alt;
  String? description;
  int? serial;
  String? status;
  String? createdAt;
  String? updatedAt;

  ProductImages(
      {this.id,
        this.productId,
        this.src,
        this.alt,
        this.description,
        this.serial,
        this.status,
        this.createdAt,
        this.updatedAt});

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    src = json['src'];
    alt = json['alt'];
    description = json['description'];
    serial = json['serial'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productId'] = productId;
    data['src'] = src;
    data['alt'] = alt;
    data['description'] = description;
    data['serial'] = serial;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Category {
  String? bannerImageUrl;

  Category({this.bannerImageUrl});

  Category.fromJson(Map<String, dynamic> json) {
    bannerImageUrl = json['bannerImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bannerImageUrl'] = bannerImageUrl;
    return data;
  }
}

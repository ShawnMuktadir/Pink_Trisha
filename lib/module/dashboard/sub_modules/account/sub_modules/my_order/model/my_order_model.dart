class MyOrderModel {
  int? statusCode;
  String? message;
  List<MyOrderData>? data;

  MyOrderModel({this.statusCode, this.message, this.data});

  MyOrderModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MyOrderData>[];
      for (var item in json['data']) {
        if (item != null) {
          data!.add(MyOrderData.fromJson(item));
        }
      }
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

class MyOrderData {
  String? createdAt;
  int? id;
  List<String>?
      orderAddresses; // Is it supposed to be List<Null> or List<dynamic>?
  String? status;
  String? address;
  String? addressId;
  dynamic subTotal;

  MyOrderData({
    this.createdAt,
    this.id,
    this.orderAddresses,
    this.status,
    this.address,
    this.addressId,
    this.subTotal,
  });

  MyOrderData.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    id = json['id'];
    if (json['orderAddresses'] != null) {
      orderAddresses =
          <String>[]; // Is it supposed to be List<Null> or List<dynamic>?
      for (var item in json['orderAddresses']) {
        if (item != null) {
          orderAddresses!.add(item); // Assuming it's List<dynamic>
        }
      }
    }
    status = json['status'];
    address = json['address'];
    addressId = json['addressId'];
    subTotal = json['subTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['id'] = id;
    if (orderAddresses != null) {
      data['orderAddresses'] = orderAddresses!;
    }
    data['status'] = status;
    data['address'] = address;
    data['addressId'] = addressId;
    data['subTotal'] = subTotal;
    return data;
  }
}

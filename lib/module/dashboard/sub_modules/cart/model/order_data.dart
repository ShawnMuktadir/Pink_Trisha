class OrderData {
  String customerAddress;
  String customerAddressShipping;
  String customerArea;
  String customerAreaShipping;
  String customerCity;
  String customerCityShipping;
  String customerCountry;
  String customerCountryCode;
  String customerCountryCodeShipping;
  String customerCountryShipping;
  int customerId;
  String customerName;
  String customerNameShipping;
  String customerPhoneNumberShipping;
  String customerPostCode;
  String customerPostCodeShipping;
  String customerState;
  String customerStateShipping;
  double discountAmount;
  String note;
  List<OrderItem> orderItems;
  String paymentType;
  double subTotal;

  OrderData({
    required this.customerAddress,
    required this.customerAddressShipping,
    required this.customerArea,
    required this.customerAreaShipping,
    required this.customerCity,
    required this.customerCityShipping,
    required this.customerCountry,
    required this.customerCountryCode,
    required this.customerCountryCodeShipping,
    required this.customerCountryShipping,
    required this.customerId,
    required this.customerName,
    required this.customerNameShipping,
    required this.customerPhoneNumberShipping,
    required this.customerPostCode,
    required this.customerPostCodeShipping,
    required this.customerState,
    required this.customerStateShipping,
    required this.discountAmount,
    required this.note,
    required this.orderItems,
    required this.paymentType,
    required this.subTotal,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      customerAddress: json['customerAddress'],
      customerAddressShipping: json['customerAddressShipping'],
      customerArea: json['customerArea'],
      customerAreaShipping: json['customerAreaShipping'],
      customerCity: json['customerCity'],
      customerCityShipping: json['customerCityShipping'],
      customerCountry: json['customerCountry'],
      customerCountryCode: json['customerCountryCode'],
      customerCountryCodeShipping: json['customerCountryCodeShipping'],
      customerCountryShipping: json['customerCountryShipping'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      customerNameShipping: json['customerNameShipping'],
      customerPhoneNumberShipping: json['customerPhoneNumberShipping'],
      customerPostCode: json['customerPostCode'],
      customerPostCodeShipping: json['customerPostCodeShipping'],
      customerState: json['customerState'],
      customerStateShipping: json['customerStateShipping'],
      discountAmount: json['discountAmount'],
      note: json['note'],
      orderItems: (json['orderItems'] as List)
          .map((itemJson) => OrderItem.fromJson(itemJson))
          .toList(),
      paymentType: json['paymentType'],
      subTotal: json['subTotal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerAddress': customerAddress,
      'customerAddressShipping': customerAddressShipping,
      'customerArea': customerArea,
      'customerAreaShipping': customerAreaShipping,
      'customerCity': customerCity,
      'customerCityShipping': customerCityShipping,
      'customerCountry': customerCountry,
      'customerCountryCode': customerCountryCode,
      'customerCountryCodeShipping': customerCountryCodeShipping,
      'customerCountryShipping': customerCountryShipping,
      'customerId': customerId,
      'customerName': customerName,
      'customerNameShipping': customerNameShipping,
      'customerPhoneNumberShipping': customerPhoneNumberShipping,
      'customerPostCode': customerPostCode,
      'customerPostCodeShipping': customerPostCodeShipping,
      'customerState': customerState,
      'customerStateShipping': customerStateShipping,
      'discountAmount': discountAmount,
      'note': note,
      'orderItems': orderItems.map((item) => item.toJson()).toList(),
      'paymentType': paymentType,
      'subTotal': subTotal,
    };
  }
}

class OrderItem {
  int id;
  int quantity;
  dynamic variantSelected;

  OrderItem({
    required this.id,
    required this.quantity,
    required this.variantSelected,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      quantity: json['quantity'],
      variantSelected: json['variantSelected'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'variantSelected': variantSelected,
    };
  }
}

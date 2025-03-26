class AddAddressModel {
  int? statusCode;
  String? message;
  AddAddressData? data;

  AddAddressModel({this.statusCode, this.message, this.data});

  AddAddressModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? AddAddressData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AddAddressData {
  int? id;
  int? customerId;
  String? firstName;
  String? lastName;
  String? name;
  String? email;
  String? countryCode;
  String? phoneNumber;
  String? address;
  String? apartment;
  String? house;
  String? street;
  String? addressLine;
  String? area;
  String? city;
  String? postCode;
  String? state;
  String? country;
  String? countryISOCode;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;

  AddAddressData(
      {this.id,
        this.customerId,
        this.firstName,
        this.lastName,
        this.name,
        this.email,
        this.countryCode,
        this.phoneNumber,
        this.address,
        this.apartment,
        this.house,
        this.street,
        this.addressLine,
        this.area,
        this.city,
        this.postCode,
        this.state,
        this.country,
        this.countryISOCode,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt});

  AddAddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    name = json['name'];
    email = json['email'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    apartment = json['apartment'];
    house = json['house'];
    street = json['street'];
    addressLine = json['addressLine'];
    area = json['area'];
    city = json['city'];
    postCode = json['postCode'];
    state = json['state'];
    country = json['country'];
    countryISOCode = json['countryISOCode'];
    type = json['type'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customerId'] = customerId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['name'] = name;
    data['email'] = email;
    data['countryCode'] = countryCode;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['apartment'] = apartment;
    data['house'] = house;
    data['street'] = street;
    data['addressLine'] = addressLine;
    data['area'] = area;
    data['city'] = city;
    data['postCode'] = postCode;
    data['state'] = state;
    data['country'] = country;
    data['countryISOCode'] = countryISOCode;
    data['type'] = type;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

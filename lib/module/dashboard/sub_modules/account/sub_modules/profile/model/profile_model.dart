class ProfileModel {
  int? statusCode;
  String? message;
  ProfileData? data;

  ProfileModel({this.statusCode, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
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

class ProfileData {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? countryCode;
  String? phoneNumber;
  String? password;
  String? dob;
  String? imageUrl;
  String? verificationKey;
  String? oneTimePassword;
  String? fcmRegistrationToken;
  int? serial;
  String? status;
  String? createdAt;
  String? updatedAt;

  ProfileData(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.countryCode,
        this.phoneNumber,
        this.password,
        this.dob,
        this.imageUrl,
        this.verificationKey,
        this.oneTimePassword,
        this.fcmRegistrationToken,
        this.serial,
        this.status,
        this.createdAt,
        this.updatedAt});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    dob = json['dob'];
    imageUrl = json['imageUrl'];
    verificationKey = json['verificationKey'];
    oneTimePassword = json['oneTimePassword'];
    fcmRegistrationToken = json['fcmRegistrationToken'];
    serial = json['serial'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['countryCode'] = countryCode;
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    data['dob'] = dob;
    data['imageUrl'] = imageUrl;
    data['verificationKey'] = verificationKey;
    data['oneTimePassword'] = oneTimePassword;
    data['fcmRegistrationToken'] = fcmRegistrationToken;
    data['serial'] = serial;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

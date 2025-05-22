class DeleteProfileResponse {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? countryCode;
  final int? clubPoints;
  final String? phoneNumber;
  final String? password;
  final String? dob;
  final String? imageUrl;
  final String? verificationKey;
  final String? oneTimePassword;
  final int? otpAttempt;
  final String? fcmRegistrationToken;
  final String? otp;
  final int? serial;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  DeleteProfileResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.countryCode,
    this.clubPoints,
    this.phoneNumber,
    this.password,
    this.dob,
    this.imageUrl,
    this.verificationKey,
    this.oneTimePassword,
    this.otpAttempt,
    this.fcmRegistrationToken,
    this.otp,
    this.serial,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory DeleteProfileResponse.fromJson(Map<String, dynamic> json) {
    return DeleteProfileResponse(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      countryCode: json['countryCode'],
      clubPoints: json['clubPoints'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      dob: json['dob'],
      imageUrl: json['imageUrl'],
      verificationKey: json['verificationKey'],
      oneTimePassword: json['oneTimePassword'],
      otpAttempt: json['otpAttempt'],
      fcmRegistrationToken: json['fcmRegistrationToken'],
      otp: json['otp'],
      serial: json['serial'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'countryCode': countryCode,
      'clubPoints': clubPoints,
      'phoneNumber': phoneNumber,
      'password': password,
      'dob': dob,
      'imageUrl': imageUrl,
      'verificationKey': verificationKey,
      'oneTimePassword': oneTimePassword,
      'otpAttempt': otpAttempt,
      'fcmRegistrationToken': fcmRegistrationToken,
      'otp': otp,
      'serial': serial,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
class UpdateProfileResponse {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? countryCode;
  final String? phoneNumber;
  final String? password;
  final String? dob;
  final String? imageUrl;
  final String? verificationKey;
  final String? oneTimePassword;
  final String? fcmRegistrationToken;
  final int? serial;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  UpdateProfileResponse({
    this.id,
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
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'firstName': firstName,
      'lastName': lastName,
      // 'email': email,
      // 'countryCode': countryCode,
      'phoneNumber': phoneNumber,
      // 'password': password,
      // 'dob': dob,
      // 'imageUrl': imageUrl,
      // 'verificationKey': verificationKey,
      // 'oneTimePassword': oneTimePassword,
      // 'fcmRegistrationToken': fcmRegistrationToken,
      // 'serial': serial,
      // 'status': status,
      // 'createdAt': createdAt,
      // 'updatedAt': updatedAt,
    };
  }
}

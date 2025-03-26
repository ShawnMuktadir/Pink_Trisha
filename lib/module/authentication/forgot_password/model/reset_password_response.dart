class ResetPasswordResponse {
  final int statusCode;
  final String message;
  final bool data;

  ResetPasswordResponse(
      {required this.statusCode, required this.message, required this.data});

  // Factory constructor for creating a new instance from a map
  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
        statusCode: json['statusCode'],
        message: json['message'],
        data: json['data']);
  }

  // Method for converting the instance to a map
  Map<String, dynamic> toJson() {
    return {'statusCode': statusCode, 'message': message, 'data': data};
  }
}

class HomeCountryResponse {
  int? statusCode;
  String? message;
  List<CountryData>? data;

  HomeCountryResponse({this.statusCode, this.message, this.data});

  factory HomeCountryResponse.fromJson(Map<String, dynamic> json) {
    return HomeCountryResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CountryData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CountryData {
  int? id;
  String? name;
  String? currencyISOCode;
  int? perUnitRateInBDT;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  CountryData({
    this.id,
    this.name,
    this.currencyISOCode,
    this.perUnitRateInBDT,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) {
    return CountryData(
      id: json['id'],
      name: json['name'],
      currencyISOCode: json['currencyISOCode'],
      perUnitRateInBDT: json['perUnitRateInBDT'],
      status: json['status'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}

class CountryProductTypeResponse {
  int? statusCode;
  String? message;
  List<CountryProductType>? data;

  CountryProductTypeResponse({this.statusCode, this.message, this.data});

  factory CountryProductTypeResponse.fromJson(Map<String, dynamic> json) {
    return CountryProductTypeResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CountryProductType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CountryProductType {
  int? id;
  int? onDemandCountryId;
  String? name;
  int? weightFeePerKg;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  CountryProductType({
    this.id,
    this.onDemandCountryId,
    this.name,
    this.weightFeePerKg,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory CountryProductType.fromJson(Map<String, dynamic> json) {
    return CountryProductType(
      id: json['id'],
      onDemandCountryId: json['onDemandCountryId'],
      name: json['name'],
      weightFeePerKg: json['weightFeePerKg'],
      status: json['status'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}

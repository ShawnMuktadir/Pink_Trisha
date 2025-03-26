class BrandResponse {
  int? statusCode;
  String? message;
  List<BrandData>? data;

  BrandResponse({this.statusCode, this.message, this.data});

  BrandResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BrandData>[];
      json['data'].forEach((v) {
        data!.add(BrandData.fromJson(v));
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

class BrandData {
  String? sId;
  int? id;
  String? name;
  String? nameBn;
  String? imageUrl;

  BrandData({this.sId, this.id, this.name, this.nameBn, this.imageUrl});

  BrandData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    name = json['name'];
    nameBn = json['nameBn'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['id'] = id;
    data['name'] = name;
    data['nameBn'] = nameBn;
    data['imageUrl'] = imageUrl;
    return data;
  }
}

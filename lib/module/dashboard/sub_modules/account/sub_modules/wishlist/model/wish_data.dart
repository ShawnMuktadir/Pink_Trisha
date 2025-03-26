import 'package:pink_by_trisha_app/constant/constant_key.dart';
import 'package:pink_by_trisha_app/data_provider/pref_helper.dart';

class CreateWishData {
  // int customerId;
  int productId;

  CreateWishData({required this.productId});

  Map<String, dynamic> toJson() {
    return {
      'customerId': int.parse(PrefHelper.getString(AppConstant.USER_ID.key)),
      'productId': productId,
    };
  }

  factory CreateWishData.fromJson(Map<String, dynamic> json) {
    return CreateWishData(
      //   customerId: json['customerId'],
      productId: json['productId'],
    );
  }
}

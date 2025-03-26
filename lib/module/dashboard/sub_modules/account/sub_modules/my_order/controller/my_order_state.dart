import 'package:flutter/cupertino.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/my_order/model/order_details_response.dart';
import '../model/my_order_model.dart';

@immutable
class MyOrderState {
  final List<MyOrderData> orderList;
  final OrderDetailsResponse? orderDetailsResponse;
  final bool isOrderDetailsLoading;
  final bool isLoading;

  const MyOrderState({
    required this.orderList,
    required this.orderDetailsResponse,
    required this.isOrderDetailsLoading,
    required this.isLoading,
  });

  MyOrderState copyWith({
    List<MyOrderData>? orderList,
    OrderDetailsResponse? orderDetailsResponse,
    bool? isLoading,
    bool? isOrderDetailsLoading,
  }) {
    return MyOrderState(
      orderList: orderList ?? this.orderList,
      orderDetailsResponse: orderDetailsResponse ?? this.orderDetailsResponse,
      isOrderDetailsLoading:
          isOrderDetailsLoading ?? this.isOrderDetailsLoading,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

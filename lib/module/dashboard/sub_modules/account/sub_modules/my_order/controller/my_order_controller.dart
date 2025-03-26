import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/constant/app_url.dart';
import 'package:pink_by_trisha_app/constant/constant_key.dart';
import 'package:pink_by_trisha_app/data_provider/api_client.dart';
import 'package:pink_by_trisha_app/data_provider/pref_helper.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/my_order/controller/my_order_state.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/my_order/model/my_order_model.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/my_order/model/order_details_response.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/network_connection.dart';

final myOrderController =
    StateNotifierProvider<MyOrderController, MyOrderState>(
        (ref) => MyOrderController());

class MyOrderController extends StateNotifier<MyOrderState> {
  MyOrderController()
      : super(const MyOrderState(
            orderList: [],
            isLoading: true,
            orderDetailsResponse: null,
            isOrderDetailsLoading: true));

  final ApiClient _apiClient = ApiClient();

  Future<void> getMyOrder() async {
    state = state.copyWith(isLoading: true);
    final token = PrefHelper.getString(AppConstant.TOKEN.key);
    final userId = PrefHelper.getString(AppConstant.USER_ID.key);
    final url = AppUrl.myOrders.url.replaceFirst('{userId}', userId);
    print('Token get :- $token');
    await _apiClient
        .request(
            url: url,
            method: MethodType.GET,
            token: token,
            onSuccessFunction: (response) {
              final MyOrderModel myOrderModel =
                  MyOrderModel.fromJson(response.data);
              // print(object)
              state = state.copyWith(orderList: myOrderModel.data ?? []);
            })
        .catchError((e) {
      "error $e".log();
    });
    state = state.copyWith(isLoading: false);
  }

  Future<void> getOrderDetails({required String orderId}) async {
    state = state.copyWith(isOrderDetailsLoading: true);
    final token = PrefHelper.getString(AppConstant.TOKEN.key);
    final url = AppUrl.orderDetails.url.replaceFirst('{orderId}', orderId);
    print('Token get :- $token');
    await _apiClient
        .request(
            url: url,
            method: MethodType.GET,
            token: token,
            onSuccessFunction: (response) {
              final OrderDetailsResponse orderDetailsResponse =
                  OrderDetailsResponse.fromJson(response.data);
              state =
                  state.copyWith(orderDetailsResponse: orderDetailsResponse);
            })
        .catchError((e) {
      "error $e".log();
    });
    state = state.copyWith(isOrderDetailsLoading: false);
  }
}

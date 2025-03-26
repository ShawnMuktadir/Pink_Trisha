import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/constant/app_url.dart';
import 'package:pink_by_trisha_app/constant/constant_key.dart';
import 'package:pink_by_trisha_app/data_provider/api_client.dart';
import 'package:pink_by_trisha_app/data_provider/pref_helper.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/controller/all_address/all_address_state.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/model/all_address_model.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/network_connection.dart';

final allAddressController =
    StateNotifierProvider<AllAddressController, AllAddressState>(
        (ref) => AllAddressController());

class AllAddressController extends StateNotifier<AllAddressState> {
  AllAddressController()
      : super(const AllAddressState(
            addressList: [], isLoading: false, isLoggedIn: false));

  final ApiClient _apiClient = ApiClient();

  Future<void> getAllAddress() async {
    state = state.copyWith(isLoading: true);
    final token = PrefHelper.getString(AppConstant.TOKEN.key);
    final userId = PrefHelper.getString(AppConstant.USER_ID.key);
    final url = AppUrl.allAddressUrl.url;
    //  final url = AppUrl.allAddressUrl.url.replaceFirst("{id}", userId);
    print('Token get :- $token');
    await _apiClient
        .request(
            url: url,
            method: MethodType.GET,
            token: token,
            onSuccessFunction: (response) {
              final AllAddressModel addressData =
                  AllAddressModel.fromJson(response.data);
              // print(object)
              state = state.copyWith(addressList: addressData.data ?? []);
            })
        .catchError((e) {
      "error $e".log();
    });
    state = state.copyWith(isLoading: false);
  }
}

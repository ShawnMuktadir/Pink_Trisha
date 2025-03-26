import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/constant/app_url.dart';
import 'package:pink_by_trisha_app/data_provider/api_client.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/network_connection.dart';

import '../model/brand_response.dart';
import 'brand_state.dart';

final brandController = StateNotifierProvider<BrandController, BrandState>(
    (ref) => BrandController());

class BrandController extends StateNotifier<BrandState> {
  BrandController()
      : super(BrandState(
            topBrandsList: const [],
            selectIndex: 0,
            isLoading: false,
            isLoggedIn: false));

  final ApiClient _apiClient = ApiClient();

  Future<void> getBrand() async {
    state = state.copyWith(isLoading: true);

    await _apiClient
        .request(
            url: AppUrl.topBrandsSeeAll.url,
            method: MethodType.GET,
            onSuccessFunction: (response) {
              final BrandResponse brandResponse =
                  BrandResponse.fromJson(response.data);
              // print(object)
              state = state.copyWith(topBrandsList: brandResponse.data ?? []);
            })
        .catchError((e) {
      "error $e".log();
    });
    state = state.copyWith(isLoading: false);
  }
}

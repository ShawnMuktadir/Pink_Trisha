import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/constant/app_url.dart';
import 'package:pink_by_trisha_app/data_provider/api_client.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/network_connection.dart';

import '../../../../../../../utils/enum.dart';
import '../model/category_response.dart';
import 'category_state.dart';

final categoryController =
    StateNotifierProvider<CategoryController, CategoryState>(
        (ref) => CategoryController());

class CategoryController extends StateNotifier<CategoryState> {
  CategoryController()
      : super(const CategoryState(
            cateAllData: [],
            selectIndex: 0,
            isLoading: false,
            isLoggedIn: false));

  final ApiClient _apiClient = ApiClient();

  Future<void> getCategory({bool isLoading = false}) async {
    state = state.copyWith(isLoading: state.cateAllData.isEmpty || isLoading);

    await _apiClient
        .request(
            url: AppUrl.category.url,
            method: MethodType.GET,
            onSuccessFunction: (response) {
              final CategoryResponse seeAllModel =
                  CategoryResponse.fromJson(response.data);
              // print(object)
              state = state.copyWith(cateAllData: seeAllModel.data ?? []);
              print(seeAllModel.toJson());
            })
        .catchError((e) {
      "error $e".log();
    });
    state = state.copyWith(isLoading: false);
  }
}

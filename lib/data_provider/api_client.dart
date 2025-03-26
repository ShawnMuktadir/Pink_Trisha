import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pink_by_trisha_app/data_provider/pref_helper.dart';
import 'package:pink_by_trisha_app/data_provider/storage_controller.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import '../constant/app_url.dart';
import '../constant/constant_key.dart';
import '../global/widget/error_dialog.dart';
import '../utils/enum.dart';
import '../utils/navigation.dart';
import '../utils/network_connection.dart';
import '../utils/view_util.dart';

class ApiClient {
  final Dio _dio = Dio();

  Map<String, dynamic> _header = {};

  bool? isPopDialog;

  _initDio({Map<String, String>? extraHeader, bool hasHeader = true}) async {
    final deviseOs =
        Platform.isAndroid ? AppConstant.ANDROID.key : AppConstant.IOS.key;

    hasHeader
        ? _header = {
            HttpHeaders.contentTypeHeader: AppConstant.APPLICATION_JSON.key,
            // HttpHeaders.authorizationHeader:
            // "${AppConstant.BEARER.key} ${PrefHelper.getString(AppConstant.TOKEN.key)}",
            AppConstant.APP_VERSION.key:
                PrefHelper.getString(AppConstant.APP_VERSION.key),
            AppConstant.BUILD_NUMBER.key:
                PrefHelper.getString(AppConstant.BUILD_NUMBER.key),
            AppConstant.USER_AGENT.key: deviseOs,
            AppConstant.DEVICE_OS.key: deviseOs,
            AppConstant.LANGUAGE.key: PrefHelper.getLanguage() == 1
                ? AppConstant.EN.key
                : AppConstant.BN.key,
            extraHeader?.keys.first ?? "": extraHeader?.values.first ?? ""
          }
        : _header = {
            HttpHeaders.contentTypeHeader: AppConstant.APPLICATION_JSON.key,
          };

    final String? token = PrefHelper.getString(AppConstant.TOKEN.key);
    print('Header Token Init -: $token');
    if (token != null && hasHeader) {
      _header[HttpHeaders.authorizationHeader] =
          "${AppConstant.BEARER.key} $token";
    }

    _dio.options = BaseOptions(
      baseUrl: AppUrl.base.url,
      headers: _header,
      connectTimeout: const Duration(minutes: 3),
      // More readable
      sendTimeout: const Duration(minutes: 2),
      receiveTimeout: const Duration(minutes: 2),
    );
    _initInterceptors();
  }

  void _initInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      print(
          'REQUEST[${options.method}] => PATH: ${AppUrl.base.url}${options.path} '
          '=> Request Values: param: ${options.queryParameters}, DATA: ${options.data}, => _HEADERS: ${options.headers}');
      return handler.next(options);
    }, onResponse: (response, handler) {
      print(
          'RESPONSE[${response.statusCode}] => DATA: ${response.data} URL: ${response.requestOptions.baseUrl}${response.requestOptions.path}');
      return handler.next(response);
    }, onError: (err, handler) {
      print(
          'ERROR[${err.response?.statusCode}] => DATA: ${err.response?.data} Message: ${err.message} URL: ${err.response?.requestOptions.baseUrl}${err.response?.requestOptions.path}');
      return handler.next(err);
    }));
  }

  // Image or file upload using Rest handle.
  Future requestFormData(
      {required String url,
      required MethodType method,
      Map<String, dynamic>? params,
      bool? isPopGlobalDialog,
      String? token,
      Options? options,
      void Function(int, int)? onReceiveProgress,
      String? savePath,
      List<File>? files,
      String? fileKeyName,
      required Function(
        Response response,
      ) onSuccessFunction}) async {
    final tokenHeader = <String, String>{
      HttpHeaders.contentTypeHeader: AppConstant.MULTIPART_FORM_DATA.key
    };
    _initDio(extraHeader: tokenHeader);

    if (files != null) {
      params?.addAll({
        "$fileKeyName": files
            .map((item) => MultipartFile.fromFileSync(item.path,
                filename: item.path.split('/').last))
            .toList()
      });
    }

    final data = FormData.fromMap(params!);
    data.log();
    // Handle and check all the status.
    return clientHandle(
      url,
      method,
      params,
      data: data,
      onSuccessFunction: onSuccessFunction,
    );
  }

  // Normal Rest API  handle.
  Future request(
      {required String url,
      required MethodType method,
      Map<String, dynamic>? params,
      dynamic data,
      bool? isPopGlobalDialog,
      String? token,
      String? responseErrorMessage,
      Options? options,
      bool hasHeader = true,
      void Function(int, int)? onReceiveProgress,
      String? savePath,
      required Function(
        Response response,
      ) onSuccessFunction}) async {
    final tokenHeader = <String, String>{AppConstant.PUSH_ID.key: token ?? ""};

    if (NetworkConnection.instance.isInternet) {
      // Handle and check all the status.
      isPopDialog = isPopGlobalDialog;
      _initDio(extraHeader: tokenHeader, hasHeader: hasHeader);
      return clientHandle(url, method, params,
          data: data,
          options: options,
          savePath: savePath,
          onReceiveProgress: onReceiveProgress,
          onSuccessFunction: onSuccessFunction,
          responseErrorMessage: responseErrorMessage);
    } else {
      NetworkConnection.instance.apiStack.add(
        APIParams(
          url: url,
          method: method,
          variables: params ?? {},
          onSuccessFunction: onSuccessFunction,
        ),
      );
      if (ViewUtil.isPresentedDialog == false) {
        ViewUtil.isPresentedDialog = true;
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            ViewUtil.showInternetDialog(
              onPressed: () {
                if (NetworkConnection.instance.isInternet == true) {
                  Navigator.of(Navigation.key.currentState!.overlay!.context,
                          rootNavigator: true)
                      .pop();
                  ViewUtil.isPresentedDialog = false;
                  for (var element in NetworkConnection.instance.apiStack) {
                    request(
                      url: element.url,
                      method: element.method,
                      params: element.variables,
                      onSuccessFunction: element.onSuccessFunction,
                    );
                  }
                  NetworkConnection.instance.apiStack = [];
                }
              },
            );
          },
        );
      }
    }
  }

// Handle all the method and error.
  Future clientHandle(
    String url,
    MethodType method,
    Map<String, dynamic>? params, {
    String? responseErrorMessage,
    dynamic data,
    Options? options,
    String? savePath,
    void Function(int, int)? onReceiveProgress,
    required Function(Response response)? onSuccessFunction,
  }) async {
    Response response;
    try {
      // Handle response code from api.
      if (method == MethodType.POST) {
        response = await _dio.post(
          url,
          queryParameters: params,
          data: data,
        );
      } else if (method == MethodType.DELETE) {
        response = await _dio.delete(url);
      } else if (method == MethodType.PATCH) {
        response = await _dio.patch(url);
      } else if (method == MethodType.DOWNLOAD) {
        response = await _dio.download(
          url,
          savePath,
          queryParameters: params,
          options: options,
          onReceiveProgress: onReceiveProgress,
        );
      } else if (method == MethodType.PUT) {
        response = await _dio.put(
          url,
          queryParameters: params,
          data: data,
        );
      } else {
        response = await _dio.get(
          url,
          queryParameters: params,
          options: options,
          onReceiveProgress: onReceiveProgress,
        );
      }
      /**
       * Handle Rest based on response json
       * So please check in json body there is any status_code or code
       */
      if (response.statusCode == 200) {
        final Map data = json.decode(response.toString());
        final verifycode = data['statusCode'];
        int code = int.tryParse(verifycode.toString()) ?? 0;
        if (code == 200) {
          if (response.data != null) {
            return onSuccessFunction!(response);
          } else {
            "response data is ${response.data}".log();
          }
        } else if (code == 401) {
          // PrefHelper.setString(AppConstant.TOKEN.key, "").then(
          //   (value) => Navigation.pushAndRemoveUntil(
          //     Navigation.key.currentContext,
          //     appRoutes: AppRoutes.login,
          //   ),
          // );
        } else {
          //Where error occured then pop the global dialog
          response.statusCode?.log();
          code.log();
          isPopDialog?.log();

          /// Handle the case when the 'errors' field is null
          List<String>? erroMsg;
          erroMsg = List<String>.from(data["errors"] ?? []);

          // List<String>? erroMsg;
          // erroMsg = List<String>.from(data["errors"]?.map((x) => x));
          ViewUtil.showAlertDialog(
            barrierDismissible: false,
            content: ErrorDialog(
              erroMsg: erroMsg,
            ),
          ).then((value) {
            if (isPopDialog == true || isPopDialog == null) {
              Navigator.pop(Navigation.key.currentContext!);
            }
          });
          if (isPopDialog == false) {
            throw Exception();
          }
        }
      }

      // Handle Error type if dio catches anything.
    } on DioException catch (e) {
      e.log();
      print("Error of dio is : ${e.message}");
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          ViewUtil.SSLSnackbar("Time out delay ");
          throw Exception();
        case DioExceptionType.receiveTimeout:
          ViewUtil.SSLSnackbar("Server is not responded properly");
          throw Exception();
        case DioExceptionType.unknown:
          if (e.error is SocketException) {
            throw const SocketException("No Internat Available");
          } else {
            ViewUtil.SSLSnackbar("Server is not responded properly");
            throw Exception();
          }
        case DioExceptionType.badResponse:
          if (e.response?.data?["statusCode"] == 400) {
            final error = e.response?.data?["message"];
            ViewUtil.SSLSnackbar(error.toString());
          } else if (e.response?.data?["statusCode"] == 401 &&
              e.response?.data?["message"].toString() == "Unauthorized") {
            // Navigate to the sign-in screen
            await StorageController.setLoggedOut();

            // Navigate to the sign-in screen
            Future(() => Navigation.pushReplacement(
                Navigation.key.currentState!.context,
                appRoutes: AppRoutes.signIn));
          } else {
            ViewUtil.SSLSnackbar(e.response?.data?["message"]?.toString() ??
                "Internal Responses error");
          }
          //ViewUtil.SSLSnackbar(responseErrorMessage??"Internal Responses error");
          throw Exception(e.toString());
        default:
          ViewUtil.SSLSnackbar("Something went wrong");
          throw Exception("Something went wrong$e");
      }
    } catch (e) {
      "dioErrorCatch $e".log();
      throw Exception("Something went wrong$e");
    }
  }
}

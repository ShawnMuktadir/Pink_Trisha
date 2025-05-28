import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';

class NetworkConnection {
  static NetworkConnection? _instance;
  NetworkConnection._();

  static NetworkConnection get instance => _instance ??= NetworkConnection._();
  bool isInternet = true;
  List<APIParams> apiStack = [];

  Future<void> InternetAvailable() async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isInternet = false;
      } else {
        isInternet = true;
        _processApiStack();
      }
    });
  }

  Future<void> checkInitialConnection() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    isInternet = result != ConnectivityResult.none;
  }

  Future<void> _processApiStack() async {
    final dio = Dio();
    while (apiStack.isNotEmpty && isInternet) {
      final apiCall = apiStack.removeAt(0);
      try {
        final response = await _makeRequest(dio, apiCall);
        apiCall.onSuccessFunction(response);
      } catch (e) {
        // Handle error or re-add to stack
        break;
      }
    }
  }

  Future<Response<dynamic>> _makeRequest(Dio dio, APIParams params) async {
    switch (params.method) {
      case MethodType.GET:
        return await dio.get(params.url, queryParameters: params.variables);
      case MethodType.POST:
        return await dio.post(params.url, data: params.variables);
      case MethodType.PUT:
        return await dio.put(params.url, data: params.variables);
      case MethodType.DELETE:
        return await dio.delete(params.url);
      default:
        throw Exception('Unsupported method');
    }
  }
}

class APIParams {
  final String url;
  final MethodType method;
  final Map<String, dynamic> variables;
  final Function(Response<dynamic>) onSuccessFunction;

  APIParams({
    required this.url,
    required this.method,
    required this.variables,
    required this.onSuccessFunction,
  });
}
import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';

class AuthApi {
  final ApiClient _client;

  AuthApi(this._client);

  Future<Response<dynamic>> login(String username, String password) async {
    return _client.post(ApiConstants.login, data: {'username': username, 'password': password});
  }

  Future<Response<dynamic>> refresh(String refreshToken) async {
    return _client.post(ApiConstants.refresh, data: {'refreshToken': refreshToken});
  }

  Future<Response<dynamic>> me() async {
    return _client.get(ApiConstants.me);
  }
}

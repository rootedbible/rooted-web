import "package:dio/dio.dart";
import "package:email_validator/email_validator.dart";

import "../../const.dart";
import "../api.dart";
import "../responses/user_response.dart";

class AuthService {
  final Dio dio = Api().dio;

  final String route = "auth";

  Future<UserResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      final url = "$baseUrl/$route/login";

      final formData = FormData.fromMap({
        "username": username,
        "password": password,
      });
      final options = Options(headers: {"app-key": await Api().getAuthCode()});

      final response = await dio.post(url, data: formData, options: options);
      return UserResponse.fromJson(response.data);
    } catch (e) {
      if (e.toString().contains("422")) {
        throw "Invalid Input";
      }
      if (e.toString().contains("401")) {
        throw "Incorrect Username or Password!";
      }
      if (e.toString().contains("50")) {
        throw "Rooted Services are down, we are working to get them operational as soon as possible!";
      }
      rethrow;
    }
  }

  Future<Response> logout() async {
    try {
      final url = "$baseUrl/$route/logout";

      final response = await dio.post(
        url,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> sendReset(String input) async {
    try {
      final url = "$baseUrl/$route/forgot-password";
      final options = Options(headers: {"app-key": await Api().getAuthCode()});
      final Map<String, dynamic> data = {};
      if (EmailValidator.validate(input)) {
        data["email"] = input;
      } else {
        data["username"] = input;
      }
      final response = await dio.post(url, data: data, options: options);
      return response;
    } catch (e) {
      if (e.toString().contains("404")) {
        throw "Username or Email not found!";
      }
      rethrow;
    }
  }

  Future<Response> resetPassword({
    required String pin,
    required String password,
  }) async {
    try {
      final url = "$baseUrl/$route/reset-password";
      final Map<String, dynamic> data = {"pin": pin, "new_password": password};
      final options = Options(headers: {"app-key": await Api().getAuthCode()});

      final response = await dio.put(
        url,
        data: data,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

import "package:dio/dio.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:rooted_web/api/services/auth_service.dart";

class Api {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  static final Api _instance = Api._internal();
  Dio dio;

  Api._internal()
      : dio = Dio(
          BaseOptions(
            connectTimeout: const Duration(minutes: 1),
            receiveTimeout: const Duration(minutes: 1),
          ),
        );

  factory Api() {
    return _instance;
  }

  Future<void> login(String token) async {
    try {
      await storage.write(key: "token", value: token);
      dio.options.headers = {"Authorization": "Bearer $token"};
    } catch (e) {
      debugPrint("Error on Singleton Login: $e");
    }
  }

  Future<void> logout() async {
    await storage.deleteAll();
    await AuthService().logout();
    dio.options.headers = {};
  }

  Future<String> getAuthCode() async {
    try {
      const String key = "2REPVOEwDrVzjVrukS5bjXDqQsySzpvI";
      return key;
    } catch (e) {
      rethrow;
    }
  }
}

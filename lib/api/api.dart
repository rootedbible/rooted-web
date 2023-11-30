import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rooted_web/api/services/auth_service.dart';

import '../const.dart';

class RootedApi {
  static final RootedApi _instance = RootedApi._internal();
  static const String url = baseUrl;
  static const FlutterSecureStorage storage = FlutterSecureStorage();
  Dio dio;

  RootedApi._internal()
      : dio = Dio(
          BaseOptions(
            connectTimeout: const Duration(minutes: 1),
            receiveTimeout: const Duration(minutes: 1),
          ),
        );

  factory RootedApi() {
    return _instance;
  }

  Future<void> login(String token) async {
    await storage.write(key: 'token', value: token);
    dio.options.headers = {'Authorization': 'Bearer $token'};
  }

  Future<void> logout() async {
    await storage.deleteAll();
    await AuthService().logout();
    dio.options.headers = {};
  }

  Future<String> getAuthCode() async {
    try {
      await dotenv.load();
      final String key = dotenv.env['KEY']!;
      return key;
    } catch (e) {
      rethrow;
    }
  }
}

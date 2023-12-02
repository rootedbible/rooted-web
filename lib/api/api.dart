import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rooted_web/api/services/auth_service.dart';

class Api {
  static final Api _instance = Api._internal();
  static const FlutterSecureStorage storage = FlutterSecureStorage();
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

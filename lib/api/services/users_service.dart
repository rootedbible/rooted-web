import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:rooted_web/api/api.dart';
import '../../const.dart';
import '../../models/user_model.dart';
import '../responses/users_response.dart';

class UsersService {
  final Dio dio = Api().dio;
  final String route = 'users';

  Future<User> getMe() async {
    try {
      final url = '$baseUrl/$route/me';
      final response = await dio.get(url);
      return User.fromJson(response.data);
    } catch (e) {
      debugPrint('Error on get me: $e');
      rethrow;
    }
  }

  Future<Response> updateMe({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String? phoneNumber,
    required bool isPublic,
  }) async {
    try {
      final url = '$baseUrl/$route/me';
      final Map<String, dynamic> data = {
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'is_public': isPublic,
        if (phoneNumber != null) 'phone': phoneNumber,
      };
      final response = await dio.put(
        url,
        data: data,
      );
      if (response.statusCode != 200) {
        throw response.data['message'];
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> registerUser(Map<String, dynamic> userData) async {
    final Options options =
        Options(headers: {'app-key': await Api().getAuthCode()});
    final url = '$baseUrl/$route/register';
    final response = await dio.post(url, data: userData, options: options);
    return response;
  }

  Future<Response> updateProfileImage(
    Uint8List imageBytes,
    int userId,
  ) async {
    try {
      final url = '$baseUrl/$route/me/profile-image';
      final formData = FormData.fromMap({
        'image_file': MultipartFile.fromBytes(
          imageBytes,
          filename: '$userId.png',
          contentType: MediaType('image', 'png'),
        ),
      });

      final response = await dio.put(
        url,
        data: formData,
      );

      return response;
    } catch (e) {
      debugPrint('Error updating profile image: $e');
      rethrow;
    }
  }

  Future<UsersResponse> getFollow(String type) async {
    try {
      final url = '$baseUrl/$route/me/$type';
      final response = await dio.get(
        url,
      );
      return UsersResponse.fromJson(response.data);
    } catch (e) {
      debugPrint('Error on get follow: $e');
      rethrow;
    }
  }

  Future<Response> toggleFollow({
    required int userId,
    required String type,
  }) async {
    try {
      final url = '$baseUrl/$route/me/users/$userId/$type';
      final response =
          await dio.post(url, data: {'type': type, 'user_id': userId});
      return response;
    } catch (e) {
      debugPrint('Error on $type: $e');
      rethrow;
    }
  }

  Future<Response> acceptRequest({
    required int userId,
    required String type,
  }) async {
    try {
      final url = '$baseUrl/$route/me/requests/users/$userId/$type';
      final response = await dio.post(
        url,
      );
      return response;
    } catch (e) {
      debugPrint('Error on follow request, $type: $e');
      rethrow;
    }
  }

  Future<UsersResponse> searchUsers({
    required String query,
    required int page,
  }) async {
    try {
      final url = '$baseUrl/$route/search';
      final response =
          await dio.get(url, queryParameters: {'query': query, 'page': page});
      return UsersResponse.fromJson(response.data);
    } catch (e) {
      debugPrint('Error searching users: $e');
      rethrow;
    }
  }

  Future<void> cancelFollowRequest(int userId) async {
    try {
      final url = '$baseUrl/$route/me/follow-request/$userId';
      await dio.delete(
        url,
      );
    } catch (e) {
      debugPrint('Error searching users: $e');
      rethrow;
    }
  }

  Future<Response> leaveOrganization(int organizationId) async {
    try {
      final url = '$baseUrl/$route/me/unfollow/organizations/$organizationId';
      final response = await dio.post(
        url,
      );
      return response;
    } catch (e) {
      debugPrint('Error leaving organization: $e');
      rethrow;
    }
  }

  Future<User> getUserById({required int id}) async {
    try {
      final url = '$baseUrl/$route/$id';
      final response = await dio.get(url);
      return User.fromJson(response.data);
    } catch (e) {
      debugPrint('Error on get user by id: $e');
      rethrow;
    }
  }
}

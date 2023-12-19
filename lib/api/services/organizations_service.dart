import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';

import '../../const.dart';
import '../../models/organization_model.dart';
import '../api.dart';
import '../responses/organizations_response.dart';
import '../responses/plans_response.dart';
import '../responses/users_response.dart';

class OrganizationsService {
  final Dio dio = Api().dio;
  final String route = 'organizations';

  Future<void> editOrganization(
    int organizationId, {
    required String? uniqueName,
    required String? email,
    required String? name,
    required String? description,
    required bool inviteOnly,
    required String? phone,
    required String? address,
    required String? addressTwo,
    required String? city,
    required String? zip,
    required String? state,
    required String? website,
    required String? facebook,
    required String? tiktok,
    required String? x,
    required String? instagram,
  }) async {
    try {
      final url = '$baseUrl/$route/$organizationId';
      final Map<String, dynamic> data = {
        if (email != null) 'email': email,
        if (name != null) 'name': name,
        if (description != null) 'description': description,
        'invite_only': inviteOnly,
        if (phone != null) 'phone': phone,
        if (address != null) 'address': address,
        if (addressTwo != null) 'address_two': addressTwo,
        if (city != null) 'city': city,
        if (zip != null) 'zip': zip,
        if (state != null) 'state': state,
        if (website != null) 'website': website,
        if (facebook != null) 'facebook': facebook,
        if (tiktok != null) 'tiktok': tiktok,
        if (x != null) 'x': x,
        if (instagram != null) 'instagram': instagram,
        if (uniqueName != null) 'unique_name': uniqueName,
      };
      final response = await dio.put(url, data: data);
      if (!response.statusCode!.toString().startsWith('2')) {}
    } catch (e) {
      debugPrint('Error on edit organization: $e');
      rethrow;
    }
  }

  Future<Response> updateProfileImage(
    Uint8List imageBytes,
    int orgId,
  ) async {
    try {
      final url = '$baseUrl/$route/$orgId/profile-image';
      final formData = FormData.fromMap({
        'image_file': MultipartFile.fromBytes(
          imageBytes,
          filename: '$orgId.png',
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

  Future<Response> removeUserFromOrganization({
    required int organizationId,
    required int userId,
  }) async {
    try {
      final url = '$baseUrl/$route/$organizationId/users/$userId';
      final Response response = await dio.delete(
        url,
      );
      return response;
    } catch (e) {
      debugPrint('Error on remove org user: $e');
      rethrow;
    }
  }

  Future<Response> changeOrganizationUserStatus({
    required int organizationId,
    required int userId,
    required String status,
  }) async {
    try {
      final url =
          '$baseUrl/$route/$organizationId/users/$userId/status/$status';
      final Response response = await dio.put(
        url,
      );
      return response;
    } catch (e) {
      debugPrint('Error on change org user status: $e');
      rethrow;
    }
  }

  Future<UsersResponse> getOrgUsers({
    required int organizationId,
    required String status,
  }) async {
    try {
      final url = '$baseUrl/$route/$organizationId/status-of/$status';

      final response = await dio.get(
        url,
      );
      return UsersResponse.fromJson(response.data, status: status);
    } catch (e) {
      debugPrint('Error on get follow: $e');
      rethrow;
    }
  }

  Future<Response> inviteUser({
    required int orgId,
    required int userId,
  }) async {
    try {
      final url = '$baseUrl/$route/$orgId/users/$userId/invite';
      final response = await dio.post(
        url,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<OrganizationsResponse> searchOrganizations({
    required String query,
    required int page,
  }) async {
    try {
      final url = '$baseUrl/$route/search';
      final response = await dio.get(
        url,
        queryParameters: {'query': query, 'page': page},
      );
      return OrganizationsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<OrganizationsResponse> getMyOrganizations() async {
    try {
      final url = '$baseUrl/users/me/$route';
      final response = await dio.get(
        url,
      );

      return OrganizationsResponse.fromJson(response.data);
    } catch (e) {
      debugPrint('Error getting my organizations: $e');
      rethrow;
    }
  }

  Future<Response> requestToJoin(int organizationId) async {
    try {
      final url = '$baseUrl/$route/$organizationId/users/me/request-to-join';
      final response = await dio.post(
        url,
      );
      return response;
    } catch (e) {
      debugPrint('Error on request to join: $e');
      rethrow;
    }
  }

  Future<Response> manageInvite({
    required int organizationId,
    required bool accept,
  }) async {
    try {
      final url =
          '$baseUrl/users/me/requests/$route/$organizationId/${accept ? 'accept' : "reject"}';
      final response = await dio.post(
        url,
      );
      return response;
    } catch (e) {
      debugPrint('Error on invite acceptance: $e');

      rethrow;
    }
  }

  Future<Organization> getOrganizationById(int id) async {
    try {
      final url = '$baseUrl/$route/$id';
      final response = await dio.get(
        url,
      );
      return Organization.fromJson(response.data);
    } catch (e) {
      debugPrint('Error on invite acceptance: $e');

      rethrow;
    }
  }

  Future<Response> manageRequest({
    required bool accepted,
    required int organizationId,
    required int userId,
  }) async {
    try {
      final url =
          '$baseUrl/$route/$organizationId/requests/users/$userId/${accepted ? 'accept' : 'deny'}';
      final response = await dio.post(
        url,
      );
      return response;
    } catch (e) {
      debugPrint('Error on request acceptance: $e');
      rethrow;
    }
  }

  Future<PlansResponse> getPlans() async {
    try {
      final url = '$baseUrl/$route/plans';
      final response = await dio.get(
        url,
      );
      return PlansResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}

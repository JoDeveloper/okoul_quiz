import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_ui/src/constants/api.dart';
import 'package:quiz_ui/src/core/data/either_result.dart';
import 'package:quiz_ui/src/core/exceptions/custom_exception.dart';
import 'package:quiz_ui/src/core/services/storage/local_storage_service.dart';

final httpServiceProvider = Provider<DioHttpService>((ref) {
  return DioHttpService(ref);
});

class DioHttpService {
  final ProviderRef ref;
  final headers = {'accept': 'application/json', 'content-type': 'application/json'};
  Map<String, dynamic> get authHeaders => {'Authorization': 'Bearer ${ref.watch(loacalStorageProvider).getToken()}'};

  DioHttpService(this.ref);

  Future<Either<Map<String, dynamic>, CustomException>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    String? customBaseUrl,
  }) async {
    final response = await http.get(Uri.parse(Api.apiBaseUrl + endpoint), headers: headers);
    final paresdData = jsonDecode(response.body);
    if (response.statusCode != HttpStatus.ok && paresdData['success'] == false) {
      return Error(
        CustomException(
          title: 'Http Error!',
          message: paresdData['message'],
        ),
      );
    }
    return Success(paresdData as Map<String, dynamic>);
  }

  Future<Either<dynamic, CustomException>> post(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = Uri.parse(Api.apiBaseUrl + endpoint);

    try {
      final response = await http.post(
        uri,
        body: jsonEncode(queryParameters),
        headers: {...headers, if (endpoint != Api.login) ...authHeaders},
      );

      final paresdData = jsonDecode(response.body);
      if (response.statusCode != HttpStatus.ok && paresdData['success'] == false) {
        return Error(
          CustomException(
            title: 'Http Error!',
            message: paresdData['message'],
          ),
        );
      }

      return Success(paresdData);
    } on Exception catch (e) {
      return Error(
        CustomException(
          title: 'error',
          message: e.toString(),
        ),
      );
    }
  }
}

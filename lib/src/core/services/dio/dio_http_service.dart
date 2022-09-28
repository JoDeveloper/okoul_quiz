import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_ui/src/constants/constants.dart';
import 'package:quiz_ui/src/core/data/either_result.dart';
import 'package:quiz_ui/src/core/exceptions/custom_exception.dart';

final dioHttpProvider = Provider<DioHttpService>((ref) {
  return DioHttpService();
});

class DioHttpService {
  Map<String, String> headers = {'accept': 'application/json', 'content-type': 'application/json'};

  Future<Either<Map<String, dynamic>, CustomException>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    String? customBaseUrl,
  }) async {
    final response = await http.get(Uri.parse(Constants.apiBaseUrl + endpoint), headers: headers);
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
    Map<String, dynamic>? additionalHeaders,
  }) async {
    final uri = Uri.parse(Constants.apiBaseUrl + endpoint);

    try {
      final response = await http.post(
        uri,
        body: jsonEncode(queryParameters),
        headers: {...headers, ...additionalHeaders ?? {}},
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

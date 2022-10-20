import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sosty/infraestructure/helpers/api_client/errors/technical_error.dart';
import 'package:sosty/infraestructure/helpers/api_client/exception/api_exception.dart';
import 'package:sosty/domain/models/error_item/error_item.dart';
import 'package:sosty/domain/models/service_response/service_response.dart';

/// Permite realizar las peticiones por método post, get.
///
/// Lanza la excepción [ApiException] si la llamada http se completa con un
/// error.
class ApiClient {
  Map<String, String> _setHeaders(Map<String, String>? additionalHeaders) {
    final Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  Future<ServiceResponse> post(
    String service, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      final result = await http.post(
        Uri.parse(service),
        headers: _setHeaders(headers),
        body: jsonEncode(body),
        encoding: Encoding.getByName("UTF-8"),
      );
      return ServiceResponse(
        status: result.statusCode,
        body: result.body,
        bodyBytes: result.bodyBytes,
      );
    } catch (e) {
      throw ApiException(
        ErrorItem(
          domain: service,
          reason: e.toString(),
          message: TechnicalError.httpRequest,
        ),
      );
    }
  }

  Future<ServiceResponse> get(
    String service, {
    Map<String, String>? headers,
    Map<String, String?>? params,
  }) async {
    try {
      final url = Uri.parse(service).replace(queryParameters: params);
      final result = await http.get(url, headers: _setHeaders(headers));
      return ServiceResponse(
        status: result.statusCode,
        body: result.body,
        bodyBytes: result.bodyBytes,
      );
    } catch (e) {
      throw ApiException(
        ErrorItem(
          domain: service,
          reason: e.toString(),
          message: TechnicalError.httpRequest,
        ),
      );
    }
  }
}

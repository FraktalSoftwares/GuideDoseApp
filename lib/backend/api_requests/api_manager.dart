import 'dart:convert';
import 'package:http/http.dart' as http;

enum ApiCallType {
  GET,
  POST,
  PUT,
  DELETE,
  PATCH,
}

enum BodyType {
  NONE,
  JSON,
  TEXT,
  X_WWW_FORM_URL_ENCODED,
  MULTIPART,
}

class ApiCallResponse {
  const ApiCallResponse(
    this.jsonBody,
    this.headers,
    this.statusCode, {
    this.response,
    this.responseText = '',
  });

  final dynamic jsonBody;
  final Map<String, String> headers;
  final int statusCode;
  final http.Response? response;
  final String responseText;

  @override
  String toString() =>
      'ApiCallResponse(statusCode: $statusCode, jsonBody: $jsonBody)';

  bool get succeeded => statusCode >= 200 && statusCode < 300;
  String getHeader(String headerName) => headers[headerName] ?? '';
  dynamic getJsonField(String fieldName) {
    if (jsonBody is! Map) {
      return null;
    }
    return (jsonBody as Map)[fieldName];
  }
}

class ApiManager {
  ApiManager._();
  static ApiManager? _instance;
  static ApiManager get instance => _instance ??= ApiManager._();

  Future<ApiCallResponse> makeApiCall({
    required String callName,
    required String apiUrl,
    required ApiCallType callType,
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> params = const {},
    String? body,
    BodyType? bodyType,
    bool returnBody = true,
    bool encodeBodyUtf8 = false,
    bool decodeUtf8 = false,
    bool cache = false,
    bool isStreamingApi = false,
    bool alwaysAllowBody = false,
  }) async {
    try {
      final uri = Uri.parse(apiUrl).replace(
          queryParameters: params.isNotEmpty
              ? params.map((k, v) => MapEntry(k, v.toString()))
              : null);

      final requestHeaders = <String, String>{};
      headers.forEach((key, value) {
        requestHeaders[key] = value.toString();
      });

      http.Response? response;

      switch (callType) {
        case ApiCallType.GET:
          response = await http.get(uri, headers: requestHeaders);
          break;
        case ApiCallType.POST:
          response = await http.post(
            uri,
            headers: requestHeaders,
            body: body,
          );
          break;
        case ApiCallType.PUT:
          response = await http.put(
            uri,
            headers: requestHeaders,
            body: body,
          );
          break;
        case ApiCallType.DELETE:
          response = await http.delete(uri, headers: requestHeaders);
          break;
        case ApiCallType.PATCH:
          response = await http.patch(
            uri,
            headers: requestHeaders,
            body: body,
          );
          break;
      }

      final responseBody = returnBody ? response.body : '';
      dynamic jsonBody;

      try {
        if (responseBody.isNotEmpty) {
          jsonBody = json.decode(responseBody);
        }
      } catch (_) {
        jsonBody = responseBody;
      }

      return ApiCallResponse(
        jsonBody,
        response.headers,
        response.statusCode,
        response: response,
        responseText: responseBody,
      );
    } catch (e) {
      return ApiCallResponse(
        {'error': e.toString()},
        {},
        500,
        responseText: e.toString(),
      );
    }
  }
}

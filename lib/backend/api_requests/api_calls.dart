import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Resete de senha Group Code

class ReseteDeSenhaGroup {
  static String getBaseUrl() =>
      'https://zgjyavpdnldtntprkhzn.supabase.co/functions/v1';
  static Map<String, String> headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpnanlhdnBkbmxkdG50cHJraHpuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUyNjIxNjEsImV4cCI6MjA3MDgzODE2MX0.M4hABdTVGpKBMipt7s8jdqHTgiJW1zdb7G3rrrusXTc',
    'Content-Type': 'application/json',
  };
  static SendEmailResetSenhaCall sendEmailResetSenhaCall =
      SendEmailResetSenhaCall();
  static ValidarCodigoResetCall validarCodigoResetCall =
      ValidarCodigoResetCall();
  static ResetSenhaCall resetSenhaCall = ResetSenhaCall();
  static DeleteAccountCall deleteAccountCall = DeleteAccountCall();
}

class SendEmailResetSenhaCall {
  Future<ApiCallResponse> call({
    String? email = '',
  }) async {
    final baseUrl = ReseteDeSenhaGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "email": "${escapeStringForJson(email)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Send email reset senha',
      apiUrl: '${baseUrl}/password-reset',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpnanlhdnBkbmxkdG50cHJraHpuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUyNjIxNjEsImV4cCI6MjA3MDgzODE2MX0.M4hABdTVGpKBMipt7s8jdqHTgiJW1zdb7G3rrrusXTc',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ValidarCodigoResetCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? codigo = '',
  }) async {
    final baseUrl = ReseteDeSenhaGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "email": "${escapeStringForJson(email)}",
  "codigo": "${escapeStringForJson(codigo)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Validar Codigo Reset',
      apiUrl: '${baseUrl}/validar-code-reset',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpnanlhdnBkbmxkdG50cHJraHpuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUyNjIxNjEsImV4cCI6MjA3MDgzODE2MX0.M4hABdTVGpKBMipt7s8jdqHTgiJW1zdb7G3rrrusXTc',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.ok''',
      ));
}

class ResetSenhaCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? codigo = '',
    String? novaSenha = '',
  }) async {
    final baseUrl = ReseteDeSenhaGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "email": "${escapeStringForJson(email)}",
  "codigo": "${escapeStringForJson(codigo)}",
  "nova_senha": "${escapeStringForJson(novaSenha)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Reset senha',
      apiUrl: '${baseUrl}/reset-senha',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpnanlhdnBkbmxkdG50cHJraHpuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUyNjIxNjEsImV4cCI6MjA3MDgzODE2MX0.M4hABdTVGpKBMipt7s8jdqHTgiJW1zdb7G3rrrusXTc',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteAccountCall {
  Future<ApiCallResponse> call({
    String? uid = '',
  }) async {
    final baseUrl = ReseteDeSenhaGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "user_id": "${escapeStringForJson(uid)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Delete Account',
      apiUrl: '${baseUrl}/excluir-conta',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpnanlhdnBkbmxkdG50cHJraHpuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUyNjIxNjEsImV4cCI6MjA3MDgzODE2MX0.M4hABdTVGpKBMipt7s8jdqHTgiJW1zdb7G3rrrusXTc',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Resete de senha Group Code

class DELETARUserCall {
  static Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    final ffApiRequestBody = '''
{
  "uid": "${escapeStringForJson(userId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'DELETAR User',
      apiUrl:
          'https://zgjyavpdnldtntprkhzn.supabase.co/functions/v1/delete-user',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpnanlhdnBkbmxkdG50cHJraHpuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUyNjIxNjEsImV4cCI6MjA3MDgzODE2MX0.M4hABdTVGpKBMipt7s8jdqHTgiJW1zdb7G3rrrusXTc',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? statusRequest(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class CountryCodesCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'CountryCodes',
      apiUrl:
          'https://gist.githubusercontent.com/anubhavshrimal/75f6183458db8c453306f93521e93d37/raw/f77e7598a8503f1f70528ae1cbf9f66755698a16/CountryCodes.json',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? dialCode(dynamic response) => (getJsonField(
        response,
        r'''$[:].dial_code''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? code(dynamic response) => (getJsonField(
        response,
        r'''$[:].code''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}

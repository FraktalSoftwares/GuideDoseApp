// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserStruct extends BaseStruct {
  UserStruct({
    String? userId,
    DateTime? createdAt,
    String? usrEmail,
    String? usrTelefone,
    String? usrLinguagem,
    String? usrIdade,
    String? uSRKGs,
    String? usrAltura,
    String? usrFaixa,
    String? usrGenero,
    String? usrUndMedAltura,
    String? usrUndMedPeso,
    String? usrRegiao,
    String? usrAnosmeses,
  })  : _userId = userId,
        _createdAt = createdAt,
        _usrEmail = usrEmail,
        _usrTelefone = usrTelefone,
        _usrLinguagem = usrLinguagem,
        _usrIdade = usrIdade,
        _uSRKGs = uSRKGs,
        _usrAltura = usrAltura,
        _usrFaixa = usrFaixa,
        _usrGenero = usrGenero,
        _usrUndMedAltura = usrUndMedAltura,
        _usrUndMedPeso = usrUndMedPeso,
        _usrRegiao = usrRegiao,
        _usrAnosmeses = usrAnosmeses;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  set userId(String? val) => _userId = val;

  bool hasUserId() => _userId != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "USR_EMAIL" field.
  String? _usrEmail;
  String get usrEmail => _usrEmail ?? '';
  set usrEmail(String? val) => _usrEmail = val;

  bool hasUsrEmail() => _usrEmail != null;

  // "USR_TELEFONE" field.
  String? _usrTelefone;
  String get usrTelefone => _usrTelefone ?? '';
  set usrTelefone(String? val) => _usrTelefone = val;

  bool hasUsrTelefone() => _usrTelefone != null;

  // "USR_LINGUAGEM" field.
  String? _usrLinguagem;
  String get usrLinguagem => _usrLinguagem ?? '';
  set usrLinguagem(String? val) => _usrLinguagem = val;

  bool hasUsrLinguagem() => _usrLinguagem != null;

  // "USR_IDADE" field.
  String? _usrIdade;
  String get usrIdade => _usrIdade ?? '';
  set usrIdade(String? val) => _usrIdade = val;

  bool hasUsrIdade() => _usrIdade != null;

  // "USR_KGs" field.
  String? _uSRKGs;
  String get uSRKGs => _uSRKGs ?? '';
  set uSRKGs(String? val) => _uSRKGs = val;

  bool hasUSRKGs() => _uSRKGs != null;

  // "USR_ALTURA" field.
  String? _usrAltura;
  String get usrAltura => _usrAltura ?? '';
  set usrAltura(String? val) => _usrAltura = val;

  bool hasUsrAltura() => _usrAltura != null;

  // "USR_FAIXA" field.
  String? _usrFaixa;
  String get usrFaixa => _usrFaixa ?? '';
  set usrFaixa(String? val) => _usrFaixa = val;

  bool hasUsrFaixa() => _usrFaixa != null;

  // "USR_GENERO" field.
  String? _usrGenero;
  String get usrGenero => _usrGenero ?? '';
  set usrGenero(String? val) => _usrGenero = val;

  bool hasUsrGenero() => _usrGenero != null;

  // "USR_UND_MED_ALTURA" field.
  String? _usrUndMedAltura;
  String get usrUndMedAltura => _usrUndMedAltura ?? '';
  set usrUndMedAltura(String? val) => _usrUndMedAltura = val;

  bool hasUsrUndMedAltura() => _usrUndMedAltura != null;

  // "USR_UND_MED_PESO" field.
  String? _usrUndMedPeso;
  String get usrUndMedPeso => _usrUndMedPeso ?? '';
  set usrUndMedPeso(String? val) => _usrUndMedPeso = val;

  bool hasUsrUndMedPeso() => _usrUndMedPeso != null;

  // "USR_REGIAO" field.
  String? _usrRegiao;
  String get usrRegiao => _usrRegiao ?? '';
  set usrRegiao(String? val) => _usrRegiao = val;

  bool hasUsrRegiao() => _usrRegiao != null;

  // "USR_ANOSMESES" field.
  String? _usrAnosmeses;
  String get usrAnosmeses => _usrAnosmeses ?? '';
  set usrAnosmeses(String? val) => _usrAnosmeses = val;

  bool hasUsrAnosmeses() => _usrAnosmeses != null;

  static UserStruct fromMap(Map<String, dynamic> data) => UserStruct(
        userId: data['user_id'] as String?,
        createdAt: data['created_at'] as DateTime?,
        usrEmail: data['USR_EMAIL'] as String?,
        usrTelefone: data['USR_TELEFONE'] as String?,
        usrLinguagem: data['USR_LINGUAGEM'] as String?,
        usrIdade: data['USR_IDADE'] as String?,
        uSRKGs: data['USR_KGs'] as String?,
        usrAltura: data['USR_ALTURA'] as String?,
        usrFaixa: data['USR_FAIXA'] as String?,
        usrGenero: data['USR_GENERO'] as String?,
        usrUndMedAltura: data['USR_UND_MED_ALTURA'] as String?,
        usrUndMedPeso: data['USR_UND_MED_PESO'] as String?,
        usrRegiao: data['USR_REGIAO'] as String?,
        usrAnosmeses: data['USR_ANOSMESES'] as String?,
      );

  static UserStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'user_id': _userId,
        'created_at': _createdAt,
        'USR_EMAIL': _usrEmail,
        'USR_TELEFONE': _usrTelefone,
        'USR_LINGUAGEM': _usrLinguagem,
        'USR_IDADE': _usrIdade,
        'USR_KGs': _uSRKGs,
        'USR_ALTURA': _usrAltura,
        'USR_FAIXA': _usrFaixa,
        'USR_GENERO': _usrGenero,
        'USR_UND_MED_ALTURA': _usrUndMedAltura,
        'USR_UND_MED_PESO': _usrUndMedPeso,
        'USR_REGIAO': _usrRegiao,
        'USR_ANOSMESES': _usrAnosmeses,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'user_id': serializeParam(
          _userId,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
        'USR_EMAIL': serializeParam(
          _usrEmail,
          ParamType.String,
        ),
        'USR_TELEFONE': serializeParam(
          _usrTelefone,
          ParamType.String,
        ),
        'USR_LINGUAGEM': serializeParam(
          _usrLinguagem,
          ParamType.String,
        ),
        'USR_IDADE': serializeParam(
          _usrIdade,
          ParamType.String,
        ),
        'USR_KGs': serializeParam(
          _uSRKGs,
          ParamType.String,
        ),
        'USR_ALTURA': serializeParam(
          _usrAltura,
          ParamType.String,
        ),
        'USR_FAIXA': serializeParam(
          _usrFaixa,
          ParamType.String,
        ),
        'USR_GENERO': serializeParam(
          _usrGenero,
          ParamType.String,
        ),
        'USR_UND_MED_ALTURA': serializeParam(
          _usrUndMedAltura,
          ParamType.String,
        ),
        'USR_UND_MED_PESO': serializeParam(
          _usrUndMedPeso,
          ParamType.String,
        ),
        'USR_REGIAO': serializeParam(
          _usrRegiao,
          ParamType.String,
        ),
        'USR_ANOSMESES': serializeParam(
          _usrAnosmeses,
          ParamType.String,
        ),
      }.withoutNulls;

  static UserStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserStruct(
        userId: deserializeParam(
          data['user_id'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.DateTime,
          false,
        ),
        usrEmail: deserializeParam(
          data['USR_EMAIL'],
          ParamType.String,
          false,
        ),
        usrTelefone: deserializeParam(
          data['USR_TELEFONE'],
          ParamType.String,
          false,
        ),
        usrLinguagem: deserializeParam(
          data['USR_LINGUAGEM'],
          ParamType.String,
          false,
        ),
        usrIdade: deserializeParam(
          data['USR_IDADE'],
          ParamType.String,
          false,
        ),
        uSRKGs: deserializeParam(
          data['USR_KGs'],
          ParamType.String,
          false,
        ),
        usrAltura: deserializeParam(
          data['USR_ALTURA'],
          ParamType.String,
          false,
        ),
        usrFaixa: deserializeParam(
          data['USR_FAIXA'],
          ParamType.String,
          false,
        ),
        usrGenero: deserializeParam(
          data['USR_GENERO'],
          ParamType.String,
          false,
        ),
        usrUndMedAltura: deserializeParam(
          data['USR_UND_MED_ALTURA'],
          ParamType.String,
          false,
        ),
        usrUndMedPeso: deserializeParam(
          data['USR_UND_MED_PESO'],
          ParamType.String,
          false,
        ),
        usrRegiao: deserializeParam(
          data['USR_REGIAO'],
          ParamType.String,
          false,
        ),
        usrAnosmeses: deserializeParam(
          data['USR_ANOSMESES'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UserStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserStruct &&
        userId == other.userId &&
        createdAt == other.createdAt &&
        usrEmail == other.usrEmail &&
        usrTelefone == other.usrTelefone &&
        usrLinguagem == other.usrLinguagem &&
        usrIdade == other.usrIdade &&
        uSRKGs == other.uSRKGs &&
        usrAltura == other.usrAltura &&
        usrFaixa == other.usrFaixa &&
        usrGenero == other.usrGenero &&
        usrUndMedAltura == other.usrUndMedAltura &&
        usrUndMedPeso == other.usrUndMedPeso &&
        usrRegiao == other.usrRegiao &&
        usrAnosmeses == other.usrAnosmeses;
  }

  @override
  int get hashCode => const ListEquality().hash([
        userId,
        createdAt,
        usrEmail,
        usrTelefone,
        usrLinguagem,
        usrIdade,
        uSRKGs,
        usrAltura,
        usrFaixa,
        usrGenero,
        usrUndMedAltura,
        usrUndMedPeso,
        usrRegiao,
        usrAnosmeses
      ]);
}

UserStruct createUserStruct({
  String? userId,
  DateTime? createdAt,
  String? usrEmail,
  String? usrTelefone,
  String? usrLinguagem,
  String? usrIdade,
  String? uSRKGs,
  String? usrAltura,
  String? usrFaixa,
  String? usrGenero,
  String? usrUndMedAltura,
  String? usrUndMedPeso,
  String? usrRegiao,
  String? usrAnosmeses,
}) =>
    UserStruct(
      userId: userId,
      createdAt: createdAt,
      usrEmail: usrEmail,
      usrTelefone: usrTelefone,
      usrLinguagem: usrLinguagem,
      usrIdade: usrIdade,
      uSRKGs: uSRKGs,
      usrAltura: usrAltura,
      usrFaixa: usrFaixa,
      usrGenero: usrGenero,
      usrUndMedAltura: usrUndMedAltura,
      usrUndMedPeso: usrUndMedPeso,
      usrRegiao: usrRegiao,
      usrAnosmeses: usrAnosmeses,
    );

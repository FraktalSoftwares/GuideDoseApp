import '../database.dart';

class UsuariosTable extends SupabaseTable<UsuariosRow> {
  @override
  String get tableName => 'usuarios';

  @override
  UsuariosRow createRow(Map<String, dynamic> data) => UsuariosRow(data);
}

class UsuariosRow extends SupabaseDataRow {
  UsuariosRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UsuariosTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get email => getField<String>('email');
  set email(String? value) => setField<String>('email', value);

  String? get usrAltura => getField<String>('usr_altura');
  set usrAltura(String? value) => setField<String>('usr_altura', value);

  String? get usrIdioma => getField<String>('usr_idioma');
  set usrIdioma(String? value) => setField<String>('usr_idioma', value);

  String? get usrTelefone => getField<String>('usr_telefone');
  set usrTelefone(String? value) => setField<String>('usr_telefone', value);

  String? get usrKgs => getField<String>('usr_kgs');
  set usrKgs(String? value) => setField<String>('usr_kgs', value);

  String? get usrGenero => getField<String>('usr_genero');
  set usrGenero(String? value) => setField<String>('usr_genero', value);

  int? get usrIdade => getField<int>('usr_idade');
  set usrIdade(int? value) => setField<int>('usr_idade', value);

  String? get usrFaixaEtaria => getField<String>('usr_faixa_etaria');
  set usrFaixaEtaria(String? value) =>
      setField<String>('usr_faixa_etaria', value);

  String? get usrUndMedPeso => getField<String>('USR_UND_MED_PESO');
  set usrUndMedPeso(String? value) =>
      setField<String>('USR_UND_MED_PESO', value);

  String? get usrUndMedAltura => getField<String>('USR_UND_MED_ALTURA');
  set usrUndMedAltura(String? value) =>
      setField<String>('USR_UND_MED_ALTURA', value);

  String? get usrFoto => getField<String>('USR_FOTO');
  set usrFoto(String? value) => setField<String>('USR_FOTO', value);

  String? get usrNome => getField<String>('USR_NOME');
  set usrNome(String? value) => setField<String>('USR_NOME', value);

  bool? get usrAdmin => getField<bool>('USR_ADMIN');
  set usrAdmin(bool? value) => setField<bool>('USR_ADMIN', value);

  bool? get usrAtivo => getField<bool>('USR_ATIVO');
  set usrAtivo(bool? value) => setField<bool>('USR_ATIVO', value);

  String? get usrPais => getField<String>('USR_PAIS');
  set usrPais(String? value) => setField<String>('USR_PAIS', value);

  String? get anosMeses => getField<String>('anosMeses');
  set anosMeses(String? value) => setField<String>('anosMeses', value);
}

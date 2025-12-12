import '../database.dart';

class CodigosResetTable extends SupabaseTable<CodigosResetRow> {
  @override
  String get tableName => 'codigos_reset';

  @override
  CodigosResetRow createRow(Map<String, dynamic> data) => CodigosResetRow(data);
}

class CodigosResetRow extends SupabaseDataRow {
  CodigosResetRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CodigosResetTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get email => getField<String>('email');
  set email(String? value) => setField<String>('email', value);

  String? get codigo => getField<String>('codigo');
  set codigo(String? value) => setField<String>('codigo', value);

  DateTime? get criadoEm => getField<DateTime>('criado_em');
  set criadoEm(DateTime? value) => setField<DateTime>('criado_em', value);

  DateTime? get expiracao => getField<DateTime>('expiracao');
  set expiracao(DateTime? value) => setField<DateTime>('expiracao', value);

  bool? get usado => getField<bool>('usado');
  set usado(bool? value) => setField<bool>('usado', value);

  String? get tokenReset => getField<String>('token_reset');
  set tokenReset(String? value) => setField<String>('token_reset', value);

  DateTime? get expiraToken => getField<DateTime>('expira_token');
  set expiraToken(DateTime? value) => setField<DateTime>('expira_token', value);

  bool? get utilizadoParaReset => getField<bool>('utilizado_para_reset');
  set utilizadoParaReset(bool? value) =>
      setField<bool>('utilizado_para_reset', value);
}

import '../database.dart';

class AccordeonInducaoTable extends SupabaseTable<AccordeonInducaoRow> {
  @override
  String get tableName => 'accordeon_inducao';

  @override
  AccordeonInducaoRow createRow(Map<String, dynamic> data) =>
      AccordeonInducaoRow(data);
}

class AccordeonInducaoRow extends SupabaseDataRow {
  AccordeonInducaoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AccordeonInducaoTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get medNome => getField<String>('med_nome')!;
  set medNome(String value) => setField<String>('med_nome', value);

  double get doseMgKg => getField<double>('dose_mg_kg')!;
  set doseMgKg(double value) => setField<double>('dose_mg_kg', value);

  double get concentracaoMgMl => getField<double>('concentracao_mg_ml')!;
  set concentracaoMgMl(double value) =>
      setField<double>('concentracao_mg_ml', value);

  String? get medNomeEn => getField<String>('med_nome_en');
  set medNomeEn(String? value) => setField<String>('med_nome_en', value);

  String? get medNomeEs => getField<String>('med_nome_es');
  set medNomeEs(String? value) => setField<String>('med_nome_es', value);

  int get inducaoId => getField<int>('inducao_id')!;
  set inducaoId(int value) => setField<int>('inducao_id', value);
}

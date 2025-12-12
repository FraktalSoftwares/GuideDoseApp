import '../database.dart';

class InducoesSubtopicosTable extends SupabaseTable<InducoesSubtopicosRow> {
  @override
  String get tableName => 'inducoes_subtopicos';

  @override
  InducoesSubtopicosRow createRow(Map<String, dynamic> data) =>
      InducoesSubtopicosRow(data);
}

class InducoesSubtopicosRow extends SupabaseDataRow {
  InducoesSubtopicosRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => InducoesSubtopicosTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get indNome => getField<String>('ind_nome');
  set indNome(String? value) => setField<String>('ind_nome', value);

  int? get indId => getField<int>('ind_id');
  set indId(int? value) => setField<int>('ind_id', value);

  String? get indTopico => getField<String>('ind_topico');
  set indTopico(String? value) => setField<String>('ind_topico', value);

  String? get indTitulos => getField<String>('ind_titulos');
  set indTitulos(String? value) => setField<String>('ind_titulos', value);

  double? get doseMgKg => getField<double>('dose_mg_kg');
  set doseMgKg(double? value) => setField<double>('dose_mg_kg', value);

  String? get indNomeEs => getField<String>('ind_nome_es');
  set indNomeEs(String? value) => setField<String>('ind_nome_es', value);

  String? get indNomeEn => getField<String>('ind_nome_en');
  set indNomeEn(String? value) => setField<String>('ind_nome_en', value);
}

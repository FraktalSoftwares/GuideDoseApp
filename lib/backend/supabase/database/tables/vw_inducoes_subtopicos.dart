import '../database.dart';

class VwInducoesSubtopicosTable extends SupabaseTable<VwInducoesSubtopicosRow> {
  @override
  String get tableName => 'vw_inducoes_subtopicos';

  @override
  VwInducoesSubtopicosRow createRow(Map<String, dynamic> data) =>
      VwInducoesSubtopicosRow(data);
}

class VwInducoesSubtopicosRow extends SupabaseDataRow {
  VwInducoesSubtopicosRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VwInducoesSubtopicosTable();

  int? get indId => getField<int>('ind_id');
  set indId(int? value) => setField<int>('ind_id', value);

  String? get indTopico => getField<String>('ind_topico');
  set indTopico(String? value) => setField<String>('ind_topico', value);

  String? get indTitulos => getField<String>('ind_titulos');
  set indTitulos(String? value) => setField<String>('ind_titulos', value);

  int? get totalRegistros => getField<int>('total_registros');
  set totalRegistros(int? value) => setField<int>('total_registros', value);

  String? get conteudosPt => getField<String>('conteudos_pt');
  set conteudosPt(String? value) => setField<String>('conteudos_pt', value);

  String? get conteudosEn => getField<String>('conteudos_en');
  set conteudosEn(String? value) => setField<String>('conteudos_en', value);

  String? get conteudosEs => getField<String>('conteudos_es');
  set conteudosEs(String? value) => setField<String>('conteudos_es', value);
}

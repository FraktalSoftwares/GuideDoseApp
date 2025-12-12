import '../database.dart';

class VwInducoesOrdenadasTable extends SupabaseTable<VwInducoesOrdenadasRow> {
  @override
  String get tableName => 'vw_inducoes_ordenadas';

  @override
  VwInducoesOrdenadasRow createRow(Map<String, dynamic> data) =>
      VwInducoesOrdenadasRow(data);
}

class VwInducoesOrdenadasRow extends SupabaseDataRow {
  VwInducoesOrdenadasRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VwInducoesOrdenadasTable();

  int? get id => getField<int>('id');
  set id(int? value) => setField<int>('id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get indNome => getField<String>('ind_nome');
  set indNome(String? value) => setField<String>('ind_nome', value);

  String? get indDefinicao => getField<String>('ind_definicao');
  set indDefinicao(String? value) => setField<String>('ind_definicao', value);

  String? get indEpidemiologia => getField<String>('ind_epidemiologia');
  set indEpidemiologia(String? value) =>
      setField<String>('ind_epidemiologia', value);

  String? get indFisiopatologia => getField<String>('ind_fisiopatologia');
  set indFisiopatologia(String? value) =>
      setField<String>('ind_fisiopatologia', value);

  String? get indNomeEn => getField<String>('ind_nome_en');
  set indNomeEn(String? value) => setField<String>('ind_nome_en', value);

  String? get indNomeEs => getField<String>('ind_nome_es');
  set indNomeEs(String? value) => setField<String>('ind_nome_es', value);

  String? get definicaoEn => getField<String>('definicao_en');
  set definicaoEn(String? value) => setField<String>('definicao_en', value);

  String? get epidemiologiaEn => getField<String>('epidemiologia_en');
  set epidemiologiaEn(String? value) =>
      setField<String>('epidemiologia_en', value);

  String? get fisiopatologiaEn => getField<String>('fisiopatologia_en');
  set fisiopatologiaEn(String? value) =>
      setField<String>('fisiopatologia_en', value);

  String? get definicaoEs => getField<String>('definicao_es');
  set definicaoEs(String? value) => setField<String>('definicao_es', value);

  String? get epidemiologiaEs => getField<String>('epidemiologia_es');
  set epidemiologiaEs(String? value) =>
      setField<String>('epidemiologia_es', value);

  String? get fisiopatologiaEs => getField<String>('fisiopatologia_es');
  set fisiopatologiaEs(String? value) =>
      setField<String>('fisiopatologia_es', value);

  String? get favUserId => getField<String>('fav_user_id');
  set favUserId(String? value) => setField<String>('fav_user_id', value);

  int? get favoritoFlag => getField<int>('favorito_flag');
  set favoritoFlag(int? value) => setField<int>('favorito_flag', value);
}

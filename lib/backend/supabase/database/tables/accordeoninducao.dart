import '../database.dart';

class AccordeoninducaoTable extends SupabaseTable<AccordeoninducaoRow> {
  @override
  String get tableName => 'accordeoninducao';

  @override
  AccordeoninducaoRow createRow(Map<String, dynamic> data) =>
      AccordeoninducaoRow(data);
}

class AccordeoninducaoRow extends SupabaseDataRow {
  AccordeoninducaoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AccordeoninducaoTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get medNome => getField<String>('med_nome');
  set medNome(String? value) => setField<String>('med_nome', value);

  String? get medDose => getField<String>('med_dose');
  set medDose(String? value) => setField<String>('med_dose', value);

  bool? get medMg => getField<bool>('med_mg');
  set medMg(bool? value) => setField<bool>('med_mg', value);

  String? get medVolume => getField<String>('med_volume');
  set medVolume(String? value) => setField<String>('med_volume', value);

  bool? get medVolumeMg => getField<bool>('med_volume_mg');
  set medVolumeMg(bool? value) => setField<bool>('med_volume_mg', value);

  int? get medInducao => getField<int>('med_inducao');
  set medInducao(int? value) => setField<int>('med_inducao', value);

  double? get doseMgKg => getField<double>('dose_mg_kg');
  set doseMgKg(double? value) => setField<double>('dose_mg_kg', value);

  double? get concentracaoMgMl => getField<double>('concentracao_mg_ml');
  set concentracaoMgMl(double? value) =>
      setField<double>('concentracao_mg_ml', value);

  String? get medNomeEn => getField<String>('med_nome_en');
  set medNomeEn(String? value) => setField<String>('med_nome_en', value);

  String? get medNomeEs => getField<String>('med_nome_es');
  set medNomeEs(String? value) => setField<String>('med_nome_es', value);
}

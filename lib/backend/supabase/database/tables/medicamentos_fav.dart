import '../database.dart';

class MedicamentosFavTable extends SupabaseTable<MedicamentosFavRow> {
  @override
  String get tableName => 'medicamentos_fav';

  @override
  MedicamentosFavRow createRow(Map<String, dynamic> data) =>
      MedicamentosFavRow(data);
}

class MedicamentosFavRow extends SupabaseDataRow {
  MedicamentosFavRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => MedicamentosFavTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  int? get medId => getField<int>('med_id');
  set medId(int? value) => setField<int>('med_id', value);
}

import '../database.dart';

class InducoesFavTable extends SupabaseTable<InducoesFavRow> {
  @override
  String get tableName => 'inducoes_fav';

  @override
  InducoesFavRow createRow(Map<String, dynamic> data) => InducoesFavRow(data);
}

class InducoesFavRow extends SupabaseDataRow {
  InducoesFavRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => InducoesFavTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get indUsrId => getField<String>('ind_usr_id');
  set indUsrId(String? value) => setField<String>('ind_usr_id', value);

  int? get indId => getField<int>('ind_id');
  set indId(int? value) => setField<int>('ind_id', value);
}

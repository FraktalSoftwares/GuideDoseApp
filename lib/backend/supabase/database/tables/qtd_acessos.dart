import '../database.dart';

class QtdAcessosTable extends SupabaseTable<QtdAcessosRow> {
  @override
  String get tableName => 'qtdAcessos';

  @override
  QtdAcessosRow createRow(Map<String, dynamic> data) => QtdAcessosRow(data);
}

class QtdAcessosRow extends SupabaseDataRow {
  QtdAcessosRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => QtdAcessosTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get userAccess => getField<String>('user_access');
  set userAccess(String? value) => setField<String>('user_access', value);
}

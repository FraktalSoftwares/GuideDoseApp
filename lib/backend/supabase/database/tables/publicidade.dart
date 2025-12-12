import '../database.dart';

class PublicidadeTable extends SupabaseTable<PublicidadeRow> {
  @override
  String get tableName => 'publicidade';

  @override
  PublicidadeRow createRow(Map<String, dynamic> data) => PublicidadeRow(data);
}

class PublicidadeRow extends SupabaseDataRow {
  PublicidadeRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PublicidadeTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get pubImagem => getField<String>('pub_imagem');
  set pubImagem(String? value) => setField<String>('pub_imagem', value);

  String? get pubLink => getField<String>('pub_link');
  set pubLink(String? value) => setField<String>('pub_link', value);

  String? get pubStatus => getField<String>('pub_status');
  set pubStatus(String? value) => setField<String>('pub_status', value);
}

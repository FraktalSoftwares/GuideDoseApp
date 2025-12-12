import '../database.dart';

class MedicamentoItensTable extends SupabaseTable<MedicamentoItensRow> {
  @override
  String get tableName => 'medicamento_itens';

  @override
  MedicamentoItensRow createRow(Map<String, dynamic> data) =>
      MedicamentoItensRow(data);
}

class MedicamentoItensRow extends SupabaseDataRow {
  MedicamentoItensRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => MedicamentoItensTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  int? get medicamentoId => getField<int>('medicamento_id');
  set medicamentoId(int? value) => setField<int>('medicamento_id', value);

  String get topico => getField<String>('topico')!;
  set topico(String value) => setField<String>('topico', value);

  int? get ordem => getField<int>('ordem');
  set ordem(int? value) => setField<int>('ordem', value);

  String get titulo => getField<String>('titulo')!;
  set titulo(String value) => setField<String>('titulo', value);

  String? get subtitulo => getField<String>('subtitulo');
  set subtitulo(String? value) => setField<String>('subtitulo', value);

  dynamic? get dadosCalculo => getField<dynamic>('dados_calculo');
  set dadosCalculo(dynamic? value) => setField<dynamic>('dados_calculo', value);
}

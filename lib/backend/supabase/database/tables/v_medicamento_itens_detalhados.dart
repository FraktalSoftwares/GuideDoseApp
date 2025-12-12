import '../database.dart';

class VMedicamentoItensDetalhadosTable
    extends SupabaseTable<VMedicamentoItensDetalhadosRow> {
  @override
  String get tableName => 'v_medicamento_itens_detalhados';

  @override
  VMedicamentoItensDetalhadosRow createRow(Map<String, dynamic> data) =>
      VMedicamentoItensDetalhadosRow(data);
}

class VMedicamentoItensDetalhadosRow extends SupabaseDataRow {
  VMedicamentoItensDetalhadosRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VMedicamentoItensDetalhadosTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  int? get medicamentoId => getField<int>('medicamento_id');
  set medicamentoId(int? value) => setField<int>('medicamento_id', value);

  String? get topico => getField<String>('topico');
  set topico(String? value) => setField<String>('topico', value);

  int? get ordem => getField<int>('ordem');
  set ordem(int? value) => setField<int>('ordem', value);

  String? get titulo => getField<String>('titulo');
  set titulo(String? value) => setField<String>('titulo', value);

  String? get subtitulo => getField<String>('subtitulo');
  set subtitulo(String? value) => setField<String>('subtitulo', value);

  String? get concentracao => getField<String>('concentracao');
  set concentracao(String? value) => setField<String>('concentracao', value);

  String? get unidadeCalculo => getField<String>('unidade_calculo');
  set unidadeCalculo(String? value) =>
      setField<String>('unidade_calculo', value);

  String? get doseMin => getField<String>('dose_min');
  set doseMin(String? value) => setField<String>('dose_min', value);

  String? get doseMax => getField<String>('dose_max');
  set doseMax(String? value) => setField<String>('dose_max', value);

  String? get doseTeto => getField<String>('dose_teto');
  set doseTeto(String? value) => setField<String>('dose_teto', value);

  String? get contexto => getField<String>('contexto');
  set contexto(String? value) => setField<String>('contexto', value);

  String? get tipoIndicacao => getField<String>('tipo_indicacao');
  set tipoIndicacao(String? value) => setField<String>('tipo_indicacao', value);

  dynamic? get dadosCalculo => getField<dynamic>('dados_calculo');
  set dadosCalculo(dynamic? value) => setField<dynamic>('dados_calculo', value);
}

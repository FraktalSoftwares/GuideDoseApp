import '../database.dart';

class MedicamentosViewTable extends SupabaseTable<MedicamentosViewRow> {
  @override
  String get tableName => 'medicamentos_view';

  @override
  MedicamentosViewRow createRow(Map<String, dynamic> data) =>
      MedicamentosViewRow(data);
}

class MedicamentosViewRow extends SupabaseDataRow {
  MedicamentosViewRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => MedicamentosViewTable();

  int? get id => getField<int>('id');
  set id(int? value) => setField<int>('id', value);

  String? get nomeChave => getField<String>('nome_chave');
  set nomeChave(String? value) => setField<String>('nome_chave', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);

  String? get ptNomePrincipioAtivo =>
      getField<String>('pt_nome_principio_ativo');
  set ptNomePrincipioAtivo(String? value) =>
      setField<String>('pt_nome_principio_ativo', value);

  String? get ptNomeComercial => getField<String>('pt_nome_comercial');
  set ptNomeComercial(String? value) =>
      setField<String>('pt_nome_comercial', value);

  String? get ptClassificacao => getField<String>('pt_classificacao');
  set ptClassificacao(String? value) =>
      setField<String>('pt_classificacao', value);

  String? get ptMecanismoAcao => getField<String>('pt_mecanismo_acao');
  set ptMecanismoAcao(String? value) =>
      setField<String>('pt_mecanismo_acao', value);

  String? get ptFarmacocinetica => getField<String>('pt_farmacocinetica');
  set ptFarmacocinetica(String? value) =>
      setField<String>('pt_farmacocinetica', value);

  String? get ptFarmacodinamica => getField<String>('pt_farmacodinamica');
  set ptFarmacodinamica(String? value) =>
      setField<String>('pt_farmacodinamica', value);

  String? get ptIndicacoes => getField<String>('pt_indicacoes');
  set ptIndicacoes(String? value) => setField<String>('pt_indicacoes', value);

  String? get ptPosologia => getField<String>('pt_posologia');
  set ptPosologia(String? value) => setField<String>('pt_posologia', value);

  String? get ptAdministracao => getField<String>('pt_administracao');
  set ptAdministracao(String? value) =>
      setField<String>('pt_administracao', value);

  String? get ptDoseMaxima => getField<String>('pt_dose_maxima');
  set ptDoseMaxima(String? value) => setField<String>('pt_dose_maxima', value);

  String? get ptDoseMinima => getField<String>('pt_dose_minima');
  set ptDoseMinima(String? value) => setField<String>('pt_dose_minima', value);

  String? get ptReacoesAdversas => getField<String>('pt_reacoes_adversas');
  set ptReacoesAdversas(String? value) =>
      setField<String>('pt_reacoes_adversas', value);

  String? get ptRiscoGravidez => getField<String>('pt_risco_gravidez');
  set ptRiscoGravidez(String? value) =>
      setField<String>('pt_risco_gravidez', value);

  String? get ptRiscoLactacao => getField<String>('pt_risco_lactacao');
  set ptRiscoLactacao(String? value) =>
      setField<String>('pt_risco_lactacao', value);

  String? get ptAjusteRenal => getField<String>('pt_ajuste_renal');
  set ptAjusteRenal(String? value) =>
      setField<String>('pt_ajuste_renal', value);

  String? get ptAjusteHepatico => getField<String>('pt_ajuste_hepatico');
  set ptAjusteHepatico(String? value) =>
      setField<String>('pt_ajuste_hepatico', value);

  String? get ptContraindicacoes => getField<String>('pt_contraindicacoes');
  set ptContraindicacoes(String? value) =>
      setField<String>('pt_contraindicacoes', value);

  String? get ptInteracaoMedicamento =>
      getField<String>('pt_interacao_medicamento');
  set ptInteracaoMedicamento(String? value) =>
      setField<String>('pt_interacao_medicamento', value);

  String? get ptApresentacao => getField<String>('pt_apresentacao');
  set ptApresentacao(String? value) =>
      setField<String>('pt_apresentacao', value);

  String? get ptPreparo => getField<String>('pt_preparo');
  set ptPreparo(String? value) => setField<String>('pt_preparo', value);

  String? get ptSolucoesCompativeis =>
      getField<String>('pt_solucoes_compativeis');
  set ptSolucoesCompativeis(String? value) =>
      setField<String>('pt_solucoes_compativeis', value);

  String? get ptArmazenamento => getField<String>('pt_armazenamento');
  set ptArmazenamento(String? value) =>
      setField<String>('pt_armazenamento', value);

  String? get ptCuidadosMedicos => getField<String>('pt_cuidados_medicos');
  set ptCuidadosMedicos(String? value) =>
      setField<String>('pt_cuidados_medicos', value);

  String? get ptCuidadosFarmaceuticos =>
      getField<String>('pt_cuidados_farmaceuticos');
  set ptCuidadosFarmaceuticos(String? value) =>
      setField<String>('pt_cuidados_farmaceuticos', value);

  String? get ptCuidadosEnfermagem =>
      getField<String>('pt_cuidados_enfermagem');
  set ptCuidadosEnfermagem(String? value) =>
      setField<String>('pt_cuidados_enfermagem', value);

  String? get ptFontesBibliograficas =>
      getField<String>('pt_fontes_bibliograficas');
  set ptFontesBibliograficas(String? value) =>
      setField<String>('pt_fontes_bibliograficas', value);

  String? get ptViaEliminacao => getField<String>('pt_via_eliminacao');
  set ptViaEliminacao(String? value) =>
      setField<String>('pt_via_eliminacao', value);

  String? get ptInicioAcao => getField<String>('pt_inicio_acao');
  set ptInicioAcao(String? value) => setField<String>('pt_inicio_acao', value);

  String? get ptTempoPico => getField<String>('pt_tempo_pico');
  set ptTempoPico(String? value) => setField<String>('pt_tempo_pico', value);

  String? get ptMeiaVida => getField<String>('pt_meia_vida');
  set ptMeiaVida(String? value) => setField<String>('pt_meia_vida', value);

  String? get ptEfeitoClinico => getField<String>('pt_efeito_clinico');
  set ptEfeitoClinico(String? value) =>
      setField<String>('pt_efeito_clinico', value);

  String? get ptEstabilidadePosDiluicao =>
      getField<String>('pt_estabilidade_pos_diluicao');
  set ptEstabilidadePosDiluicao(String? value) =>
      setField<String>('pt_estabilidade_pos_diluicao', value);

  String? get ptPrecaucoesEspecificas =>
      getField<String>('pt_precaucoes_especificas');
  set ptPrecaucoesEspecificas(String? value) =>
      setField<String>('pt_precaucoes_especificas', value);

  String? get usNomePrincipioAtivo =>
      getField<String>('us_nome_principio_ativo');
  set usNomePrincipioAtivo(String? value) =>
      setField<String>('us_nome_principio_ativo', value);

  String? get usNomeComercial => getField<String>('us_nome_comercial');
  set usNomeComercial(String? value) =>
      setField<String>('us_nome_comercial', value);

  String? get usClassificacao => getField<String>('us_classificacao');
  set usClassificacao(String? value) =>
      setField<String>('us_classificacao', value);

  String? get usMecanismoAcao => getField<String>('us_mecanismo_acao');
  set usMecanismoAcao(String? value) =>
      setField<String>('us_mecanismo_acao', value);

  String? get usFarmacocinetica => getField<String>('us_farmacocinetica');
  set usFarmacocinetica(String? value) =>
      setField<String>('us_farmacocinetica', value);

  String? get usFarmacodinamica => getField<String>('us_farmacodinamica');
  set usFarmacodinamica(String? value) =>
      setField<String>('us_farmacodinamica', value);

  String? get usIndicacoes => getField<String>('us_indicacoes');
  set usIndicacoes(String? value) => setField<String>('us_indicacoes', value);

  String? get usPosologia => getField<String>('us_posologia');
  set usPosologia(String? value) => setField<String>('us_posologia', value);

  String? get usAdministracao => getField<String>('us_administracao');
  set usAdministracao(String? value) =>
      setField<String>('us_administracao', value);

  String? get usDoseMaxima => getField<String>('us_dose_maxima');
  set usDoseMaxima(String? value) => setField<String>('us_dose_maxima', value);

  String? get usDoseMinima => getField<String>('us_dose_minima');
  set usDoseMinima(String? value) => setField<String>('us_dose_minima', value);

  String? get usReacoesAdversas => getField<String>('us_reacoes_adversas');
  set usReacoesAdversas(String? value) =>
      setField<String>('us_reacoes_adversas', value);

  String? get usRiscoGravidez => getField<String>('us_risco_gravidez');
  set usRiscoGravidez(String? value) =>
      setField<String>('us_risco_gravidez', value);

  String? get usRiscoLactacao => getField<String>('us_risco_lactacao');
  set usRiscoLactacao(String? value) =>
      setField<String>('us_risco_lactacao', value);

  String? get usAjusteRenal => getField<String>('us_ajuste_renal');
  set usAjusteRenal(String? value) =>
      setField<String>('us_ajuste_renal', value);

  String? get usAjusteHepatico => getField<String>('us_ajuste_hepatico');
  set usAjusteHepatico(String? value) =>
      setField<String>('us_ajuste_hepatico', value);

  String? get usContraindicacoes => getField<String>('us_contraindicacoes');
  set usContraindicacoes(String? value) =>
      setField<String>('us_contraindicacoes', value);

  String? get usInteracaoMedicamento =>
      getField<String>('us_interacao_medicamento');
  set usInteracaoMedicamento(String? value) =>
      setField<String>('us_interacao_medicamento', value);

  String? get usApresentacao => getField<String>('us_apresentacao');
  set usApresentacao(String? value) =>
      setField<String>('us_apresentacao', value);

  String? get usPreparo => getField<String>('us_preparo');
  set usPreparo(String? value) => setField<String>('us_preparo', value);

  String? get usSolucoesCompativeis =>
      getField<String>('us_solucoes_compativeis');
  set usSolucoesCompativeis(String? value) =>
      setField<String>('us_solucoes_compativeis', value);

  String? get usArmazenamento => getField<String>('us_armazenamento');
  set usArmazenamento(String? value) =>
      setField<String>('us_armazenamento', value);

  String? get usCuidadosMedicos => getField<String>('us_cuidados_medicos');
  set usCuidadosMedicos(String? value) =>
      setField<String>('us_cuidados_medicos', value);

  String? get usCuidadosFarmaceuticos =>
      getField<String>('us_cuidados_farmaceuticos');
  set usCuidadosFarmaceuticos(String? value) =>
      setField<String>('us_cuidados_farmaceuticos', value);

  String? get usCuidadosEnfermagem =>
      getField<String>('us_cuidados_enfermagem');
  set usCuidadosEnfermagem(String? value) =>
      setField<String>('us_cuidados_enfermagem', value);

  String? get usFontesBibliograficas =>
      getField<String>('us_fontes_bibliograficas');
  set usFontesBibliograficas(String? value) =>
      setField<String>('us_fontes_bibliograficas', value);

  String? get usViaEliminacao => getField<String>('us_via_eliminacao');
  set usViaEliminacao(String? value) =>
      setField<String>('us_via_eliminacao', value);

  String? get usInicioAcao => getField<String>('us_inicio_acao');
  set usInicioAcao(String? value) => setField<String>('us_inicio_acao', value);

  String? get usTempoPico => getField<String>('us_tempo_pico');
  set usTempoPico(String? value) => setField<String>('us_tempo_pico', value);

  String? get usMeiaVida => getField<String>('us_meia_vida');
  set usMeiaVida(String? value) => setField<String>('us_meia_vida', value);

  String? get usEfeitoClinico => getField<String>('us_efeito_clinico');
  set usEfeitoClinico(String? value) =>
      setField<String>('us_efeito_clinico', value);

  String? get usEstabilidadePosDiluicao =>
      getField<String>('us_estabilidade_pos_diluicao');
  set usEstabilidadePosDiluicao(String? value) =>
      setField<String>('us_estabilidade_pos_diluicao', value);

  String? get usPrecaucoesEspecificas =>
      getField<String>('us_precaucoes_especificas');
  set usPrecaucoesEspecificas(String? value) =>
      setField<String>('us_precaucoes_especificas', value);

  String? get esNomePrincipioAtivo =>
      getField<String>('es_nome_principio_ativo');
  set esNomePrincipioAtivo(String? value) =>
      setField<String>('es_nome_principio_ativo', value);

  String? get esNomeComercial => getField<String>('es_nome_comercial');
  set esNomeComercial(String? value) =>
      setField<String>('es_nome_comercial', value);

  String? get esClassificacao => getField<String>('es_classificacao');
  set esClassificacao(String? value) =>
      setField<String>('es_classificacao', value);

  String? get esMecanismoAcao => getField<String>('es_mecanismo_acao');
  set esMecanismoAcao(String? value) =>
      setField<String>('es_mecanismo_acao', value);

  String? get esFarmacocinetica => getField<String>('es_farmacocinetica');
  set esFarmacocinetica(String? value) =>
      setField<String>('es_farmacocinetica', value);

  String? get esFarmacodinamica => getField<String>('es_farmacodinamica');
  set esFarmacodinamica(String? value) =>
      setField<String>('es_farmacodinamica', value);

  String? get esIndicacoes => getField<String>('es_indicacoes');
  set esIndicacoes(String? value) => setField<String>('es_indicacoes', value);

  String? get esPosologia => getField<String>('es_posologia');
  set esPosologia(String? value) => setField<String>('es_posologia', value);

  String? get esAdministracao => getField<String>('es_administracao');
  set esAdministracao(String? value) =>
      setField<String>('es_administracao', value);

  String? get esDoseMaxima => getField<String>('es_dose_maxima');
  set esDoseMaxima(String? value) => setField<String>('es_dose_maxima', value);

  String? get esDoseMinima => getField<String>('es_dose_minima');
  set esDoseMinima(String? value) => setField<String>('es_dose_minima', value);

  String? get esReacoesAdversas => getField<String>('es_reacoes_adversas');
  set esReacoesAdversas(String? value) =>
      setField<String>('es_reacoes_adversas', value);

  String? get esRiscoGravidez => getField<String>('es_risco_gravidez');
  set esRiscoGravidez(String? value) =>
      setField<String>('es_risco_gravidez', value);

  String? get esRiscoLactacao => getField<String>('es_risco_lactacao');
  set esRiscoLactacao(String? value) =>
      setField<String>('es_risco_lactacao', value);

  String? get esAjusteRenal => getField<String>('es_ajuste_renal');
  set esAjusteRenal(String? value) =>
      setField<String>('es_ajuste_renal', value);

  String? get esAjusteHepatico => getField<String>('es_ajuste_hepatico');
  set esAjusteHepatico(String? value) =>
      setField<String>('es_ajuste_hepatico', value);

  String? get esContraindicacoes => getField<String>('es_contraindicacoes');
  set esContraindicacoes(String? value) =>
      setField<String>('es_contraindicacoes', value);

  String? get esInteracaoMedicamento =>
      getField<String>('es_interacao_medicamento');
  set esInteracaoMedicamento(String? value) =>
      setField<String>('es_interacao_medicamento', value);

  String? get esApresentacao => getField<String>('es_apresentacao');
  set esApresentacao(String? value) =>
      setField<String>('es_apresentacao', value);

  String? get esPreparo => getField<String>('es_preparo');
  set esPreparo(String? value) => setField<String>('es_preparo', value);

  String? get esSolucoesCompativeis =>
      getField<String>('es_solucoes_compativeis');
  set esSolucoesCompativeis(String? value) =>
      setField<String>('es_solucoes_compativeis', value);

  String? get esArmazenamento => getField<String>('es_armazenamento');
  set esArmazenamento(String? value) =>
      setField<String>('es_armazenamento', value);

  String? get esCuidadosMedicos => getField<String>('es_cuidados_medicos');
  set esCuidadosMedicos(String? value) =>
      setField<String>('es_cuidados_medicos', value);

  String? get esCuidadosFarmaceuticos =>
      getField<String>('es_cuidados_farmaceuticos');
  set esCuidadosFarmaceuticos(String? value) =>
      setField<String>('es_cuidados_farmaceuticos', value);

  String? get esCuidadosEnfermagem =>
      getField<String>('es_cuidados_enfermagem');
  set esCuidadosEnfermagem(String? value) =>
      setField<String>('es_cuidados_enfermagem', value);

  String? get esFontesBibliograficas =>
      getField<String>('es_fontes_bibliograficas');
  set esFontesBibliograficas(String? value) =>
      setField<String>('es_fontes_bibliograficas', value);

  String? get esViaEliminacao => getField<String>('es_via_eliminacao');
  set esViaEliminacao(String? value) =>
      setField<String>('es_via_eliminacao', value);

  String? get esInicioAcao => getField<String>('es_inicio_acao');
  set esInicioAcao(String? value) => setField<String>('es_inicio_acao', value);

  String? get esTempoPico => getField<String>('es_tempo_pico');
  set esTempoPico(String? value) => setField<String>('es_tempo_pico', value);

  String? get esMeiaVida => getField<String>('es_meia_vida');
  set esMeiaVida(String? value) => setField<String>('es_meia_vida', value);

  String? get esEfeitoClinico => getField<String>('es_efeito_clinico');
  set esEfeitoClinico(String? value) =>
      setField<String>('es_efeito_clinico', value);

  String? get esEstabilidadePosDiluicao =>
      getField<String>('es_estabilidade_pos_diluicao');
  set esEstabilidadePosDiluicao(String? value) =>
      setField<String>('es_estabilidade_pos_diluicao', value);

  String? get esPrecaucoesEspecificas =>
      getField<String>('es_precaucoes_especificas');
  set esPrecaucoesEspecificas(String? value) =>
      setField<String>('es_precaucoes_especificas', value);
}

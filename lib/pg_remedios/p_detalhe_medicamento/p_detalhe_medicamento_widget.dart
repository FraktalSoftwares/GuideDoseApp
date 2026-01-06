import '/backend/supabase/supabase.dart';
import '/backend/offline/sync_manager.dart';
import '/backend/offline/offline_database.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'p_detalhe_medicamento_model.dart';
export 'p_detalhe_medicamento_model.dart';

class PDetalheMedicamentoWidget extends StatefulWidget {
  const PDetalheMedicamentoWidget({
    super.key,
    required this.id,
  });

  final int? id;

  @override
  State<PDetalheMedicamentoWidget> createState() =>
      _PDetalheMedicamentoWidgetState();
}

class _PDetalheMedicamentoWidgetState extends State<PDetalheMedicamentoWidget> {
  late PDetalheMedicamentoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PDetalheMedicamentoModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  Future<Map<String, dynamic>?> _loadMedicamentoDetails() async {
    final syncManager = SyncManager.instance;

    print('🔍 Carregando detalhes do medicamento ID: ${widget.id}');
    print('📡 Status online: ${syncManager.isOnline}');

    if (syncManager.isOnline) {
      // Online: busca do Supabase
      try {
        print('🌐 Buscando do Supabase...');
        final rows = await MedicamentosTable().querySingleRow(
          queryFn: (q) => q.eqOrNull('id', widget.id),
        );
        print('📦 Rows recebidos: ${rows?.length ?? 0}');
        if (rows != null && rows.isNotEmpty) {
          final row = rows.first;
          print('✅ Medicamento encontrado online: ${row.ptNomePrincipioAtivo}');
          return {
            'pt_nome_principio_ativo': row.ptNomePrincipioAtivo,
            'us_nome_principio_ativo': row.usNomePrincipioAtivo,
            'es_nome_principio_ativo': row.esNomePrincipioAtivo,
            'pt_nome_comercial': row.ptNomeComercial,
            'us_nome_comercial': row.usNomeComercial,
            'es_nome_comercial': row.esNomeComercial,
            'pt_classificacao': row.ptClassificacao,
            'us_classificacao': row.usClassificacao,
            'es_classificacao': row.esClassificacao,
            'pt_mecanismo_acao': row.ptMecanismoAcao,
            'us_mecanismo_acao': row.usMecanismoAcao,
            'es_mecanismo_acao': row.esMecanismoAcao,
            'pt_farmacocinetica': row.ptFarmacocinetica,
            'us_farmacocinetica': row.usFarmacocinetica,
            'es_farmacocinetica': row.esFarmacocinetica,
            'pt_indicacoes': row.ptIndicacoes,
            'us_indicacoes': row.usIndicacoes,
            'es_indicacoes': row.esIndicacoes,
            'pt_posologia': row.ptPosologia,
            'us_posologia': row.usPosologia,
            'es_posologia': row.esPosologia,
            'pt_administracao': row.ptAdministracao,
            'us_administracao': row.usAdministracao,
            'es_administracao': row.esAdministracao,
            'pt_dose_minima': row.ptDoseMinima,
            'us_dose_minima': row.usDoseMinima,
            'es_dose_minima': row.esDoseMinima,
            'pt_dose_maxima': row.ptDoseMaxima,
            'us_dose_maxima': row.usDoseMaxima,
            'es_dose_maxima': row.esDoseMaxima,
            'pt_ajuste_renal': row.ptAjusteRenal,
            'us_ajuste_renal': row.usAjusteRenal,
            'es_ajuste_renal': row.esAjusteRenal,
            'pt_apresentacao': row.ptApresentacao,
            'us_apresentacao': row.usApresentacao,
            'es_apresentacao': row.esApresentacao,
            'pt_preparo': row.ptPreparo,
            'us_preparo': row.usPreparo,
            'es_preparo': row.esPreparo,
            'pt_inicio_acao': row.ptInicioAcao,
            'us_inicio_acao': row.usInicioAcao,
            'es_inicio_acao': row.esInicioAcao,
            'pt_tempo_pico': row.ptTempoPico,
            'us_tempo_pico': row.usTempoPico,
            'es_tempo_pico': row.esTempoPico,
            'pt_meia_vida': row.ptMeiaVida,
            'us_meia_vida': row.usMeiaVida,
            'es_meia_vida': row.esMeiaVida,
          };
        }
        print('⚠️ Nenhum medicamento encontrado online');
      } catch (e) {
        print('❌ Erro ao buscar medicamento online: $e');
      }
    }

    // Offline ou falhou online: busca do cache
    print('💾 Buscando do cache local...');
    final cached =
        await OfflineDatabase.instance.getMedicamentoById(widget.id!);
    if (cached != null) {
      print('✅ Medicamento encontrado no cache: ${cached['nome']}');
      print('📋 Campos disponíveis: ${cached.keys.toList()}');
    } else {
      print('❌ Medicamento NÃO encontrado no cache');
    }
    return cached;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _loadMedicamentoDetails(),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: SpinKitRing(
                color: Color(0xFF3C4F67),
                size: 50.0,
              ),
            ),
          );
        }

        final medicamento = snapshot.data;

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF1E293B),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: 113.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).header,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              '5lz4atxf' /* Bula do Medicamento */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ]
                            .divide(SizedBox(width: 8.0))
                            .addToStart(SizedBox(width: 24.0))
                            .addToEnd(SizedBox(width: 24.0)),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 700.0,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(32.0, 32.0, 32.0, 0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            valueOrDefault<String>(
                              FFLocalizations.of(context).getVariableText(
                                ptText: medicamento?['pt_nome_principio_ativo'],
                                enText: medicamento?['us_nome_principio_ativo'],
                                esText: medicamento?['es_nome_principio_ativo'],
                              ),
                              'Indefinido',
                            ),
                            style:
                                FlutterFlowTheme.of(context).textAuth.override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .textAuth
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context).text,
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .textAuth
                                          .fontStyle,
                                    ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'vu9emtce' /* Princípio Ativo */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedicamentos
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedicamentos
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedicamentos
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            valueOrDefault<String>(
                              FFLocalizations.of(context).getVariableText(
                                ptText: medicamento?['pt_nome_principio_ativo'],
                                enText: medicamento?['us_nome_principio_ativo'],
                                esText: medicamento?['es_nome_principio_ativo'],
                              ),
                              'Indefinido',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .infoMedicamentos
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .fontStyle,
                                  ),
                                  color: Color(0xFFE2E8F0),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'p1zuxw19' /* Nome comercial */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedicamentos
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedicamentos
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedicamentos
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            valueOrDefault<String>(
                              FFLocalizations.of(context).getVariableText(
                                ptText: medicamento?['pt_nome_comercial'],
                                enText: medicamento?['us_nome_comercial'],
                                esText: medicamento?['es_nome_comercial'],
                              ),
                              'Indefinido',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .infoMedicamentos
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .fontStyle,
                                  ),
                                  color: Color(0xFFE2E8F0),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              '2jvoryw1' /* Classificação */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedicamentos
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedicamentos
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedicamentos
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            valueOrDefault<String>(
                              FFLocalizations.of(context).getVariableText(
                                ptText: medicamento?['pt_classificacao'],
                                enText: medicamento?['us_classificacao'],
                                esText: medicamento?['es_classificacao'],
                              ),
                              'Indefinido',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'uumhnsw1' /* Mecanismo de ação */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedicamentos
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedicamentos
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedicamentos
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            valueOrDefault<String>(
                              FFLocalizations.of(context).getVariableText(
                                ptText: medicamento?['pt_mecanismo_acao'],
                                enText: medicamento?['us_mecanismo_acao'],
                                esText: medicamento?['es_mecanismo_acao'],
                              ),
                              'Indefinido',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .infoMedicamentos
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .fontStyle,
                                  ),
                                  color: Color(0xFFE2E8F0),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'lh8f86y0' /* Farmacocinética */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedicamentos
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedicamentos
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedicamentos
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            valueOrDefault<String>(
                              FFLocalizations.of(context).getVariableText(
                                ptText: medicamento?['pt_farmacocinetica'],
                                enText: medicamento?['us_farmacocinetica'],
                                esText: medicamento?['es_farmacocinetica'],
                              ),
                              'Indefinido',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .infoMedicamentos
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .fontStyle,
                                  ),
                                  color: Color(0xFFE2E8F0),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'z9u68bhr' /* Indicações */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedicamentos
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedicamentos
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedicamentos
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            valueOrDefault<String>(
                              FFLocalizations.of(context).getVariableText(
                                ptText: medicamento?['pt_indicacoes'],
                                enText: medicamento?['us_indicacoes'],
                                esText: medicamento?['es_indicacoes'],
                              ),
                              'Indefinido',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .infoMedicamentos
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .fontStyle,
                                  ),
                                  color: Color(0xFFE2E8F0),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'f313byc4' /* Posologia */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedicamentos
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedicamentos
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedicamentos
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            valueOrDefault<String>(
                              FFLocalizations.of(context).getVariableText(
                                ptText: medicamento?['pt_posologia'],
                                enText: medicamento?['us_posologia'],
                                esText: medicamento?['es_posologia'],
                              ),
                              'Indefinido',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .infoMedicamentos
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .fontStyle,
                                  ),
                                  color: Color(0xFFE2E8F0),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'ir2bjznl' /* Administração */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedicamentos
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedicamentos
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedicamentos
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            valueOrDefault<String>(
                              FFLocalizations.of(context).getVariableText(
                                ptText: medicamento?['pt_administracao'],
                                enText: medicamento?['us_administracao'],
                                esText: medicamento?['es_administracao'],
                              ),
                              'Indefinido',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .infoMedicamentos
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .fontStyle,
                                  ),
                                  color: Color(0xFFE2E8F0),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .fontStyle,
                                ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'fgg0kgm1' /* Dose Máxima */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?['pt_dose_maxima'],
                                    enText: medicamento?['us_dose_maxima'],
                                    esText: medicamento?['es_dose_maxima'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'jvsk4u8c' /* Dose mínima */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?['pt_dose_minima'],
                                    enText: medicamento?['us_dose_minima'],
                                    esText: medicamento?['es_dose_minima'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'u56c63gj' /* Reações adversas */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?['pt_reacoes_adversas'],
                                    enText: medicamento?['us_reacoes_adversas'],
                                    esText: medicamento?['es_reacoes_adversas'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'oit2o30c' /* Risco gravidez */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?['pt_risco_gravidez'],
                                    enText: medicamento?['us_risco_gravidez'],
                                    esText: medicamento?['es_risco_gravidez'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'wktwinhv' /* Risco lactação */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?['pt_risco_lactacao'],
                                    enText: medicamento?['us_risco_lactacao'],
                                    esText: medicamento?['es_risco_lactacao'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  '27crkti0' /* Ajuste Renal */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?['pt_ajuste_renal'],
                                    enText: medicamento?['us_ajuste_renal'],
                                    esText: medicamento?['es_ajuste_renal'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'sl73ufmd' /* Ajuste Hepático */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?['pt_ajuste_hepatico'],
                                    enText: medicamento?['us_ajuste_hepatico'],
                                    esText: medicamento?['es_ajuste_hepatico'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  '2peccn6y' /* Contra Indicações */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?['pt_contraindicacoes'],
                                    enText: medicamento?['us_contraindicacoes'],
                                    esText: medicamento?['es_contraindicacoes'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'phuszhkn' /* Interação Medicamento */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?[
                                        'pt_interacao_medicamento'],
                                    enText: medicamento?[
                                        'us_interacao_medicamento'],
                                    esText: medicamento?[
                                        'es_interacao_medicamento'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'm2zpuphb' /* Apresentação */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?['pt_apresentacao'],
                                    enText: medicamento?['us_apresentacao'],
                                    esText: medicamento?['es_apresentacao'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  '2s3xeif1' /* Preparo */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?['pt_preparo'],
                                    enText: medicamento?['us_preparo'],
                                    esText: medicamento?['es_preparo'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  '6cr7qlur' /* Soluções compatíveis */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText:
                                        medicamento?['pt_solucoes_compativeis'],
                                    enText:
                                        medicamento?['us_solucoes_compativeis'],
                                    esText:
                                        medicamento?['es_solucoes_compativeis'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  '8ieyxvhz' /* Amarzenamento */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?['pt_armazenamento'],
                                    enText: medicamento?['us_armazenamento'],
                                    esText: medicamento?['es_armazenamento'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'w28qurgy' /* Cuidados Médicos */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?['pt_cuidados_medicos'],
                                    enText: medicamento?['us_cuidados_medicos'],
                                    esText: medicamento?['es_cuidados_medicos'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  '6gd9tklu' /* Cuidados Farmacêuticos  */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?[
                                        'pt_cuidados_farmaceuticos'],
                                    enText: medicamento?[
                                        'us_cuidados_farmaceuticos'],
                                    esText: medicamento?[
                                        'es_cuidados_farmaceuticos'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  '1txq4qfg' /* Cuidados Enfermagem */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText:
                                        medicamento?['pt_cuidados_enfermagem'],
                                    enText:
                                        medicamento?['us_cuidados_enfermagem'],
                                    esText:
                                        medicamento?['es_cuidados_enfermagem'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'u6jxezpo' /* Início Ação */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?['pt_inicio_acao'],
                                    enText: medicamento?['us_inicio_acao'],
                                    esText: medicamento?['es_inicio_acao'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'al0o5c4u' /* Tempo Pico */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?['pt_tempo_pico'],
                                    enText: medicamento?['us_tempo_pico'],
                                    esText: medicamento?['es_tempo_pico'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'eej74okp' /* Meia Vida */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?['pt_meia_vida'],
                                    enText: medicamento?['us_meia_vida'],
                                    esText: medicamento?['es_meia_vida'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'toux1a9i' /* Efeito Clínico */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?['pt_efeito_clinico'],
                                    enText: medicamento?['us_efeito_clinico'],
                                    esText: medicamento?['es_efeito_clinico'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'kiph06kq' /* Via Eliminação */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?['pt_via_eliminacao'],
                                    enText: medicamento?['us_via_eliminacao'],
                                    esText: medicamento?['es_via_eliminacao'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'bw9gabwb' /* Estabilidade Pós Diluição */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?[
                                        'pt_estabilidade_pos_diluicao'],
                                    enText: medicamento?[
                                        'us_estabilidade_pos_diluicao'],
                                    esText: medicamento?[
                                        'es_estabilidade_pos_diluicao'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  '0yna7hv7' /* Precauções Específicas */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?[
                                        'pt_precaucoes_especificas'],
                                    enText: medicamento?[
                                        'us_precaucoes_especificas'],
                                    esText: medicamento?[
                                        'es_precaucoes_especificas'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'umo90p52' /* Bibliografia */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedicamentos
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFLocalizations.of(context).getVariableText(
                                    ptText: medicamento?[
                                        'pt_fontes_bibliograficas'],
                                    enText: medicamento?[
                                        'us_fontes_bibliograficas'],
                                    esText: medicamento?[
                                        'es_fontes_bibliograficas'],
                                  ),
                                  'Indefinido',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .infoMedicamentos
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .infoMedicamentos
                                            .fontStyle,
                                      ),
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

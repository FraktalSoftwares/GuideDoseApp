import '/backend/supabase/supabase.dart';
import '/backend/offline/sync_manager.dart';
import '/backend/offline/offline_database.dart';
import '/components/p_empty_list/p_empty_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'p_detalhe_inducao_model.dart';
export 'p_detalhe_inducao_model.dart';

class PDetalheInducaoWidget extends StatefulWidget {
  const PDetalheInducaoWidget({
    super.key,
    required this.id,
  });

  final int? id;

  @override
  State<PDetalheInducaoWidget> createState() => _PDetalheInducaoWidgetState();
}

class _PDetalheInducaoWidgetState extends State<PDetalheInducaoWidget> {
  late PDetalheInducaoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PDetalheInducaoModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  // Método helper para carregar subtópicos por tópico (online ou offline)
  Future<List<VwInducoesSubtopicosRow>> _loadSubtopicosByTopico(
      String topico) async {
    final syncManager = SyncManager.instance;

    if (syncManager.isOnline) {
      try {
        return await VwInducoesSubtopicosTable().queryRows(
          queryFn: (q) =>
              q.eqOrNull('ind_id', widget.id).eqOrNull('ind_topico', topico),
        );
      } catch (e) {
        print('❌ Erro ao buscar subtópicos online ($topico): $e');
        return [];
      }
    }

    // Offline: busca do cache e filtra por tópico
    try {
      print('💾 Buscando subtópicos do cache (tópico: $topico)');
      final cached =
          await OfflineDatabase.instance.getSubtopicosByInducaoId(widget.id!);

      // Filtra por tópico
      final filtered =
          cached.where((map) => map['ind_topico'] == topico).toList();
      print('📦 Encontrados ${filtered.length} subtópicos para tópico $topico');

      // Converte Map para VwInducoesSubtopicosRow
      return filtered.map((map) {
        final mappedData = {
          'ind_id': map['ind_id'],
          'ind_topico': map['ind_topico'],
          'ind_titulos': map['ind_titulos'],
          'conteudos_pt': map['ind_descricao'],
          'conteudos_en': map['ind_descricao_en'],
          'conteudos_es': map['ind_descricao_es'],
        };
        return VwInducoesSubtopicosRow(mappedData);
      }).toList();
    } catch (e) {
      print('❌ Erro ao buscar subtópicos do cache ($topico): $e');
      return [];
    }
  }

  Future<List<InducoesSubtopicosRow>> _loadSubtopicos() async {
    final syncManager = SyncManager.instance;

    if (syncManager.isOnline) {
      try {
        return await InducoesSubtopicosTable().queryRows(
          queryFn: (q) => q.eqOrNull('ind_id', widget.id),
        );
      } catch (e) {
        print('❌ Erro ao buscar subtópicos online: $e');
        return [];
      }
    }

    // Offline: busca do cache
    try {
      print(
          '💾 Buscando TODOS subtópicos do cache para indução ID: ${widget.id}');
      final cached =
          await OfflineDatabase.instance.getSubtopicosByInducaoId(widget.id!);
      print('📦 Encontrados ${cached.length} subtópicos no cache');

      // Converte Map para InducoesSubtopicosRow
      // IMPORTANTE: InducoesSubtopicosRow usa ind_nome/ind_nome_en/ind_nome_es para o CONTEÚDO
      return cached.map((map) {
        final mappedData = {
          'ind_id': map['ind_id'],
          'ind_topico': map['ind_topico'],
          'ind_titulos': map['ind_titulos'],
          'ind_nome': map['ind_descricao'], // Conteúdo em PT
          'ind_nome_en': map['ind_descricao_en'], // Conteúdo em EN
          'ind_nome_es': map['ind_descricao_es'], // Conteúdo em ES
        };
        return InducoesSubtopicosRow(mappedData);
      }).toList();
    } catch (e) {
      print('❌ Erro ao buscar subtópicos do cache: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>?> _loadInducaoDetails() async {
    final syncManager = SyncManager.instance;

    print('🔍 Carregando detalhes da indução ID: ${widget.id}');
    print('📡 Status online: ${syncManager.isOnline}');

    if (syncManager.isOnline) {
      // Online: busca do Supabase
      try {
        print('🌐 Buscando do Supabase...');
        final rows = await InducoesTable().querySingleRow(
          queryFn: (q) => q.eqOrNull('id', widget.id),
        );
        print('📦 Rows recebidos: ${rows?.length ?? 0}');
        if (rows != null && rows.isNotEmpty) {
          final row = rows.first;
          print('✅ Indução encontrada online: ${row.indNome}');
          return {
            'ind_nome': row.indNome,
            'ind_nome_en': row.indNomeEn,
            'ind_nome_es': row.indNomeEs,
            'ind_definicao': row.indDefinicao,
            'definicao_en': row.definicaoEn,
            'definicao_es': row.definicaoEs,
            'ind_epidemiologia': row.indEpidemiologia,
            'epidemiologia_en': row.epidemiologiaEn,
            'epidemiologia_es': row.epidemiologiaEs,
            'ind_fisiopatologia': row.indFisiopatologia,
            'fisiopatologia_en': row.fisiopatologiaEn,
            'fisiopatologia_es': row.fisiopatologiaEs,
          };
        }
        print('⚠️ Nenhuma indução encontrada online');
      } catch (e) {
        print('❌ Erro ao buscar indução online: $e');
      }
    }

    // Offline ou falhou online: busca do cache
    print('💾 Buscando do cache local...');
    final cached = await OfflineDatabase.instance.getInducaoById(widget.id!);
    if (cached != null) {
      print('✅ Indução encontrada no cache: ${cached['nome']}');
      print('📋 Campos disponíveis: ${cached.keys.toList()}');
      print('🔍 DEBUG - Valores completos:');
      cached.forEach((key, value) {
        if (key.contains('nome') ||
            key.contains('definicao') ||
            key.contains('epidemiologia') ||
            key.contains('fisiopatologia')) {
          final valueStr = value?.toString() ?? 'NULL';
          final preview = valueStr.length > 50
              ? '${valueStr.substring(0, 50)}...'
              : valueStr;
          print('   $key = $preview');
        }
      });
    } else {
      print('❌ Indução NÃO encontrada no cache');
    }
    return cached;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _loadInducaoDetails(),
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

        final inducao = snapshot.data;

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
                              'dfxk0njl' /* Informativo da Condição */,
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
                Expanded(
                  child: FutureBuilder<List<InducoesSubtopicosRow>>(
                    future: (_model.requestCompleter2 ??=
                            Completer<List<InducoesSubtopicosRow>>()
                              ..complete(_loadSubtopicos()))
                        .future,
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
                      List<InducoesSubtopicosRow>
                          containerInducoesSubtopicosRowList = snapshot.data!;

                      return Container(
                        width: double.infinity,
                        height: 700.0,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              32.0, 32.0, 32.0, 32.0),
                          child: RefreshIndicator(
                            color: Color(0xFF3C4F67),
                            backgroundColor: Color(0xFF14181B),
                            onRefresh: () async {
                              safeSetState(
                                  () => _model.requestCompleter1 = null);
                              await _model.waitForRequestCompleted1();
                              safeSetState(
                                  () => _model.requestCompleter2 = null);
                              await _model.waitForRequestCompleted2();
                            },
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    FFLocalizations.of(context).getVariableText(
                                      ptText:
                                          inducao?['ind_nome'] ?? 'Indefinido',
                                      enText: inducao?['ind_nome_en'] ??
                                          'Indefinido',
                                      esText: inducao?['ind_nome_es'] ??
                                          'Indefinido',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .textAuth
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .textAuth
                                                    .fontStyle,
                                          ),
                                          color:
                                              FlutterFlowTheme.of(context).text,
                                          fontSize: 20.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .textAuth
                                                  .fontStyle,
                                        ),
                                  ),
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'x08xbjwe' /* Definição */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedicamentos
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedicamentos
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedicamentos
                                                  .fontStyle,
                                        ),
                                  ),
                                  Text(
                                    FFLocalizations.of(context).getVariableText(
                                      ptText: inducao?['ind_definicao'] ??
                                          'Indefinido',
                                      enText: inducao?['definicao_en'] ??
                                          'Indefinido',
                                      esText: inducao?['definicao_es'] ??
                                          'Indefinido',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .infoMedicamentos
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .infoMedicamentos
                                                    .fontStyle,
                                          ),
                                          color: Color(0xFFE2E8F0),
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .infoMedicamentos
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .infoMedicamentos
                                                  .fontStyle,
                                        ),
                                  ),
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'd468ko0d' /* Epidemiologia */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedicamentos
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedicamentos
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedicamentos
                                                  .fontStyle,
                                        ),
                                  ),
                                  Text(
                                    FFLocalizations.of(context).getVariableText(
                                      ptText: inducao?['ind_epidemiologia'] ??
                                          'Indefinido',
                                      enText: inducao?['epidemiologia_en'] ??
                                          'Indefinido',
                                      esText: inducao?['epidemiologia_es'] ??
                                          'Indefinido',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .infoMedicamentos
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .infoMedicamentos
                                                    .fontStyle,
                                          ),
                                          color: Color(0xFFE2E8F0),
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .infoMedicamentos
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .infoMedicamentos
                                                  .fontStyle,
                                        ),
                                  ),
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'lhgz4kwi' /* Fisiopatologia */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedicamentos
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedicamentos
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedicamentos
                                                  .fontStyle,
                                        ),
                                  ),
                                  Text(
                                    FFLocalizations.of(context).getVariableText(
                                      ptText: inducao?['ind_fisiopatologia'] ??
                                          'Indefinido',
                                      enText: inducao?['fisiopatologia_en'] ??
                                          'Indefinido',
                                      esText: inducao?['fisiopatologia_es'] ??
                                          'Indefinido',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .infoMedicamentos
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .infoMedicamentos
                                                    .fontStyle,
                                          ),
                                          color: Color(0xFFE2E8F0),
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .infoMedicamentos
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .infoMedicamentos
                                                  .fontStyle,
                                        ),
                                  ),
                                  if ((containerInducoesSubtopicosRowList
                                          .where((e) =>
                                              e.indTopico ==
                                              'manifestações_clinicas')
                                          .toList()
                                          .isNotEmpty) ==
                                      true)
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'trvs9swa' /* Manifestações clínicas */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedicamentos
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedicamentos
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedicamentos
                                                          .fontStyle,
                                                ),
                                          ),
                                          FutureBuilder<
                                              List<VwInducoesSubtopicosRow>>(
                                            future: _loadSubtopicosByTopico(
                                                'manifestações_clinicas'),
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
                                              List<VwInducoesSubtopicosRow>
                                                  listViewVwInducoesSubtopicosRowList =
                                                  snapshot.data!;

                                              return ListView.builder(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    listViewVwInducoesSubtopicosRowList
                                                        .length,
                                                itemBuilder:
                                                    (context, listViewIndex) {
                                                  final listViewVwInducoesSubtopicosRow =
                                                      listViewVwInducoesSubtopicosRowList[
                                                          listViewIndex];
                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        valueOrDefault<String>(
                                                          listViewVwInducoesSubtopicosRow
                                                              .indTitulos,
                                                          '-',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    15.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getVariableText(
                                                              ptText:
                                                                  listViewVwInducoesSubtopicosRow
                                                                      .conteudosPt,
                                                              enText:
                                                                  listViewVwInducoesSubtopicosRow
                                                                      .conteudosEn,
                                                              esText:
                                                                  listViewVwInducoesSubtopicosRow
                                                                      .conteudosEs,
                                                            ),
                                                            'Indefinido',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ].divide(SizedBox(height: 16.0)),
                                      ),
                                    ),
                                  if ((containerInducoesSubtopicosRowList
                                          .where((e) =>
                                              e.indTopico ==
                                              'sinais_e_sintomas')
                                          .toList()
                                          .isNotEmpty) ==
                                      true)
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'rztpgy1x' /* Sinais e Sintomas */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedicamentos
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedicamentos
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedicamentos
                                                          .fontStyle,
                                                ),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              final sinaisSintomas =
                                                  containerInducoesSubtopicosRowList
                                                      .map((e) => e)
                                                      .toList()
                                                      .where((e) =>
                                                          e.indTopico ==
                                                          'sinais_e_sintomas')
                                                      .toList();

                                              return ListView.builder(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    sinaisSintomas.length,
                                                itemBuilder: (context,
                                                    sinaisSintomasIndex) {
                                                  final sinaisSintomasItem =
                                                      sinaisSintomas[
                                                          sinaisSintomasIndex];
                                                  return Text(
                                                    '• ${valueOrDefault<String>(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getVariableText(
                                                        ptText:
                                                            sinaisSintomasItem
                                                                .indNome,
                                                        enText:
                                                            sinaisSintomasItem
                                                                .indNomeEn,
                                                        esText:
                                                            sinaisSintomasItem
                                                                .indNomeEs,
                                                      ),
                                                      'Indefinido',
                                                    )}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ].divide(SizedBox(height: 16.0)),
                                      ),
                                    ),
                                  if ((containerInducoesSubtopicosRowList
                                          .where((e) =>
                                              e.indTopico == 'causas_comuns')
                                          .toList()
                                          .isNotEmpty) ==
                                      true)
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 15.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'lbavv2ck' /* Causas Comuns */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleMedicamentos
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedicamentos
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedicamentos
                                                            .fontStyle,
                                                  ),
                                            ),
                                            Builder(
                                              builder: (context) {
                                                final sinaisSintomas =
                                                    containerInducoesSubtopicosRowList
                                                        .map((e) => e)
                                                        .toList()
                                                        .where((e) =>
                                                            e.indTopico ==
                                                            'causas_comuns')
                                                        .toList();

                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      sinaisSintomas.length,
                                                  itemBuilder: (context,
                                                      sinaisSintomasIndex) {
                                                    final sinaisSintomasItem =
                                                        sinaisSintomas[
                                                            sinaisSintomasIndex];
                                                    return Text(
                                                      '• ${valueOrDefault<String>(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getVariableText(
                                                          ptText:
                                                              sinaisSintomasItem
                                                                  .indNome,
                                                          enText:
                                                              sinaisSintomasItem
                                                                  .indNomeEn,
                                                          esText:
                                                              sinaisSintomasItem
                                                                  .indNomeEs,
                                                        ),
                                                        'Indefinido',
                                                      )}',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ].divide(SizedBox(height: 16.0)),
                                        ),
                                      ),
                                    ),
                                  if ((containerInducoesSubtopicosRowList
                                          .where((e) =>
                                              e.indTopico ==
                                              'estrategias_anteriores_ao_ato')
                                          .toList()
                                          .isNotEmpty) ==
                                      true)
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 15.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '1a3q7sin' /* Estratégias Anteriores ao Ato */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleMedicamentos
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedicamentos
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedicamentos
                                                            .fontStyle,
                                                  ),
                                            ),
                                            Builder(
                                              builder: (context) {
                                                final sinaisSintomas =
                                                    containerInducoesSubtopicosRowList
                                                        .map((e) => e)
                                                        .toList()
                                                        .where((e) =>
                                                            e.indTopico ==
                                                            'estrategias_anteriores_ao_ato')
                                                        .toList();

                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      sinaisSintomas.length,
                                                  itemBuilder: (context,
                                                      sinaisSintomasIndex) {
                                                    final sinaisSintomasItem =
                                                        sinaisSintomas[
                                                            sinaisSintomasIndex];
                                                    return Text(
                                                      '• ${valueOrDefault<String>(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getVariableText(
                                                          ptText:
                                                              sinaisSintomasItem
                                                                  .indNome,
                                                          enText:
                                                              sinaisSintomasItem
                                                                  .indNomeEn,
                                                          esText:
                                                              sinaisSintomasItem
                                                                  .indNomeEs,
                                                        ),
                                                        'Indefinido',
                                                      )}',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ].divide(SizedBox(height: 16.0)),
                                        ),
                                      ),
                                    ),
                                  if ((containerInducoesSubtopicosRowList
                                          .where((e) =>
                                              e.indTopico ==
                                              'diagnostico_diferencial')
                                          .toList()
                                          .isNotEmpty) ==
                                      true)
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 15.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                't38sf6t6' /* Diagnóstico Diferencial */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleMedicamentos
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedicamentos
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedicamentos
                                                            .fontStyle,
                                                  ),
                                            ),
                                            Builder(
                                              builder: (context) {
                                                final sinaisSintomas =
                                                    containerInducoesSubtopicosRowList
                                                        .map((e) => e)
                                                        .toList()
                                                        .where((e) =>
                                                            e.indTopico ==
                                                            'diagnostico_diferencial')
                                                        .toList();

                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      sinaisSintomas.length,
                                                  itemBuilder: (context,
                                                      sinaisSintomasIndex) {
                                                    final sinaisSintomasItem =
                                                        sinaisSintomas[
                                                            sinaisSintomasIndex];
                                                    return Text(
                                                      '• ${valueOrDefault<String>(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getVariableText(
                                                          ptText:
                                                              sinaisSintomasItem
                                                                  .indNome,
                                                          enText:
                                                              sinaisSintomasItem
                                                                  .indNomeEn,
                                                          esText:
                                                              sinaisSintomasItem
                                                                  .indNomeEs,
                                                        ),
                                                        'Indefinido',
                                                      )}',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ].divide(SizedBox(height: 16.0)),
                                        ),
                                      ),
                                    ),
                                  if ((containerInducoesSubtopicosRowList
                                          .where((e) =>
                                              e.indTopico ==
                                              'medicamentos_mais_usados')
                                          .toList()
                                          .isNotEmpty) ==
                                      true)
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 15.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'djj0oruw' /* Medicamentos Mais Usados */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleMedicamentos
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedicamentos
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedicamentos
                                                            .fontStyle,
                                                  ),
                                            ),
                                            Builder(
                                              builder: (context) {
                                                final sinaisSintomas =
                                                    containerInducoesSubtopicosRowList
                                                        .map((e) => e)
                                                        .toList()
                                                        .where((e) =>
                                                            e.indTopico ==
                                                            'medicamentos_mais_usados')
                                                        .toList();

                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      sinaisSintomas.length,
                                                  itemBuilder: (context,
                                                      sinaisSintomasIndex) {
                                                    final sinaisSintomasItem =
                                                        sinaisSintomas[
                                                            sinaisSintomasIndex];
                                                    return Text(
                                                      '• ${valueOrDefault<String>(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getVariableText(
                                                          ptText:
                                                              sinaisSintomasItem
                                                                  .indNome,
                                                          enText:
                                                              sinaisSintomasItem
                                                                  .indNomeEn,
                                                          esText:
                                                              sinaisSintomasItem
                                                                  .indNomeEs,
                                                        ),
                                                        'Indefinido',
                                                      )}',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ].divide(SizedBox(height: 16.0)),
                                        ),
                                      ),
                                    ),
                                  if ((containerInducoesSubtopicosRowList
                                          .where((e) =>
                                              e.indTopico ==
                                              'cuidados_pos_operatorios')
                                          .toList()
                                          .isNotEmpty) ==
                                      true)
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 15.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'q5hs9f83' /* Cuidados Pós-operatórios */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleMedicamentos
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedicamentos
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedicamentos
                                                            .fontStyle,
                                                  ),
                                            ),
                                            Builder(
                                              builder: (context) {
                                                final sinaisSintomas =
                                                    containerInducoesSubtopicosRowList
                                                        .map((e) => e)
                                                        .toList()
                                                        .where((e) =>
                                                            e.indTopico ==
                                                            'cuidados_pos_operatorios')
                                                        .toList();

                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      sinaisSintomas.length,
                                                  itemBuilder: (context,
                                                      sinaisSintomasIndex) {
                                                    final sinaisSintomasItem =
                                                        sinaisSintomas[
                                                            sinaisSintomasIndex];
                                                    return Text(
                                                      '• ${valueOrDefault<String>(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getVariableText(
                                                          ptText:
                                                              sinaisSintomasItem
                                                                  .indNome,
                                                          enText:
                                                              sinaisSintomasItem
                                                                  .indNomeEn,
                                                          esText:
                                                              sinaisSintomasItem
                                                                  .indNomeEs,
                                                        ),
                                                        'Indefinido',
                                                      )}',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ].divide(SizedBox(height: 16.0)),
                                        ),
                                      ),
                                    ),
                                  if ((containerInducoesSubtopicosRowList
                                          .where((e) =>
                                              e.indTopico ==
                                              'avaliacao_preoperatoria')
                                          .toList()
                                          .isNotEmpty) ==
                                      true)
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 15.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'njghccp5' /* Avaliação Pré-operatória */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleMedicamentos
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedicamentos
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedicamentos
                                                            .fontStyle,
                                                  ),
                                            ),
                                            Builder(
                                              builder: (context) {
                                                final sinaisSintomas =
                                                    containerInducoesSubtopicosRowList
                                                        .map((e) => e)
                                                        .toList()
                                                        .where((e) =>
                                                            e.indTopico ==
                                                            'avaliacao_preoperatoria')
                                                        .toList();

                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      sinaisSintomas.length,
                                                  itemBuilder: (context,
                                                      sinaisSintomasIndex) {
                                                    final sinaisSintomasItem =
                                                        sinaisSintomas[
                                                            sinaisSintomasIndex];
                                                    return Text(
                                                      '• ${valueOrDefault<String>(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getVariableText(
                                                          ptText:
                                                              sinaisSintomasItem
                                                                  .indNome,
                                                          enText:
                                                              sinaisSintomasItem
                                                                  .indNomeEn,
                                                          esText:
                                                              sinaisSintomasItem
                                                                  .indNomeEs,
                                                        ),
                                                        'Indefinido',
                                                      )}',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ].divide(SizedBox(height: 16.0)),
                                        ),
                                      ),
                                    ),
                                  if ((containerInducoesSubtopicosRowList
                                          .where((e) =>
                                              e.indTopico == 'tratamento')
                                          .toList()
                                          .isNotEmpty) ==
                                      true)
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 15.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '4x1thr48' /* Tratamento */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleMedicamentos
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedicamentos
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedicamentos
                                                            .fontStyle,
                                                  ),
                                            ),
                                            Builder(
                                              builder: (context) {
                                                final tratamentos =
                                                    containerInducoesSubtopicosRowList
                                                        .map((e) => e)
                                                        .toList()
                                                        .where((e) =>
                                                            e.indTopico ==
                                                            'tratamento')
                                                        .toList();

                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: tratamentos.length,
                                                  itemBuilder: (context,
                                                      tratamentosIndex) {
                                                    final tratamentosItem =
                                                        tratamentos[
                                                            tratamentosIndex];
                                                    return Text(
                                                      '• ${valueOrDefault<String>(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getVariableText(
                                                          ptText:
                                                              tratamentosItem
                                                                  .indNome,
                                                          enText:
                                                              tratamentosItem
                                                                  .indNomeEn,
                                                          esText:
                                                              tratamentosItem
                                                                  .indNomeEs,
                                                        ),
                                                        'Indefinido',
                                                      )}',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ].divide(SizedBox(height: 16.0)),
                                        ),
                                      ),
                                    ),
                                  if ((containerInducoesSubtopicosRowList
                                          .where((e) =>
                                              e.indTopico == 'diagnostico')
                                          .toList()
                                          .isNotEmpty) ==
                                      true)
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'c93wnsxc' /* Diagnóstico */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedicamentos
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedicamentos
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedicamentos
                                                          .fontStyle,
                                                ),
                                          ),
                                          FutureBuilder<
                                              List<VwInducoesSubtopicosRow>>(
                                            future: _loadSubtopicosByTopico(
                                                'diagnostico'),
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
                                              List<VwInducoesSubtopicosRow>
                                                  listViewVwInducoesSubtopicosRowList =
                                                  snapshot.data!;

                                              return ListView.builder(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    listViewVwInducoesSubtopicosRowList
                                                        .length,
                                                itemBuilder:
                                                    (context, listViewIndex) {
                                                  final listViewVwInducoesSubtopicosRow =
                                                      listViewVwInducoesSubtopicosRowList[
                                                          listViewIndex];
                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        valueOrDefault<String>(
                                                          listViewVwInducoesSubtopicosRow
                                                              .indTitulos,
                                                          '-',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    15.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getVariableText(
                                                              ptText:
                                                                  listViewVwInducoesSubtopicosRow
                                                                      .conteudosPt,
                                                              enText:
                                                                  listViewVwInducoesSubtopicosRow
                                                                      .conteudosEn,
                                                              esText:
                                                                  listViewVwInducoesSubtopicosRow
                                                                      .conteudosEs,
                                                            ),
                                                            'Indefinido',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ].divide(SizedBox(height: 16.0)),
                                      ),
                                    ),
                                  if ((containerInducoesSubtopicosRowList
                                          .where((e) =>
                                              e.indTopico ==
                                              'indicações_para_suporte_ventilatorio')
                                          .toList()
                                          .isNotEmpty) ==
                                      true)
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'a1nwuqcr' /* Indicações para suporte ventil... */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedicamentos
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedicamentos
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedicamentos
                                                          .fontStyle,
                                                ),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              final indicaesparasuporteventilatrio =
                                                  containerInducoesSubtopicosRowList
                                                      .map((e) => e)
                                                      .toList()
                                                      .where((e) =>
                                                          e.indTopico ==
                                                          'indicações_para_suporte_ventilatorio')
                                                      .toList();
                                              if (indicaesparasuporteventilatrio
                                                  .isEmpty) {
                                                return Center(
                                                  child: PEmptyListWidget(),
                                                );
                                              }

                                              return ListView.separated(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    indicaesparasuporteventilatrio
                                                        .length,
                                                separatorBuilder: (_, __) =>
                                                    SizedBox(height: 5.0),
                                                itemBuilder: (context,
                                                    indicaesparasuporteventilatrioIndex) {
                                                  final indicaesparasuporteventilatrioItem =
                                                      indicaesparasuporteventilatrio[
                                                          indicaesparasuporteventilatrioIndex];
                                                  return Text(
                                                    valueOrDefault<String>(
                                                      '• ${valueOrDefault<String>(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getVariableText(
                                                          ptText:
                                                              indicaesparasuporteventilatrioItem
                                                                  .indNome,
                                                          enText:
                                                              indicaesparasuporteventilatrioItem
                                                                  .indNomeEn,
                                                          esText:
                                                              indicaesparasuporteventilatrioItem
                                                                  .indNomeEs,
                                                        ),
                                                        '-',
                                                      )}',
                                                      '-',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ].divide(SizedBox(height: 16.0)),
                                      ),
                                    ),
                                  if ((containerInducoesSubtopicosRowList
                                          .where((e) =>
                                              e.indTopico == 'conduta_geral')
                                          .toList()
                                          .isNotEmpty) ==
                                      true)
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'g7rgr19j' /* Conduta geral */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedicamentos
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedicamentos
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedicamentos
                                                          .fontStyle,
                                                ),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              final condutaGeral =
                                                  containerInducoesSubtopicosRowList
                                                      .map((e) => e)
                                                      .toList()
                                                      .where((e) =>
                                                          e.indTopico ==
                                                          'conduta_geral')
                                                      .toList();
                                              if (condutaGeral.isEmpty) {
                                                return Center(
                                                  child: PEmptyListWidget(),
                                                );
                                              }

                                              return ListView.separated(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: condutaGeral.length,
                                                separatorBuilder: (_, __) =>
                                                    SizedBox(height: 5.0),
                                                itemBuilder: (context,
                                                    condutaGeralIndex) {
                                                  final condutaGeralItem =
                                                      condutaGeral[
                                                          condutaGeralIndex];
                                                  return Text(
                                                    valueOrDefault<String>(
                                                      '• ${valueOrDefault<String>(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getVariableText(
                                                          ptText:
                                                              condutaGeralItem
                                                                  .indNome,
                                                          enText:
                                                              condutaGeralItem
                                                                  .indNomeEn,
                                                          esText:
                                                              condutaGeralItem
                                                                  .indNomeEs,
                                                        ),
                                                        '-',
                                                      )}',
                                                      '-',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ].divide(SizedBox(height: 16.0)),
                                      ),
                                    ),
                                  if ((containerInducoesSubtopicosRowList
                                          .where((e) =>
                                              e.indTopico == 'prognostico')
                                          .toList()
                                          .isNotEmpty) ==
                                      true)
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              '9jdis6ct' /* Prognóstico */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedicamentos
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedicamentos
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedicamentos
                                                          .fontStyle,
                                                ),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              final prognostico =
                                                  containerInducoesSubtopicosRowList
                                                      .map((e) => e)
                                                      .toList()
                                                      .where((e) =>
                                                          e.indTopico ==
                                                          'prognostico')
                                                      .toList();
                                              if (prognostico.isEmpty) {
                                                return Center(
                                                  child: PEmptyListWidget(),
                                                );
                                              }

                                              return ListView.separated(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: prognostico.length,
                                                separatorBuilder: (_, __) =>
                                                    SizedBox(height: 5.0),
                                                itemBuilder: (context,
                                                    prognosticoIndex) {
                                                  final prognosticoItem =
                                                      prognostico[
                                                          prognosticoIndex];
                                                  return Text(
                                                    valueOrDefault<String>(
                                                      '• ${valueOrDefault<String>(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getVariableText(
                                                          ptText:
                                                              prognosticoItem
                                                                  .indNome,
                                                          enText:
                                                              prognosticoItem
                                                                  .indNomeEn,
                                                          esText:
                                                              prognosticoItem
                                                                  .indNomeEs,
                                                        ),
                                                        '-',
                                                      )}',
                                                      '-',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ].divide(SizedBox(height: 16.0)),
                                      ),
                                    ),
                                  if ((containerInducoesSubtopicosRowList
                                          .where((e) =>
                                              e.indTopico ==
                                              'medicamentos_comuns')
                                          .toList()
                                          .isNotEmpty) ==
                                      true)
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'yew5ktsq' /* Medicamentos Comuns */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedicamentos
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedicamentos
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedicamentos
                                                          .fontStyle,
                                                ),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              final medicamentosComuns =
                                                  containerInducoesSubtopicosRowList
                                                      .map((e) => e)
                                                      .toList()
                                                      .where((e) =>
                                                          e.indTopico ==
                                                          'medicamentos_comuns')
                                                      .toList();
                                              if (medicamentosComuns.isEmpty) {
                                                return Center(
                                                  child: PEmptyListWidget(),
                                                );
                                              }

                                              return ListView.separated(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    medicamentosComuns.length,
                                                separatorBuilder: (_, __) =>
                                                    SizedBox(height: 5.0),
                                                itemBuilder: (context,
                                                    medicamentosComunsIndex) {
                                                  final medicamentosComunsItem =
                                                      medicamentosComuns[
                                                          medicamentosComunsIndex];
                                                  return Text(
                                                    '${valueOrDefault<String>(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getVariableText(
                                                        ptText:
                                                            medicamentosComunsItem
                                                                .indNome,
                                                        enText:
                                                            medicamentosComunsItem
                                                                .indNomeEn,
                                                        esText:
                                                            medicamentosComunsItem
                                                                .indNomeEs,
                                                      ),
                                                      '-',
                                                    )}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ].divide(SizedBox(height: 16.0)),
                                      ),
                                    ),
                                  if ((containerInducoesSubtopicosRowList
                                          .where((e) =>
                                              e.indTopico == 'monitorizacao')
                                          .toList()
                                          .isNotEmpty) ==
                                      true)
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              '1y172o1g' /* Monitorização */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedicamentos
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedicamentos
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedicamentos
                                                          .fontStyle,
                                                ),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              final monitorizacao =
                                                  containerInducoesSubtopicosRowList
                                                      .map((e) => e)
                                                      .toList()
                                                      .where((e) =>
                                                          e.indTopico ==
                                                          'monitorizacao')
                                                      .toList();
                                              if (monitorizacao.isEmpty) {
                                                return Center(
                                                  child: PEmptyListWidget(),
                                                );
                                              }

                                              return ListView.separated(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: monitorizacao.length,
                                                separatorBuilder: (_, __) =>
                                                    SizedBox(height: 5.0),
                                                itemBuilder: (context,
                                                    monitorizacaoIndex) {
                                                  final monitorizacaoItem =
                                                      monitorizacao[
                                                          monitorizacaoIndex];
                                                  return Text(
                                                    '• ${valueOrDefault<String>(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getVariableText(
                                                        ptText:
                                                            monitorizacaoItem
                                                                .indNome,
                                                        enText:
                                                            monitorizacaoItem
                                                                .indNomeEn,
                                                        esText:
                                                            monitorizacaoItem
                                                                .indNomeEs,
                                                      ),
                                                      '-',
                                                    )}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ].divide(SizedBox(height: 16.0)),
                                      ),
                                    ),
                                  if ((containerInducoesSubtopicosRowList
                                          .where(
                                              (e) => e.indTopico == 'cuidados')
                                          .toList()
                                          .isNotEmpty) ==
                                      true)
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'uhfhbt3r' /* Cuidados */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedicamentos
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedicamentos
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedicamentos
                                                          .fontStyle,
                                                ),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              final cuidados =
                                                  containerInducoesSubtopicosRowList
                                                      .map((e) => e)
                                                      .toList()
                                                      .where((e) =>
                                                          e.indTopico ==
                                                          'cuidados')
                                                      .toList();
                                              if (cuidados.isEmpty) {
                                                return Center(
                                                  child: PEmptyListWidget(),
                                                );
                                              }

                                              return ListView.separated(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: cuidados.length,
                                                separatorBuilder: (_, __) =>
                                                    SizedBox(height: 5.0),
                                                itemBuilder:
                                                    (context, cuidadosIndex) {
                                                  final cuidadosItem =
                                                      cuidados[cuidadosIndex];
                                                  return Text(
                                                    '• ${valueOrDefault<String>(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getVariableText(
                                                        ptText: cuidadosItem
                                                            .indNome,
                                                        enText: cuidadosItem
                                                            .indNomeEn,
                                                        esText: cuidadosItem
                                                            .indNomeEs,
                                                      ),
                                                      '-',
                                                    )}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ].divide(SizedBox(height: 16.0)),
                                      ),
                                    ),
                                  if ((containerInducoesSubtopicosRowList
                                          .where((e) =>
                                              e.indTopico == 'contraindicacoes')
                                          .toList()
                                          .isNotEmpty) ==
                                      true)
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              '87f9af8s' /* Contra Indicações */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedicamentos
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedicamentos
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedicamentos
                                                          .fontStyle,
                                                ),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              final contraindicacoes =
                                                  containerInducoesSubtopicosRowList
                                                      .map((e) => e)
                                                      .toList()
                                                      .where((e) =>
                                                          e.indTopico ==
                                                          'contraindicacoes')
                                                      .toList();
                                              if (contraindicacoes.isEmpty) {
                                                return Center(
                                                  child: PEmptyListWidget(),
                                                );
                                              }

                                              return ListView.separated(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    contraindicacoes.length,
                                                separatorBuilder: (_, __) =>
                                                    SizedBox(height: 5.0),
                                                itemBuilder: (context,
                                                    contraindicacoesIndex) {
                                                  final contraindicacoesItem =
                                                      contraindicacoes[
                                                          contraindicacoesIndex];
                                                  return Text(
                                                    '• ${valueOrDefault<String>(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getVariableText(
                                                        ptText:
                                                            contraindicacoesItem
                                                                .indNome,
                                                        enText:
                                                            contraindicacoesItem
                                                                .indNomeEn,
                                                        esText:
                                                            contraindicacoesItem
                                                                .indNomeEs,
                                                      ),
                                                      '-',
                                                    )}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ].divide(SizedBox(height: 16.0)),
                                      ),
                                    ),
                                  if ((containerInducoesSubtopicosRowList
                                          .where((e) =>
                                              e.indTopico == 'notas_adicionais')
                                          .toList()
                                          .isNotEmpty) ==
                                      true)
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              '7phop7fv' /* Notas adicionais */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedicamentos
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedicamentos
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedicamentos
                                                          .fontStyle,
                                                ),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              final notasAdicionais =
                                                  containerInducoesSubtopicosRowList
                                                      .map((e) => e)
                                                      .toList()
                                                      .where((e) =>
                                                          e.indTopico ==
                                                          'notas_adicionais')
                                                      .toList();
                                              if (notasAdicionais.isEmpty) {
                                                return Center(
                                                  child: PEmptyListWidget(),
                                                );
                                              }

                                              return ListView.separated(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    notasAdicionais.length,
                                                separatorBuilder: (_, __) =>
                                                    SizedBox(height: 5.0),
                                                itemBuilder: (context,
                                                    notasAdicionaisIndex) {
                                                  final notasAdicionaisItem =
                                                      notasAdicionais[
                                                          notasAdicionaisIndex];
                                                  return Text(
                                                    '• ${valueOrDefault<String>(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getVariableText(
                                                        ptText:
                                                            notasAdicionaisItem
                                                                .indNome,
                                                        enText:
                                                            notasAdicionaisItem
                                                                .indNomeEn,
                                                        esText:
                                                            notasAdicionaisItem
                                                                .indNomeEs,
                                                      ),
                                                      '-',
                                                    )}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ].divide(SizedBox(height: 16.0)),
                                      ),
                                    ),
                                  if ((containerInducoesSubtopicosRowList
                                          .where((e) =>
                                              e.indTopico ==
                                              'fontes_bibliograficas')
                                          .toList()
                                          .isNotEmpty) ==
                                      true)
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              '12e8pzce' /* Bibliografia */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedicamentos
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedicamentos
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedicamentos
                                                          .fontStyle,
                                                ),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              final bibliografia =
                                                  containerInducoesSubtopicosRowList
                                                      .map((e) => e)
                                                      .toList()
                                                      .where((e) =>
                                                          e.indTopico ==
                                                          'fontes_bibliograficas')
                                                      .toList();
                                              if (bibliografia.isEmpty) {
                                                return Center(
                                                  child: PEmptyListWidget(),
                                                );
                                              }

                                              return ListView.separated(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: bibliografia.length,
                                                separatorBuilder: (_, __) =>
                                                    SizedBox(height: 5.0),
                                                itemBuilder: (context,
                                                    bibliografiaIndex) {
                                                  final bibliografiaItem =
                                                      bibliografia[
                                                          bibliografiaIndex];
                                                  return Text(
                                                    '• ${valueOrDefault<String>(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getVariableText(
                                                        ptText: valueOrDefault<
                                                            String>(
                                                          bibliografiaItem
                                                              .indNome,
                                                          'Indefinido',
                                                        ),
                                                        enText: valueOrDefault<
                                                            String>(
                                                          bibliografiaItem
                                                              .indNomeEn,
                                                          'Indefinido',
                                                        ),
                                                        esText: valueOrDefault<
                                                            String>(
                                                          bibliografiaItem
                                                              .indNomeEs,
                                                          'Indefinido',
                                                        ),
                                                      ),
                                                      '-',
                                                    )}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ].divide(SizedBox(height: 16.0)),
                                      ),
                                    ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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

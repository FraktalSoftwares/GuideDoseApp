import '/backend/supabase/supabase.dart';
import '/backend/offline/sync_manager.dart';
import '/backend/offline/offline_database.dart';
import '/components/p_empty_list/p_empty_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'p_accordeon_inducao_model.dart';
export 'p_accordeon_inducao_model.dart';

class PAccordeonInducaoWidget extends StatefulWidget {
  const PAccordeonInducaoWidget({
    super.key,
    this.idInducao,
  });

  final int? idInducao;

  @override
  State<PAccordeonInducaoWidget> createState() =>
      _PAccordeonInducaoWidgetState();
}

class _PAccordeonInducaoWidgetState extends State<PAccordeonInducaoWidget> {
  late PAccordeonInducaoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PAccordeonInducaoModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  // Método helper para carregar dados do accordion (online ou offline)
  Future<List<Map<String, dynamic>>> _loadAccordeonData() async {
    print(
        '🔍 ACCORDION: Iniciando carregamento para indução ${widget.idInducao}');
    final syncManager = SyncManager.instance;
    print('📡 ACCORDION: Status online: ${syncManager.isOnline}');

    if (syncManager.isOnline) {
      try {
        print('🌐 ACCORDION: Buscando online para indução ${widget.idInducao}');
        final rows = await AccordeonInducaoTable().queryRows(
          queryFn: (q) => q.eqOrNull('inducao_id', widget.idInducao),
        );

        print('✅ ACCORDION: Encontrados ${rows.length} itens online');
        if (rows.isNotEmpty) {
          print('📋 ACCORDION: Primeiro item: ${rows.first.medNome}');
        }

        // Converte AccordeonInducaoRow para Map
        final allItems = rows
            .map((row) => {
                  'med_nome': row.medNome,
                  'med_nome_en': row.medNomeEn,
                  'med_nome_es': row.medNomeEs,
                  'dose_mg_kg': row.doseMgKg,
                  'concentracao_mg_ml': row.concentracaoMgMl,
                })
            .toList();

        // Remove duplicatas baseado no nome do medicamento
        final uniqueItems = <String, Map<String, dynamic>>{};
        for (var item in allItems) {
          final key = '${item['med_nome']}_${item['dose_mg_kg']}';
          if (!uniqueItems.containsKey(key)) {
            uniqueItems[key] = item;
          }
        }

        final result = uniqueItems.values.toList();
        print(
            '🎯 ACCORDION: Retornando ${result.length} itens (${allItems.length} antes de remover duplicatas)');
        return result;
      } catch (e) {
        print('❌ ACCORDION: Erro ao buscar online: $e');
        return [];
      }
    }

    // Offline: busca do cache
    try {
      print('💾 ACCORDION: Buscando do cache para indução ${widget.idInducao}');
      final cached = await OfflineDatabase.instance
          .getAccordeonByInducaoId(widget.idInducao!);
      print('✅ ACCORDION: Encontrados ${cached.length} itens no cache');
      if (cached.isNotEmpty) {
        print('📋 ACCORDION: Primeiro item: ${cached.first['med_nome']}');
      }

      // Remove duplicatas baseado no nome do medicamento
      final uniqueItems = <String, Map<String, dynamic>>{};
      for (var item in cached) {
        final key = '${item['med_nome']}_${item['dose_mg_kg']}';
        if (!uniqueItems.containsKey(key)) {
          uniqueItems[key] = item;
        }
      }

      final result = uniqueItems.values.toList();
      print('🎯 ACCORDION: Após remover duplicatas: ${result.length} itens');
      return result;
    } catch (e) {
      print('❌ ACCORDION: Erro ao buscar do cache: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _loadAccordeonData(),
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
        List<Map<String, dynamic>> containerAccordeonInducaoRowList =
            snapshot.data!;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    FFLocalizations.of(context).getText(
                      'dmpev9uc' /* Medicamento */,
                    ),
                    style: FlutterFlowTheme.of(context).textAuth.override(
                          font: GoogleFonts.roboto(
                            fontWeight: FontWeight.normal,
                            fontStyle:
                                FlutterFlowTheme.of(context).textAuth.fontStyle,
                          ),
                          color: Color(0xFFB1BDCD),
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                          fontStyle:
                              FlutterFlowTheme.of(context).textAuth.fontStyle,
                        ),
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'fpv73ho7' /* Dose / Volume */,
                    ),
                    style: FlutterFlowTheme.of(context).textAuth.override(
                          font: GoogleFonts.roboto(
                            fontWeight: FontWeight.normal,
                            fontStyle:
                                FlutterFlowTheme.of(context).textAuth.fontStyle,
                          ),
                          color: Color(0xFFB1BDCD),
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                          fontStyle:
                              FlutterFlowTheme.of(context).textAuth.fontStyle,
                        ),
                  ),
                ],
              ),
              Builder(
                builder: (context) {
                  final remedios =
                      containerAccordeonInducaoRowList.map((e) => e).toList();
                  if (remedios.isEmpty) {
                    return Center(
                      child: PEmptyListWidget(),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: remedios.length,
                    itemBuilder: (context, remediosIndex) {
                      final remediosItem = remedios[remediosIndex];
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            valueOrDefault<String>(
                              FFLocalizations.of(context).getVariableText(
                                ptText: remediosItem['med_nome'] ?? '',
                                enText: remediosItem['med_nome_en'] ?? '',
                                esText: remediosItem['med_nome_es'] ?? '',
                              ),
                              '-',
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
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .fontStyle,
                                ),
                          ),
                          Flexible(
                            child: Text(
                              valueOrDefault<String>(
                                '${functions.calcularDoseMg(FFAppState().User.uSRKGs, remediosItem['dose_mg_kg'] ?? 0.0)} / ${functions.calcularVolumeMlComPeso(remediosItem['dose_mg_kg'] ?? 0.0, remediosItem['concentracao_mg_ml'] ?? 0.0, FFAppState().User.uSRKGs)}',
                                '-',
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
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
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
            ].divide(SizedBox(height: 8.0)),
          ),
        );
      },
    );
  }
}

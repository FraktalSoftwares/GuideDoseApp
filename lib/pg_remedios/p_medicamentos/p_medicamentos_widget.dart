import '/backend/supabase/supabase.dart';
import '/backend/offline/sync_manager.dart';
import '/backend/offline/offline_database.dart';
import '/backend/offline/offline_helper.dart';
import '/components/p_empty/p_empty_widget.dart';
import '/components/offline_indicator/offline_indicator_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pg_remedios/icon_fav/icon_fav_widget.dart';
import '/pg_remedios/p_accordeon_medicamento/p_accordeon_medicamento_widget.dart';
import '/pg_remedios/p_detalhe_medicamento/p_detalhe_medicamento_widget.dart';
import 'dart:ui';
import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'p_medicamentos_model.dart';
export 'p_medicamentos_model.dart';

class PMedicamentosWidget extends StatefulWidget {
  const PMedicamentosWidget({super.key});

  @override
  State<PMedicamentosWidget> createState() => _PMedicamentosWidgetState();
}

class _PMedicamentosWidgetState extends State<PMedicamentosWidget> {
  late PMedicamentosModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PMedicamentosModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  Future<List<Map<String, dynamic>>> _loadMedicamentos() async {
    final syncManager = SyncManager.instance;
    final searchText = _model.textController.text.toLowerCase();

    if (syncManager.isOnline) {
      // Online: busca do Supabase
      try {
        final rows = await VwMedicamentosOrdernadosTable().queryRows(
          queryFn: (q) => q
              .ilike('nome_chave', '%$searchText%')
              .order('favorito_flag')
              .order('nome_chave', ascending: true),
        );
        // Converte Row para Map
        return rows
            .map((r) => {
                  'remote_id': r.id,
                  'nome': r.ptNomePrincipioAtivo,
                  'nome_en': r.usNomePrincipioAtivo,
                  'nome_es': r.esNomePrincipioAtivo,
                  'is_favorite': (r.favoritoFlag == true) ? 1 : 0,
                })
            .toList();
      } catch (e) {
        print('Erro ao buscar medicamentos online: $e');
        // Se falhar online, tenta offline
        return await OfflineDatabase.instance.getAllMedicamentos();
      }
    } else {
      // Offline: busca do cache local
      final allMeds = await OfflineDatabase.instance.getAllMedicamentos();

      // Filtra por busca se houver texto
      if (searchText.isEmpty) {
        return allMeds;
      }

      return allMeds.where((med) {
        final nome = (med['nome'] ?? '').toString().toLowerCase();
        return nome.contains(searchText);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _loadMedicamentos(),
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
        List<Map<String, dynamic>> medicamentosList = snapshot.data!;

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              OfflineIndicatorWidget(),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: _model.textController,
                    focusNode: _model.textFieldFocusNode,
                    onChanged: (_) => EasyDebounce.debounce(
                      '_model.textController',
                      Duration(milliseconds: 2000),
                      () async {
                        safeSetState(() {});
                      },
                    ),
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                      isDense: true,
                      labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                color: Color(0xFFCBD5E1),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                      hintText: FFLocalizations.of(context).getText(
                        '7oed41mu' /* Pesquisar remédios */,
                      ),
                      hintStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                color: Color(0xFFCBD5E1),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF3C4F67),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primaryText,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      filled: true,
                      fillColor: Color(0xFF2C3744),
                      contentPadding: EdgeInsetsDirectional.fromSTEB(
                          16.0, 16.0, 16.0, 16.0),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                    cursorColor: FlutterFlowTheme.of(context).primaryText,
                    enableInteractiveSelection: true,
                    validator:
                        _model.textControllerValidator.asValidator(context),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                  child: Builder(
                    builder: (context) {
                      final remedios = medicamentosList;
                      if (remedios.isEmpty) {
                        return Container(
                          width: 250.0,
                          height: 270.0,
                          child: PEmptyWidget(),
                        );
                      }

                      return RefreshIndicator(
                        color: Color(0xFF3C4F67),
                        backgroundColor: Color(0xFF14181B),
                        onRefresh: () async {
                          // Força sincronização quando puxa para atualizar
                          await SyncManager.instance.syncData();
                          safeSetState(() {});
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: remedios.length,
                          itemBuilder: (context, remediosIndex) {
                            final remediosItem = remedios[remediosIndex];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 16.0, 16.0, 0.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFF3C4F67),
                                  borderRadius: BorderRadius.circular(16.0),
                                  border: Border.all(
                                    color: Color(0xFF456A92),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              valueOrDefault<String>(
                                                FFLocalizations.of(context)
                                                    .getVariableText(
                                                  ptText: remediosItem['nome'],
                                                  enText:
                                                      remediosItem['nome_en'],
                                                  esText:
                                                      remediosItem['nome_es'],
                                                ),
                                                'Indefinido',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                            ),
                                          ),
                                          wrapWithModel(
                                            model:
                                                _model.iconFavModels.getModel(
                                              remediosItem['remote_id']
                                                  .toString(),
                                              remediosIndex,
                                            ),
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            updateOnChange: true,
                                            child: IconFavWidget(
                                              key: Key(
                                                'Keysz4_${remediosItem['remote_id'].toString()}',
                                              ),
                                              medID: remediosItem['remote_id'],
                                              onFavChanged: () async {
                                                safeSetState(() {});
                                              },
                                            ),
                                          ),
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                enableDrag: false,
                                                context: context,
                                                builder: (context) {
                                                  return Padding(
                                                    padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                    child:
                                                        PDetalheMedicamentoWidget(
                                                      id: remediosItem[
                                                          'remote_id'],
                                                    ),
                                                  );
                                                },
                                              ).then((value) async {
                                                safeSetState(() => _model
                                                    .requestCompleter = null);
                                                await _model
                                                    .waitForRequestCompleted();
                                              });
                                            },
                                            child: Icon(
                                              Icons.info_outline,
                                              color: Color(0xFFD5DDE7),
                                              size: 24.0,
                                            ),
                                          ),
                                          if (_model.accordeonVisivel !=
                                              remediosItem['remote_id'])
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                _model.accordeonVisivel =
                                                    remediosItem['remote_id'];
                                                safeSetState(() {});
                                              },
                                              child: Icon(
                                                Icons.arrow_drop_up,
                                                color: Color(0xFFD5DDE7),
                                                size: 24.0,
                                              ),
                                            ),
                                          if (_model.accordeonVisivel ==
                                              remediosItem['remote_id'])
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                _model.accordeonVisivel = null;
                                                safeSetState(() {});
                                              },
                                              child: Icon(
                                                Icons.arrow_drop_down,
                                                color: Color(0xFFD5DDE7),
                                                size: 24.0,
                                              ),
                                            ),
                                        ].divide(SizedBox(width: 8.0)),
                                      ),
                                      if (_model.accordeonVisivel ==
                                          remediosItem['remote_id'])
                                        wrapWithModel(
                                          model: _model
                                              .pAccordeonMedicamentoModels
                                              .getModel(
                                            remediosItem['remote_id']
                                                .toString(),
                                            remediosIndex,
                                          ),
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: PAccordeonMedicamentoWidget(
                                            key: Key(
                                              'Key6i0_${remediosItem['remote_id'].toString()}',
                                            ),
                                            id: remediosItem['remote_id'],
                                          ),
                                        ),
                                    ].divide(SizedBox(height: 8.0)),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ].divide(SizedBox(height: 12.0)),
          ),
        );
      },
    );
  }
}

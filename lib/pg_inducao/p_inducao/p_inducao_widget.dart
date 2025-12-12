import '/backend/supabase/supabase.dart';
import '/backend/offline/sync_manager.dart';
import '/backend/offline/offline_database.dart';
import '/components/p_empty/p_empty_widget.dart';
import '/components/offline_indicator/offline_indicator_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pg_inducao/icon_fav_inducao/icon_fav_inducao_widget.dart';
import '/pg_inducao/p_accordeon_inducao/p_accordeon_inducao_widget.dart';
import '/pg_inducao/p_detalhe_inducao/p_detalhe_inducao_widget.dart';
import 'dart:ui';
import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'p_inducao_model.dart';
export 'p_inducao_model.dart';

class PInducaoWidget extends StatefulWidget {
  const PInducaoWidget({super.key});

  @override
  State<PInducaoWidget> createState() => _PInducaoWidgetState();
}

class _PInducaoWidgetState extends State<PInducaoWidget> {
  late PInducaoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PInducaoModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<VwInducoesOrdenadasRow>>(
      future:
          (_model.requestCompleter ??= Completer<List<VwInducoesOrdenadasRow>>()
                ..complete(VwInducoesOrdenadasTable().queryRows(
                  queryFn: (q) => q
                      .ilike(
                        'ind_nome',
                        '%${_model.textController.text}%',
                      )
                      .order('favorito_flag')
                      .order('ind_nome', ascending: true),
                )))
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
        List<VwInducoesOrdenadasRow> containerVwInducoesOrdenadasRowList =
            snapshot.data!;

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
                        safeSetState(() => _model.requestCompleter = null);
                        await _model.waitForRequestCompleted();
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
                        '28yxphn6' /* Pesquisar condição clínica */,
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
                      final inducao = containerVwInducoesOrdenadasRowList
                          .map((e) => e)
                          .toList();
                      if (inducao.isEmpty) {
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
                          safeSetState(() => _model.requestCompleter = null);
                          await _model.waitForRequestCompleted();
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: inducao.length,
                          itemBuilder: (context, inducaoIndex) {
                            final inducaoItem = inducao[inducaoIndex];
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                  ptText: inducaoItem.indNome,
                                                  enText: inducaoItem.indNomeEn,
                                                  esText: inducaoItem.indNomeEs,
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
                                            model: _model.iconFavInducaoModels
                                                .getModel(
                                              inducaoItem.id!.toString(),
                                              inducaoIndex,
                                            ),
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: IconFavInducaoWidget(
                                              key: Key(
                                                'Keyoy3_${inducaoItem.id!.toString()}',
                                              ),
                                              inducaoID: inducaoItem.id!,
                                              onFavChanged: () async {
                                                safeSetState(() => _model
                                                    .requestCompleter = null);
                                                await _model
                                                    .waitForRequestCompleted();
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
                                                        PDetalheInducaoWidget(
                                                      id: inducaoItem.id!,
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
                                              inducaoItem.id)
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                _model.accordeonVisivel =
                                                    inducaoItem.id;
                                                safeSetState(() {});
                                              },
                                              child: Icon(
                                                Icons.arrow_drop_up,
                                                color: Color(0xFFD5DDE7),
                                                size: 24.0,
                                              ),
                                            ),
                                          if (_model.accordeonVisivel ==
                                              inducaoItem.id)
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
                                          inducaoItem.id)
                                        wrapWithModel(
                                          model: _model.pAccordeonInducaoModels
                                              .getModel(
                                            inducaoItem.id!.toString(),
                                            inducaoIndex,
                                          ),
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: PAccordeonInducaoWidget(
                                            key: Key(
                                              'Keyg09_${inducaoItem.id!.toString()}',
                                            ),
                                            idInducao: inducaoItem.id,
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

import '/backend/supabase/supabase.dart';
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MedicamentosRow>>(
      future: MedicamentosTable().querySingleRow(
        queryFn: (q) => q.eqOrNull(
          'id',
          widget!.id,
        ),
      ),
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
        List<MedicamentosRow> containerMedicamentosRowList = snapshot.data!;

        final containerMedicamentosRow = containerMedicamentosRowList.isNotEmpty
            ? containerMedicamentosRowList.first
            : null;

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
                                ptText: containerMedicamentosRow
                                    ?.ptNomePrincipioAtivo,
                                enText: containerMedicamentosRow
                                    ?.usNomePrincipioAtivo,
                                esText: containerMedicamentosRow
                                    ?.esNomePrincipioAtivo,
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
                                ptText: containerMedicamentosRow
                                    ?.ptNomePrincipioAtivo,
                                enText: containerMedicamentosRow
                                    ?.usNomePrincipioAtivo,
                                esText: containerMedicamentosRow
                                    ?.esNomePrincipioAtivo,
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
                                ptText:
                                    containerMedicamentosRow?.ptNomeComercial,
                                enText:
                                    containerMedicamentosRow?.usNomeComercial,
                                esText:
                                    containerMedicamentosRow?.esNomeComercial,
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
                                ptText:
                                    containerMedicamentosRow?.ptClassificacao,
                                enText:
                                    containerMedicamentosRow?.usClassificacao,
                                esText:
                                    containerMedicamentosRow?.esClassificacao,
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
                                ptText:
                                    containerMedicamentosRow?.ptMecanismoAcao,
                                enText:
                                    containerMedicamentosRow?.usMecanismoAcao,
                                esText:
                                    containerMedicamentosRow?.esMecanismoAcao,
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
                                ptText:
                                    containerMedicamentosRow?.ptFarmacocinetica,
                                enText:
                                    containerMedicamentosRow?.usFarmacocinetica,
                                esText:
                                    containerMedicamentosRow?.esFarmacocinetica,
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
                                ptText: containerMedicamentosRow?.ptIndicacoes,
                                enText: containerMedicamentosRow?.usIndicacoes,
                                esText: containerMedicamentosRow?.esIndicacoes,
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
                                ptText: containerMedicamentosRow?.ptPosologia,
                                enText: containerMedicamentosRow?.usPosologia,
                                esText: containerMedicamentosRow?.esPosologia,
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
                                ptText:
                                    containerMedicamentosRow?.ptAdministracao,
                                enText:
                                    containerMedicamentosRow?.usAdministracao,
                                esText:
                                    containerMedicamentosRow?.esAdministracao,
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
                                    ptText:
                                        containerMedicamentosRow?.ptDoseMaxima,
                                    enText:
                                        containerMedicamentosRow?.usDoseMaxima,
                                    esText:
                                        containerMedicamentosRow?.esDoseMaxima,
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
                                    ptText:
                                        containerMedicamentosRow?.ptDoseMinima,
                                    enText:
                                        containerMedicamentosRow?.usDoseMinima,
                                    esText:
                                        containerMedicamentosRow?.esDoseMinima,
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
                                    ptText: containerMedicamentosRow
                                        ?.ptReacoesAdversas,
                                    enText: containerMedicamentosRow
                                        ?.usReacoesAdversas,
                                    esText: containerMedicamentosRow
                                        ?.esReacoesAdversas,
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
                                    ptText: containerMedicamentosRow
                                        ?.ptRiscoGravidez,
                                    enText: containerMedicamentosRow
                                        ?.usRiscoGravidez,
                                    esText: containerMedicamentosRow
                                        ?.esRiscoGravidez,
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
                                    ptText: containerMedicamentosRow
                                        ?.ptRiscoLactacao,
                                    enText: containerMedicamentosRow
                                        ?.usRiscoLactacao,
                                    esText: containerMedicamentosRow
                                        ?.esRiscoLactacao,
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
                                    ptText:
                                        containerMedicamentosRow?.ptAjusteRenal,
                                    enText:
                                        containerMedicamentosRow?.usAjusteRenal,
                                    esText:
                                        containerMedicamentosRow?.esAjusteRenal,
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
                                    ptText: containerMedicamentosRow
                                        ?.ptAjusteHepatico,
                                    enText: containerMedicamentosRow
                                        ?.usAjusteHepatico,
                                    esText: containerMedicamentosRow
                                        ?.esAjusteHepatico,
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
                                    ptText: containerMedicamentosRow
                                        ?.ptContraindicacoes,
                                    enText: containerMedicamentosRow
                                        ?.usContraindicacoes,
                                    esText: containerMedicamentosRow
                                        ?.esContraindicacoes,
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
                                    ptText: containerMedicamentosRow
                                        ?.ptInteracaoMedicamento,
                                    enText: containerMedicamentosRow
                                        ?.usInteracaoMedicamento,
                                    esText: containerMedicamentosRow
                                        ?.esInteracaoMedicamento,
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
                                    ptText: containerMedicamentosRow
                                        ?.ptApresentacao,
                                    enText: containerMedicamentosRow
                                        ?.usApresentacao,
                                    esText: containerMedicamentosRow
                                        ?.esApresentacao,
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
                                    ptText: containerMedicamentosRow?.ptPreparo,
                                    enText: containerMedicamentosRow?.usPreparo,
                                    esText: containerMedicamentosRow?.esPreparo,
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
                                    ptText: containerMedicamentosRow
                                        ?.ptSolucoesCompativeis,
                                    enText: containerMedicamentosRow
                                        ?.usSolucoesCompativeis,
                                    esText: containerMedicamentosRow
                                        ?.esSolucoesCompativeis,
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
                                    ptText: containerMedicamentosRow
                                        ?.ptArmazenamento,
                                    enText: containerMedicamentosRow
                                        ?.usArmazenamento,
                                    esText: containerMedicamentosRow
                                        ?.esArmazenamento,
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
                                    ptText: containerMedicamentosRow
                                        ?.ptCuidadosMedicos,
                                    enText: containerMedicamentosRow
                                        ?.usCuidadosMedicos,
                                    esText: containerMedicamentosRow
                                        ?.esCuidadosMedicos,
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
                                    ptText: containerMedicamentosRow
                                        ?.ptCuidadosFarmaceuticos,
                                    enText: containerMedicamentosRow
                                        ?.usCuidadosFarmaceuticos,
                                    esText: containerMedicamentosRow
                                        ?.esCuidadosFarmaceuticos,
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
                                    ptText: containerMedicamentosRow
                                        ?.ptCuidadosEnfermagem,
                                    enText: containerMedicamentosRow
                                        ?.usCuidadosEnfermagem,
                                    esText: containerMedicamentosRow
                                        ?.esCuidadosEnfermagem,
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
                                    ptText:
                                        containerMedicamentosRow?.ptInicioAcao,
                                    enText:
                                        containerMedicamentosRow?.usInicioAcao,
                                    esText:
                                        containerMedicamentosRow?.esInicioAcao,
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
                                    ptText:
                                        containerMedicamentosRow?.ptTempoPico,
                                    enText:
                                        containerMedicamentosRow?.usTempoPico,
                                    esText:
                                        containerMedicamentosRow?.esTempoPico,
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
                                    ptText:
                                        containerMedicamentosRow?.ptMeiaVida,
                                    enText:
                                        containerMedicamentosRow?.usMeiaVida,
                                    esText:
                                        containerMedicamentosRow?.esMeiaVida,
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
                                    ptText: containerMedicamentosRow
                                        ?.ptEfeitoClinico,
                                    enText: containerMedicamentosRow
                                        ?.usEfeitoClinico,
                                    esText: containerMedicamentosRow
                                        ?.esEfeitoClinico,
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
                                    ptText: containerMedicamentosRow
                                        ?.ptViaEliminacao,
                                    enText: containerMedicamentosRow
                                        ?.usViaEliminacao,
                                    esText: containerMedicamentosRow
                                        ?.esViaEliminacao,
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
                                    ptText: containerMedicamentosRow
                                        ?.ptEstabilidadePosDiluicao,
                                    enText: containerMedicamentosRow
                                        ?.usEstabilidadePosDiluicao,
                                    esText: containerMedicamentosRow
                                        ?.esEstabilidadePosDiluicao,
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
                                    ptText: containerMedicamentosRow
                                        ?.ptPrecaucoesEspecificas,
                                    enText: containerMedicamentosRow
                                        ?.usPrecaucoesEspecificas,
                                    esText: containerMedicamentosRow
                                        ?.esPrecaucoesEspecificas,
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
                                    ptText: containerMedicamentosRow
                                        ?.ptFontesBibliograficas,
                                    enText: containerMedicamentosRow
                                        ?.usFontesBibliograficas,
                                    esText: containerMedicamentosRow
                                        ?.esFontesBibliograficas,
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

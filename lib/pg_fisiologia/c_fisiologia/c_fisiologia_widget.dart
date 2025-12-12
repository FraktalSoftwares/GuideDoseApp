import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'c_fisiologia_model.dart';
export 'c_fisiologia_model.dart';

class CFisiologiaWidget extends StatefulWidget {
  const CFisiologiaWidget({super.key});

  @override
  State<CFisiologiaWidget> createState() => _CFisiologiaWidgetState();
}

class _CFisiologiaWidgetState extends State<CFisiologiaWidget> {
  late CFisiologiaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CFisiologiaModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF334155),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: Color(0xFF456A92),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'xt5gxa26' /* Dados Antropométricos */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '1ya4snte' /* Peso Ideal */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.avaliarPesoIdeal(
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.uSRKGs,
                                      false)
                                  : functions.avaliarPesoIdeal(
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.uSRKGs,
                                      true),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'so17t0z5' /* Superfície Corporal Ajustada */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularSuperficieCorporal(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false)
                                  : functions.calcularSuperficieCorporal(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'keij7ic5' /* Peso Corrigido */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularPesoCorrigido(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false)
                                  : functions.calcularPesoCorrigido(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'kbknocq6' /* IMC */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularIMC(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      false)
                                  : functions.calcularIMC(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      true),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '4kfqwvg9' /* Percentual em relação ao peso ... */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularPercentualPesoIdeal(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false)
                                  : functions.calcularPercentualPesoIdeal(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'lk8l52z4' /* Peso em relação à altura */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularPesoParaAltura(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false)
                                  : functions.calcularPesoParaAltura(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'tmyccfn7' /* Peso esperado */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularPesoEsperado(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false)
                                  : functions.calcularPesoEsperado(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'zs4h7uhq' /* Altura esperada */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularAlturaEsperada(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false)
                                  : functions.calcularAlturaEsperada(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '058rve72' /* IMC esperado */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              functions
                                  .calcularIMCEsperado(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false)
                                  .toString(),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                    ].divide(SizedBox(height: 8.0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF334155),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: Color(0xFF456A92),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'f0mui9wj' /* Parâmetros Circulatórios */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'fc53s3y8' /* Frequência cardíaca */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions
                                      .calcularFrequenciaCardiacaEsperada(
                                          FFAppState().User.uSRKGs,
                                          FFAppState().User.usrAltura,
                                          FFAppState().User.usrIdade,
                                          FFAppState().User.usrGenero,
                                          false)
                                  : functions
                                      .calcularFrequenciaCardiacaEsperada(
                                          FFAppState().User.uSRKGs,
                                          FFAppState().User.usrAltura,
                                          FFAppState().User.usrIdade,
                                          FFAppState().User.usrGenero,
                                          true),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'nkbo77w8' /* Pressão arterial */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularPressaoArterialEsperada(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false)
                                  : functions.calcularPressaoArterialEsperada(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'bu60ko5x' /* Volume plasmático */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularVolumePlasmatico(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false)
                                  : functions.calcularVolumePlasmatico(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'z6ar8ght' /* Volume diário de infusão */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularVolumeDiarioInfusao(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false)
                                  : functions.calcularVolumeDiarioInfusao(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'i3fo2wjw' /* Tempo de reperfusão capilar */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              functions.calcularTempoReperfusaoCapilar(
                                  FFAppState().User.uSRKGs,
                                  FFAppState().User.usrAltura,
                                  FFAppState().User.usrIdade,
                                  FFAppState().User.usrGenero,
                                  FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                    ].divide(SizedBox(height: 8.0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF334155),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: Color(0xFF456A92),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'f1cctf0z' /* Parâmetros Ventilatórios */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'fp360dqd' /* Máscara facial */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              functions.calcularMascaraFacialEsperada(
                                  FFAppState().User.uSRKGs,
                                  FFAppState().User.usrAltura,
                                  FFAppState().User.usrIdade,
                                  FFAppState().User.usrGenero,
                                  FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'jxc2psgz' /* Cânula orofaríngea */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularCanulaOrofaringeaEsperada(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularCanulaOrofaringeaEsperada(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'r2sxzmx8' /* Cânula nasofaríngea */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions
                                      .calcularCanulaNasofaringeaEsperada(
                                          FFAppState().User.uSRKGs,
                                          FFAppState().User.usrAltura,
                                          FFAppState().User.usrIdade,
                                          FFAppState().User.usrGenero,
                                          false,
                                          FFAppState().User.usrLinguagem)
                                  : functions
                                      .calcularCanulaNasofaringeaEsperada(
                                          FFAppState().User.uSRKGs,
                                          FFAppState().User.usrAltura,
                                          FFAppState().User.usrIdade,
                                          FFAppState().User.usrGenero,
                                          true,
                                          FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'hnotsrfg' /* Combitubo */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularCombituboEsperado(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularCombituboEsperado(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '5457q7mk' /* Máscara laríngea */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularMascaraLaringeaEsperada(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularMascaraLaringeaEsperada(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'd6j7l1z2' /* Laringoscópio reto */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularLaringoscopioReto(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularLaringoscopioReto(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '9m560rgh' /* Laringoscópio curvo */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularLaringoscopioCurvo(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularLaringoscopioCurvo(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '03q3z8vw' /* Tubo orotraqueal com cuff */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularTuboOrotraquealComCuff(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularTuboOrotraquealComCuff(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '3vjxuiex' /* Tubo orotraqueal sem cuff */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularTuboOrotraquealSemCuff(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularTuboOrotraquealSemCuff(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'fhnzxxmg' /* Altura da fixação */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularAlturaFixacaoTubo(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularAlturaFixacaoTubo(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '8uwzdrhu' /* Cânula de traqueostomia */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularCanulaTraqueostomia(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularCanulaTraqueostomia(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                    ].divide(SizedBox(height: 8.0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF334155),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: Color(0xFF456A92),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          '3j0a8cyr' /* Parâmetros Respiratórios */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'po68v56z' /* Frequência respiratória */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularFrequenciaRespiratoria(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularFrequenciaRespiratoria(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '2npynzk8' /* Volume corrente */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularVolumeCorrente(
                                      FFAppState().User.usrAltura,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularVolumeCorrente(
                                      FFAppState().User.usrAltura,
                                      true,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '1u4xwv7c' /* Volume por minuto */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularVolumePorMinuto(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularVolumePorMinuto(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '7udaidpd' /* Relação I:E */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularRelacaoIE(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularRelacaoIE(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '7d97tsqn' /* Espaço morto */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularEspacoMorto(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularEspacoMorto(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'kkyq6s04' /* Pressão de pico */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              functions.calcularPressaoDePico(
                                  FFAppState().User.uSRKGs,
                                  FFAppState().User.usrAltura,
                                  FFAppState().User.usrIdade,
                                  FFAppState().User.usrGenero),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '6znxusqo' /* PEEP sugerida */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              functions.calcularPEEPSugerida(
                                  FFAppState().User.uSRKGs,
                                  FFAppState().User.usrAltura,
                                  FFAppState().User.usrIdade,
                                  FFAppState().User.usrGenero),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                    ].divide(SizedBox(height: 8.0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF334155),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: Color(0xFF456A92),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'riwu4lxz' /* Cálculos extra */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'ufcq8mwh' /* Sonda vesical de demora */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularSondaVesicalDemora(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularSondaVesicalDemora(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'hhaq3cin' /* Dreno de Kehr */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularDrenoKehr(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularDrenoKehr(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '0vswtk4d' /* Sonda nasogástrica (SNG) */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularSondaNasogastrica(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularSondaNasogastrica(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              's6sndf7p' /* Fixação da SNG */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularFixacaoSNG(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularFixacaoSNG(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'unr1ovao' /* Sonda nasoentérica (SNE) */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularSondaNasoenterica(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularSondaNasoenterica(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '5re66hri' /* Fixação da SNE */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularFixacaoSNE(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularFixacaoSNE(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '43uk05ms' /* Acesso central */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularAcessoCentral(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrGenero)
                                  : functions.calcularAcessoCentral(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true,
                                      FFAppState().User.usrGenero),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '5hkzrjzu' /* Cateter de Shilley */,
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
                                  color: Color(0xFFF9FAFB),
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
                            valueOrDefault<String>(
                              ('Quilogramas (kg)' ==
                                          FFAppState().User.usrUndMedPeso) &&
                                      ('Centímetros (cm)' ==
                                          FFAppState().User.usrUndMedAltura)
                                  ? functions.calcularCateterShilley(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      false,
                                      FFAppState().User.usrLinguagem)
                                  : functions.calcularCateterShilley(
                                      FFAppState().User.uSRKGs,
                                      FFAppState().User.usrAltura,
                                      FFAppState().User.usrIdade,
                                      FFAppState().User.usrGenero,
                                      true,
                                      FFAppState().User.usrLinguagem),
                              '-',
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
                                  color: Color(0xFFF9FAFB),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                    ].divide(SizedBox(height: 8.0)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

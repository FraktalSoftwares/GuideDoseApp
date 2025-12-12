import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'p_consentimento_model.dart';
export 'p_consentimento_model.dart';

class PConsentimentoWidget extends StatefulWidget {
  const PConsentimentoWidget({
    super.key,
    this.componentTitulo,
    this.componentDescricao,
  });

  final String? componentTitulo;
  final String? componentDescricao;

  @override
  State<PConsentimentoWidget> createState() => _PConsentimentoWidgetState();
}

class _PConsentimentoWidgetState extends State<PConsentimentoWidget> {
  late PConsentimentoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PConsentimentoModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF0F172A),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 42.0, 16.0, 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: AlignmentDirectional(-1.0, -1.0),
              child: FFButtonWidget(
                onPressed: () async {
                  context.safePop();
                },
                text: FFLocalizations.of(context).getText(
                  '2wtf2njk' /* Voltar */,
                ),
                icon: Icon(
                  Icons.arrow_back,
                  size: 12.0,
                ),
                options: FFButtonOptions(
                  height: 47.0,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconColor: Color(0xFF82C3EE),
                  color: Color(0x004B39EF),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: Colors.white,
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            Text(
              FFLocalizations.of(context).getText(
                'f1zxbrso' /* TERMO DE CONSENTIMENTO */,
              ),
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: Color(0xFFBCE2FA),
                    fontSize: 20.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        '7td28qv0' /* TERMO DE CONSENTIMENTO E RESPO... */,
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
                            color: Color(0xFFB1BDCD),
                            fontSize: 12.0,
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
              ),
            ),
          ].divide(SizedBox(height: 24.0)),
        ),
      ),
    );
  }
}

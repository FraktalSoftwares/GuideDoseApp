import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'p_excluir_conta_model.dart';
export 'p_excluir_conta_model.dart';

class PExcluirContaWidget extends StatefulWidget {
  const PExcluirContaWidget({super.key});

  @override
  State<PExcluirContaWidget> createState() => _PExcluirContaWidgetState();
}

class _PExcluirContaWidgetState extends State<PExcluirContaWidget> {
  late PExcluirContaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PExcluirContaModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: 306.0,
        height: 315.0,
        decoration: BoxDecoration(
          color: Color(0xFF35090A),
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/ix_clear.png',
                width: 62.0,
                height: 62.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  'zwbiei5q' /* Tem certeza de que quer ir? */,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  '8siu99m9' /* Sem MC Guidedose você deixa de... */,
                ),
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight: FontWeight.normal,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.normal,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  Navigator.pop(context);
                },
                text: FFLocalizations.of(context).getText(
                  '85zer3a3' /* Continuar conosco */,
                ),
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 49.0,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Color(0xFF2C3744),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: Colors.white,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  var _shouldSetState = false;
                  _model.apiResult565 = await DELETARUserCall.call(
                    userId: currentUserUid,
                  );

                  _shouldSetState = true;
                  if ((_model.apiResult565?.succeeded ?? true)) {
                    context.pushNamed(RecepcaoWidget.routeName);

                    if (_shouldSetState) safeSetState(() {});
                    return;
                  }
                  if (_shouldSetState) safeSetState(() {});
                },
                text: FFLocalizations.of(context).getText(
                  'tn1fqvwd' /* Não ter mais segurança nas dos... */,
                ),
                options: FFButtonOptions(
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Color(0x002C3744),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: Colors.white,
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

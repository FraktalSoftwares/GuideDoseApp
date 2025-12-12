import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'p_aviso_model.dart';
export 'p_aviso_model.dart';

class PAvisoWidget extends StatefulWidget {
  const PAvisoWidget({
    super.key,
    bool? erro,
    this.descricao,
  }) : this.erro = erro ?? false;

  final bool erro;
  final String? descricao;

  @override
  State<PAvisoWidget> createState() => _PAvisoWidgetState();
}

class _PAvisoWidgetState extends State<PAvisoWidget> {
  late PAvisoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PAvisoModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 20.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 289.0,
        ),
        decoration: BoxDecoration(
          color: Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: Color(0xFF475569),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget!.erro)
              Icon(
                Icons.close,
                color: Color(0xFFFF0000),
                size: 60.0,
              ),
            if (!widget!.erro)
              Icon(
                Icons.check,
                color: Color(0xFF0AF839),
                size: 60.0,
              ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    valueOrDefault<String>(
                      widget!.descricao,
                      'Sem descrição',
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          font: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontStyle,
                        ),
                  ),
                ].divide(SizedBox(height: 12.0)),
              ),
            ),
            Container(
              width: double.infinity,
              height: 1.0,
              decoration: BoxDecoration(
                color: Color(0xFF475569),
                border: Border.all(
                  color: Color(0xFF475569),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 16.0, 16.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '4lrtny8f' /* Fechar */,
                          ),
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

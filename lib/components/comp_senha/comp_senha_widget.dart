import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'comp_senha_model.dart';
export 'comp_senha_model.dart';

class CompSenhaWidget extends StatefulWidget {
  const CompSenhaWidget({
    super.key,
    required this.tituloBep,
    required this.descricao,
  });

  final String? tituloBep;
  final List<String>? descricao;

  @override
  State<CompSenhaWidget> createState() => _CompSenhaWidgetState();
}

class _CompSenhaWidgetState extends State<CompSenhaWidget> {
  late CompSenhaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CompSenhaModel());

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
      width: 372.0,
      height: 300.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryText,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.error_outline_sharp,
              color: FlutterFlowTheme.of(context).corBotoes,
              size: 64.0,
            ),
            Text(
              valueOrDefault<String>(
                widget!.tituloBep,
                'Confira os requisitos da senha',
              ),
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: Color(0xFF456A92),
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
            Builder(
              builder: (context) {
                final mapItem = widget!.descricao!.map((e) => e).toList();

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: mapItem.length,
                  itemBuilder: (context, mapItemIndex) {
                    final mapItemItem = mapItem[mapItemIndex];
                    return Text(
                      mapItemItem,
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.normal,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: Color(0xFF64748B),
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    );
                  },
                );
              },
            ),
            Divider(
              height: 1.0,
              thickness: 2.0,
              color: FlutterFlowTheme.of(context).alternate,
            ),
            FFButtonWidget(
              onPressed: () async {
                Navigator.pop(context);
              },
              text: FFLocalizations.of(context).getText(
                'ic7wpy4h' /* Fechar */,
              ),
              options: FFButtonOptions(
                width: double.infinity,
                height: 48.0,
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: Color(0xFF456A92),
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      font: GoogleFonts.poppins(
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                      color: Colors.white,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).titleSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleSmall.fontStyle,
                    ),
                elevation: 0.0,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ].divide(SizedBox(height: 8.0)),
        ),
      ),
    );
  }
}

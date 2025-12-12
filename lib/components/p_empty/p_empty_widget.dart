import '/components/p_feedback/p_feedback_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'p_empty_model.dart';
export 'p_empty_model.dart';

class PEmptyWidget extends StatefulWidget {
  const PEmptyWidget({super.key});

  @override
  State<PEmptyWidget> createState() => _PEmptyWidgetState();
}

class _PEmptyWidgetState extends State<PEmptyWidget> {
  late PEmptyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PEmptyModel());

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
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/Empty_State_Vector.png',
              width: 173.0,
              height: 173.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            FFLocalizations.of(context).getText(
              '0ryjaukn' /* Ainda sem resultados... */,
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).text,
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 0.0),
            child: FFButtonWidget(
              onPressed: () async {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  enableDrag: false,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.viewInsetsOf(context),
                      child: PFeedbackWidget(),
                    );
                  },
                ).then((value) => safeSetState(() {}));
              },
              text: FFLocalizations.of(context).getText(
                '7s5mc3w2' /* Fale Conosco! */,
              ),
              options: FFButtonOptions(
                width: double.infinity,
                height: 49.0,
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 14.0, 24.0, 14.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: Color(0xFF456A92),
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      font: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                      color: Colors.white,
                      fontSize: 14.0,
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
        ],
      ),
    );
  }
}

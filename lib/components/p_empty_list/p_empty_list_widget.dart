import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'p_empty_list_model.dart';
export 'p_empty_list_model.dart';

class PEmptyListWidget extends StatefulWidget {
  const PEmptyListWidget({super.key});

  @override
  State<PEmptyListWidget> createState() => _PEmptyListWidgetState();
}

class _PEmptyListWidgetState extends State<PEmptyListWidget> {
  late PEmptyListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PEmptyListModel());

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
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.search,
            color: Color(0xFF94A3B8),
            size: 48.0,
          ),
          Text(
            FFLocalizations.of(context).getText(
              'ob3k9h6u' /* Ainda sem resultados... */,
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  color: Color(0xFF94A3B8),
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
          ),
        ].divide(SizedBox(height: 16.0)),
      ),
    );
  }
}

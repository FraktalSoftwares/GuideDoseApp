import '/backend/supabase/supabase.dart';
import '/components/p_empty/p_empty_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pg_inducao/icon_fav_inducao/icon_fav_inducao_widget.dart';
import '/pg_inducao/p_accordeon_inducao/p_accordeon_inducao_widget.dart';
import '/pg_inducao/p_detalhe_inducao/p_detalhe_inducao_widget.dart';
import 'dart:ui';
import 'dart:async';
import 'p_inducao_widget.dart' show PInducaoWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PInducaoModel extends FlutterFlowModel<PInducaoWidget> {
  ///  Local state fields for this component.

  int? accordeonVisivel;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  Completer<List<VwInducoesOrdenadasRow>>? requestCompleter;
  // Models for icon_favInducao dynamic component.
  late FlutterFlowDynamicModels<IconFavInducaoModel> iconFavInducaoModels;
  // Models for p_accordeon_inducao dynamic component.
  late FlutterFlowDynamicModels<PAccordeonInducaoModel> pAccordeonInducaoModels;

  @override
  void initState(BuildContext context) {
    iconFavInducaoModels =
        FlutterFlowDynamicModels(() => IconFavInducaoModel());
    pAccordeonInducaoModels =
        FlutterFlowDynamicModels(() => PAccordeonInducaoModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    iconFavInducaoModels.dispose();
    pAccordeonInducaoModels.dispose();
  }

  /// Additional helper methods.
  Future waitForRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}

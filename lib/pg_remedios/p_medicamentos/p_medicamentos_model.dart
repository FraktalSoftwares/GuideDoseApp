import '/backend/supabase/supabase.dart';
import '/components/p_empty/p_empty_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pg_remedios/icon_fav/icon_fav_widget.dart';
import '/pg_remedios/p_accordeon_medicamento/p_accordeon_medicamento_widget.dart';
import '/pg_remedios/p_detalhe_medicamento/p_detalhe_medicamento_widget.dart';
import 'dart:ui';
import 'dart:async';
import 'p_medicamentos_widget.dart' show PMedicamentosWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PMedicamentosModel extends FlutterFlowModel<PMedicamentosWidget> {
  ///  Local state fields for this component.

  int? accordeonVisivel;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  Completer<List<VwMedicamentosOrdernadosRow>>? requestCompleter;
  // Models for icon_fav dynamic component.
  late FlutterFlowDynamicModels<IconFavModel> iconFavModels;
  // Models for p_accordeon_medicamento dynamic component.
  late FlutterFlowDynamicModels<PAccordeonMedicamentoModel>
      pAccordeonMedicamentoModels;

  @override
  void initState(BuildContext context) {
    iconFavModels = FlutterFlowDynamicModels(() => IconFavModel());
    pAccordeonMedicamentoModels =
        FlutterFlowDynamicModels(() => PAccordeonMedicamentoModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    iconFavModels.dispose();
    pAccordeonMedicamentoModels.dispose();
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

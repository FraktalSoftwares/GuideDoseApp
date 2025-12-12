import '/components/comp_menu/comp_menu_widget.dart';
import '/components/p_header/p_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pg_fisiologia/c_fisiologia/c_fisiologia_widget.dart';
import '/pg_inducao/p_inducao/p_inducao_widget.dart';
import '/pg_remedios/p_medicamentos/p_medicamentos_widget.dart';
import '/pg_usuario/p_conta/p_conta_widget.dart';
import 'dart:ui';
import 'painel_widget.dart' show PainelWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PainelModel extends FlutterFlowModel<PainelWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for p_header component.
  late PHeaderModel pHeaderModel;
  // Model for p_inducao component.
  late PInducaoModel pInducaoModel;
  // Model for c_fisiologia component.
  late CFisiologiaModel cFisiologiaModel;
  // Model for p_medicamentos component.
  late PMedicamentosModel pMedicamentosModel;
  // Model for p_conta component.
  late PContaModel pContaModel;
  // Model for comp_menu component.
  late CompMenuModel compMenuModel;

  @override
  void initState(BuildContext context) {
    pHeaderModel = createModel(context, () => PHeaderModel());
    pInducaoModel = createModel(context, () => PInducaoModel());
    cFisiologiaModel = createModel(context, () => CFisiologiaModel());
    pMedicamentosModel = createModel(context, () => PMedicamentosModel());
    pContaModel = createModel(context, () => PContaModel());
    compMenuModel = createModel(context, () => CompMenuModel());
  }

  @override
  void dispose() {
    pHeaderModel.dispose();
    pInducaoModel.dispose();
    cFisiologiaModel.dispose();
    pMedicamentosModel.dispose();
    pContaModel.dispose();
    compMenuModel.dispose();
  }
}

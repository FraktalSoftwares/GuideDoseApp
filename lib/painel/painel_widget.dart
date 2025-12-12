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
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'painel_model.dart';
export 'painel_model.dart';

class PainelWidget extends StatefulWidget {
  const PainelWidget({super.key});

  static String routeName = 'painel';
  static String routePath = '/painel';

  @override
  State<PainelWidget> createState() => _PainelWidgetState();
}

class _PainelWidgetState extends State<PainelWidget> {
  late PainelModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PainelModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (FFAppState().menu != 'conta')
                  wrapWithModel(
                    model: _model.pHeaderModel,
                    updateCallback: () => safeSetState(() {}),
                    child: PHeaderWidget(),
                  ),
                if (FFAppState().menu == 'inducao')
                  Expanded(
                    child: wrapWithModel(
                      model: _model.pInducaoModel,
                      updateCallback: () => safeSetState(() {}),
                      child: PInducaoWidget(),
                    ),
                  ),
                if (FFAppState().menu == 'fisiologia')
                  Expanded(
                    child: wrapWithModel(
                      model: _model.cFisiologiaModel,
                      updateCallback: () => safeSetState(() {}),
                      child: CFisiologiaWidget(),
                    ),
                  ),
                if (FFAppState().menu == 'drogas')
                  Expanded(
                    child: wrapWithModel(
                      model: _model.pMedicamentosModel,
                      updateCallback: () => safeSetState(() {}),
                      child: PMedicamentosWidget(),
                    ),
                  ),
                if (FFAppState().menu == 'conta')
                  Expanded(
                    child: wrapWithModel(
                      model: _model.pContaModel,
                      updateCallback: () => safeSetState(() {}),
                      child: PContaWidget(),
                    ),
                  ),
                wrapWithModel(
                  model: _model.compMenuModel,
                  updateCallback: () => safeSetState(() {}),
                  child: CompMenuWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

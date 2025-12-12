import '/backend/supabase/supabase.dart';
import '/components/p_empty_list/p_empty_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'p_accordeon_inducao_model.dart';
export 'p_accordeon_inducao_model.dart';

class PAccordeonInducaoWidget extends StatefulWidget {
  const PAccordeonInducaoWidget({
    super.key,
    this.idInducao,
  });

  final int? idInducao;

  @override
  State<PAccordeonInducaoWidget> createState() =>
      _PAccordeonInducaoWidgetState();
}

class _PAccordeonInducaoWidgetState extends State<PAccordeonInducaoWidget> {
  late PAccordeonInducaoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PAccordeonInducaoModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<List<AccordeonInducaoRow>>(
      future: AccordeonInducaoTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'inducao_id',
          widget!.idInducao,
        ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: SpinKitRing(
                color: Color(0xFF3C4F67),
                size: 50.0,
              ),
            ),
          );
        }
        List<AccordeonInducaoRow> containerAccordeonInducaoRowList =
            snapshot.data!;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    FFLocalizations.of(context).getText(
                      'dmpev9uc' /* Medicamento */,
                    ),
                    style: FlutterFlowTheme.of(context).textAuth.override(
                          font: GoogleFonts.roboto(
                            fontWeight: FontWeight.normal,
                            fontStyle:
                                FlutterFlowTheme.of(context).textAuth.fontStyle,
                          ),
                          color: Color(0xFFB1BDCD),
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                          fontStyle:
                              FlutterFlowTheme.of(context).textAuth.fontStyle,
                        ),
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'fpv73ho7' /* Dose / Volume */,
                    ),
                    style: FlutterFlowTheme.of(context).textAuth.override(
                          font: GoogleFonts.roboto(
                            fontWeight: FontWeight.normal,
                            fontStyle:
                                FlutterFlowTheme.of(context).textAuth.fontStyle,
                          ),
                          color: Color(0xFFB1BDCD),
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                          fontStyle:
                              FlutterFlowTheme.of(context).textAuth.fontStyle,
                        ),
                  ),
                ],
              ),
              Builder(
                builder: (context) {
                  final remedios =
                      containerAccordeonInducaoRowList.map((e) => e).toList();
                  if (remedios.isEmpty) {
                    return Center(
                      child: PEmptyListWidget(),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: remedios.length,
                    itemBuilder: (context, remediosIndex) {
                      final remediosItem = remedios[remediosIndex];
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            valueOrDefault<String>(
                              FFLocalizations.of(context).getVariableText(
                                ptText: remediosItem.medNome,
                                enText: remediosItem.medNomeEn,
                                esText: remediosItem.medNomeEs,
                              ),
                              '-',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .infoMedicamentos
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .fontStyle,
                                  ),
                                  color: Color(0xFFE2E8F0),
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .fontStyle,
                                ),
                          ),
                          Flexible(
                            child: Text(
                              valueOrDefault<String>(
                                '${functions.calcularDoseMg(FFAppState().User.uSRKGs, remediosItem.doseMgKg)} / ${functions.calcularVolumeMlComPeso(remediosItem.doseMgKg, remediosItem.concentracaoMgMl, FFAppState().User.uSRKGs)}',
                                '-',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .infoMedicamentos
                                  .override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .infoMedicamentos
                                          .fontStyle,
                                    ),
                                    color: Color(0xFFE2E8F0),
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ].divide(SizedBox(height: 8.0)),
          ),
        );
      },
    );
  }
}

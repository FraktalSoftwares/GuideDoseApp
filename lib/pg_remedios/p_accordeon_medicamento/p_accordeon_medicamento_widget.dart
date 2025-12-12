import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'p_accordeon_medicamento_model.dart';
export 'p_accordeon_medicamento_model.dart';

class PAccordeonMedicamentoWidget extends StatefulWidget {
  const PAccordeonMedicamentoWidget({
    super.key,
    required this.id,
  });

  final int? id;

  @override
  State<PAccordeonMedicamentoWidget> createState() =>
      _PAccordeonMedicamentoWidgetState();
}

class _PAccordeonMedicamentoWidgetState
    extends State<PAccordeonMedicamentoWidget> {
  late PAccordeonMedicamentoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PAccordeonMedicamentoModel());

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

    return FutureBuilder<List<VMedicamentoItensDetalhadosRow>>(
      future: VMedicamentoItensDetalhadosTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'medicamento_id',
          widget!.id,
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
        List<VMedicamentoItensDetalhadosRow>
            containerVMedicamentoItensDetalhadosRowList = snapshot.data!;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                FFLocalizations.of(context).getText(
                  '86ehoge5' /* Preparo */,
                ),
                style: FlutterFlowTheme.of(context).textAuth.override(
                      font: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            FlutterFlowTheme.of(context).textAuth.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).text,
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).textAuth.fontStyle,
                    ),
              ),
              Builder(
                builder: (context) {
                  final medicamento =
                      containerVMedicamentoItensDetalhadosRowList
                          .map((e) => e)
                          .toList()
                          .where((e) => 'Preparo' == e.topico)
                          .toList();

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: medicamento.length,
                    itemBuilder: (context, medicamentoIndex) {
                      final medicamentoItem = medicamento[medicamentoIndex];
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  valueOrDefault<String>(
                                    medicamentoItem.titulo,
                                    '-',
                                  ),
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .infoMedicamentos
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
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
                              if (medicamentoItem.subtitulo != null &&
                                  medicamentoItem.subtitulo != '')
                                Flexible(
                                  child: Text(
                                    valueOrDefault<String>(
                                      medicamentoItem.subtitulo,
                                      '-',
                                    ),
                                    textAlign: TextAlign.end,
                                    style: FlutterFlowTheme.of(context)
                                        .infoMedicamentos
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .infoMedicamentos
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .infoMedicamentos
                                                    .fontStyle,
                                          ),
                                          color: Color(0xFFE2E8F0),
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .infoMedicamentos
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .infoMedicamentos
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                            ].divide(SizedBox(width: 16.0)),
                          ),
                        ]
                            .divide(SizedBox(height: 16.0))
                            .addToStart(SizedBox(height: 4.0))
                            .addToEnd(SizedBox(height: 4.0)),
                      );
                    },
                  );
                },
              ),
              Divider(
                height: 2.0,
                thickness: 1.0,
                color: Color(0xFFE2E8F0),
              ),
              Text(
                FFLocalizations.of(context).getText(
                  'qxvq84ir' /* Indicação e doses */,
                ),
                style: FlutterFlowTheme.of(context).textAuth.override(
                      font: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            FlutterFlowTheme.of(context).textAuth.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).text,
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).textAuth.fontStyle,
                    ),
              ),
              Builder(
                builder: (context) {
                  final medicamento =
                      containerVMedicamentoItensDetalhadosRowList
                          .map((e) => e)
                          .toList()
                          .where((e) => 'Indicações' == e.topico)
                          .toList();

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: medicamento.length,
                    itemBuilder: (context, medicamentoIndex) {
                      final medicamentoItem = medicamento[medicamentoIndex];
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  valueOrDefault<String>(
                                    medicamentoItem.titulo,
                                    '-',
                                  ),
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .infoMedicamentos
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
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
                              Flexible(
                                child: Text(
                                  valueOrDefault<String>(
                                    medicamentoItem.subtitulo,
                                    '-',
                                  ),
                                  textAlign: TextAlign.end,
                                  style: FlutterFlowTheme.of(context)
                                      .infoMedicamentos
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .infoMedicamentos
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
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
                            ].divide(SizedBox(width: 16.0)),
                          ),
                        ]
                            .divide(SizedBox(height: 16.0))
                            .addToStart(SizedBox(height: 4.0))
                            .addToEnd(SizedBox(height: 4.0)),
                      );
                    },
                  );
                },
              ),
              Divider(
                height: 2.0,
                thickness: 1.0,
                color: Color(0xFFE2E8F0),
              ),
              if ('true' ==
                      getJsonField(
                        containerVMedicamentoItensDetalhadosRowList
                            .where((e) =>
                                (widget!.id == e.medicamentoId) &&
                                ('SliderConfig' == e.topico))
                            .toList()
                            .firstOrNull
                            ?.dadosCalculo,
                        r'''$.slideInput''',
                      ).toString()
                  ? true
                  : false)
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        '7hb7xx6k' /* Indicação e doses */,
                      ),
                      style: FlutterFlowTheme.of(context)
                          .titleMedicamentos
                          .override(
                            font: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedicamentos
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedicamentos
                                .fontStyle,
                          ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: FlutterFlowDropDown<String>(
                            controller: _model.dropDownValueController ??=
                                FormFieldController<String>(
                              _model.dropDownValue ??= '',
                            ),
                            options: List<String>.from(
                                functions.getDropdownLabels(
                                    containerVMedicamentoItensDetalhadosRowList
                                        .map((e) => e.dadosCalculo)
                                        .withoutNulls
                                        .toList())),
                            optionLabels: functions.getDropdownLabels(
                                containerVMedicamentoItensDetalhadosRowList
                                    .map((e) => e.dadosCalculo)
                                    .withoutNulls
                                    .toList()),
                            onChanged: (val) =>
                                safeSetState(() => _model.dropDownValue = val),
                            width: double.infinity,
                            height: 40.0,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: Color(0xFFE2E8F0),
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            hintText: FFLocalizations.of(context).getText(
                              'q8ad2f5g' /* Selecione */,
                            ),
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            elevation: 2.0,
                            borderColor: Colors.transparent,
                            borderWidth: 0.0,
                            borderRadius: 8.0,
                            margin: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            hidesUnderline: true,
                            isOverButton: false,
                            isSearchable: false,
                            isMultiSelect: false,
                          ),
                        ),
                        Divider(
                          height: 1.0,
                          thickness: 1.0,
                          color: Color(0xFF42546E),
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${getJsonField(
                                containerVMedicamentoItensDetalhadosRowList
                                    .where((e) =>
                                        (widget!.id == e.medicamentoId) &&
                                        ('SliderConfig' == e.topico))
                                    .toList()
                                    .firstOrNull
                                    ?.dadosCalculo,
                                r'''$.doseMin''',
                              ).toString()} ${getJsonField(
                                containerVMedicamentoItensDetalhadosRowList
                                    .where((e) =>
                                        (widget!.id == e.medicamentoId) &&
                                        ('SliderConfig' == e.topico))
                                    .toList()
                                    .firstOrNull
                                    ?.dadosCalculo,
                                r'''$.unidade''',
                              ).toString()}',
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
                                    color: Color(0xFF94A3B8),
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
                                getJsonField(
                                  containerVMedicamentoItensDetalhadosRowList
                                      .where((e) =>
                                          (widget!.id == e.medicamentoId) &&
                                          ('SliderConfig' == e.topico))
                                      .toList()
                                      .firstOrNull!
                                      .dadosCalculo!,
                                  r'''$.doseMax''',
                                ).toString(),
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
                                      color: Color(0xFF94A3B8),
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
                        ),
                        SliderTheme(
                          data: SliderThemeData(
                            showValueIndicator: ShowValueIndicator.always,
                          ),
                          child: Slider.adaptive(
                            activeColor: Color(0xFF456A92),
                            inactiveColor:
                                FlutterFlowTheme.of(context).alternate,
                            min: valueOrDefault<double>(
                              functions.getSliderParam(
                                  containerVMedicamentoItensDetalhadosRowList
                                      .map((e) => e.dadosCalculo)
                                      .withoutNulls
                                      .toList(),
                                  'doseMin'),
                              0.0,
                            ),
                            max: valueOrDefault<double>(
                              functions.getSliderParam(
                                  containerVMedicamentoItensDetalhadosRowList
                                      .map((e) => e.dadosCalculo)
                                      .withoutNulls
                                      .toList(),
                                  'doseMax'),
                              0.0,
                            ),
                            value: _model.sliderPrincipalValue ??=
                                functions.getSliderParam(
                                    containerVMedicamentoItensDetalhadosRowList
                                        .map((e) => e.dadosCalculo)
                                        .withoutNulls
                                        .toList(),
                                    'doseMin'),
                            label:
                                _model.sliderPrincipalValue?.toStringAsFixed(1),
                            onChanged: (newValue) {
                              newValue =
                                  double.parse(newValue.toStringAsFixed(1));
                              safeSetState(
                                  () => _model.sliderPrincipalValue = newValue);
                            },
                          ),
                        ),
                        if (responsiveVisibility(
                          context: context,
                          phone: false,
                          tablet: false,
                          tabletLandscape: false,
                          desktop: false,
                        ))
                          SliderTheme(
                            data: SliderThemeData(
                              showValueIndicator: ShowValueIndicator.always,
                            ),
                            child: Slider.adaptive(
                              activeColor: Color(0xFF456A92),
                              inactiveColor:
                                  FlutterFlowTheme.of(context).alternate,
                              min: valueOrDefault<double>(
                                getJsonField(
                                  containerVMedicamentoItensDetalhadosRowList
                                      .where((e) =>
                                          (widget!.id == e.medicamentoId) &&
                                          ('SliderConfig' == e.topico))
                                      .toList()
                                      .firstOrNull
                                      ?.dadosCalculo,
                                  r'''$.doseMin''',
                                ),
                                0.0,
                              ),
                              max: valueOrDefault<double>(
                                getJsonField(
                                  containerVMedicamentoItensDetalhadosRowList
                                      .where((e) =>
                                          (widget!.id == e.medicamentoId) &&
                                          ('SliderConfig' == e.topico))
                                      .toList()
                                      .firstOrNull
                                      ?.dadosCalculo,
                                  r'''$.doseMax''',
                                ),
                                0.5,
                              ),
                              value: _model.sliderValue ??= getJsonField(
                                containerVMedicamentoItensDetalhadosRowList
                                    .where((e) =>
                                        (widget!.id == e.medicamentoId) &&
                                        ('SliderConfig' == e.topico))
                                    .toList()
                                    .firstOrNull!
                                    .dadosCalculo!,
                                r'''$.doseMin''',
                              ),
                              label: _model.sliderValue?.toStringAsFixed(1),
                              onChanged: (newValue) {
                                newValue =
                                    double.parse(newValue.toStringAsFixed(1));
                                safeSetState(
                                    () => _model.sliderValue = newValue);
                              },
                            ),
                          ),
                        Text(
                          valueOrDefault<String>(
                            functions.calcularResultadoMestre(
                                containerVMedicamentoItensDetalhadosRowList
                                    .map((e) => e.dadosCalculo)
                                    .withoutNulls
                                    .toList(),
                                _model.sliderPrincipalValue!,
                                FFAppState().User.uSRKGs,
                                _model.dropDownValue!,
                                valueOrDefault<String>(
                                  FFAppState().User.usrUndMedPeso,
                                  'Quilogramas (kg)',
                                )),
                            '0',
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                  ].divide(SizedBox(height: 8.0)),
                ),
            ].divide(SizedBox(height: 8.0)),
          ),
        );
      },
    );
  }
}

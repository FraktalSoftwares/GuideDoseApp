import '/components/p_calc/p_calc_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'comp_menu_model.dart';
export 'comp_menu_model.dart';

class CompMenuWidget extends StatefulWidget {
  const CompMenuWidget({super.key});

  @override
  State<CompMenuWidget> createState() => _CompMenuWidgetState();
}

class _CompMenuWidgetState extends State<CompMenuWidget> {
  late CompMenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CompMenuModel());

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

    return Container(
      width: double.infinity,
      height: 100.0,
      decoration: BoxDecoration(
        color: Color(0xFF3C4F67),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  FFAppState().menu = 'inducao';
                  FFAppState().modulo = valueOrDefault<String>(
                    FFLocalizations.of(context).getVariableText(
                      ptText: 'Dose de indução',
                      enText: 'Induction dose',
                      esText: 'Dosis de inducción',
                    ),
                    'Dose de indução',
                  );
                  FFAppState().update(() {});
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 0),
                        fadeOutDuration: Duration(milliseconds: 0),
                        imageUrl: valueOrDefault<String>(
                          FFAppState().menu == 'inducao'
                              ? 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/m-c-guide-dose-0vlmcq/assets/14jhrexf8sj4/local_hospital_(2).png'
                              : 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/m-c-guide-dose-0vlmcq/assets/i5mj2yggyw6u/local_hospital_(1).png',
                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/m-c-guide-dose-0vlmcq/assets/i5mj2yggyw6u/local_hospital_(1).png',
                        ),
                        width: 24.0,
                        height: 24.0,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Icon(
                          Icons.local_hospital,
                          color: FFAppState().menu == 'inducao'
                              ? Color(0xFF5983B1)
                              : Color(0xFF94A3B8),
                          size: 24.0,
                        ),
                      ),
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        't9510bew' /* Indução */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: valueOrDefault<Color>(
                              FFAppState().menu == 'inducao'
                                  ? Color(0xFF5983B1)
                                  : Color(0xFF94A3B8),
                              Color(0xFF94A3B8),
                            ),
                            fontSize: 12.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ].divide(SizedBox(height: 4.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: 66.0,
              height: 100.0,
              decoration: BoxDecoration(),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  FFAppState().menu = 'fisiologia';
                  FFAppState().modulo = valueOrDefault<String>(
                    FFLocalizations.of(context).getVariableText(
                      ptText: 'Parâmetros de Fisiologia',
                      enText: 'Physiology Parameters',
                      esText: 'Parámetros fisiológicos',
                    ),
                    'Dose de indução',
                  );
                  FFAppState().update(() {});
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 0),
                        fadeOutDuration: Duration(milliseconds: 0),
                        imageUrl: valueOrDefault<String>(
                          FFAppState().menu == 'fisiologia'
                              ? 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/m-c-guide-dose-0vlmcq/assets/h86cuh8x6cmx/Activity_(1).png'
                              : 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/m-c-guide-dose-0vlmcq/assets/4ris1y5h5700/Activity.png',
                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/m-c-guide-dose-0vlmcq/assets/4ris1y5h5700/Activity.png',
                        ),
                        width: 24.0,
                        height: 24.0,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Icon(
                          Icons.favorite_border,
                          color: FFAppState().menu == 'fisiologia'
                              ? Color(0xFF5983B1)
                              : Color(0xFF94A3B8),
                          size: 24.0,
                        ),
                      ),
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        'rzwvtr0f' /* Fisiologia */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: valueOrDefault<Color>(
                              FFAppState().menu == 'fisiologia'
                                  ? Color(0xFF5983B1)
                                  : Color(0xFF94A3B8),
                              Color(0xFF94A3B8),
                            ),
                            fontSize: 12.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ].divide(SizedBox(height: 4.0)),
                ),
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              await showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                enableDrag: false,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.viewInsetsOf(context),
                    child: PCalcWidget(),
                  );
                },
              ).then((value) => safeSetState(() {}));
            },
            child: Container(
              width: 65.0,
              height: 65.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    'assets/images/Nav_Button.png',
                  ).image,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  FFAppState().menu = 'drogas';
                  FFAppState().modulo = valueOrDefault<String>(
                    FFLocalizations.of(context).getVariableText(
                      ptText: 'Medicamentos',
                      enText: 'Medications',
                      esText: 'Medicamentos',
                    ),
                    'Dose de indução',
                  );
                  FFAppState().update(() {});
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 0),
                        fadeOutDuration: Duration(milliseconds: 0),
                        imageUrl: valueOrDefault<String>(
                          FFAppState().menu == 'drogas'
                              ? 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/m-c-guide-dose-0vlmcq/assets/qu5qkmct70qt/Medicine_(1).png'
                              : 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/m-c-guide-dose-0vlmcq/assets/6iw08txaoe99/Medicine.png',
                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/m-c-guide-dose-0vlmcq/assets/6iw08txaoe99/Medicine.png',
                        ),
                        width: 24.0,
                        height: 24.0,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Icon(
                          Icons.medication,
                          color: FFAppState().menu == 'drogas'
                              ? Color(0xFF5983B1)
                              : Color(0xFF94A3B8),
                          size: 24.0,
                        ),
                      ),
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        'lgw78d5m' /* Remédios */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: valueOrDefault<Color>(
                              FFAppState().menu == 'drogas'
                                  ? Color(0xFF5983B1)
                                  : Color(0xFF94A3B8),
                              Color(0xFF94A3B8),
                            ),
                            fontSize: 12.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ].divide(SizedBox(height: 4.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  FFAppState().menu = 'conta';
                  FFAppState().update(() {});
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 0),
                        fadeOutDuration: Duration(milliseconds: 0),
                        imageUrl: valueOrDefault<String>(
                          FFAppState().menu == 'conta'
                              ? 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/m-c-guide-dose-0vlmcq/assets/u25p3xcjx6km/person_(1).png'
                              : 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/m-c-guide-dose-0vlmcq/assets/pcs06g33hrqw/person.png',
                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/m-c-guide-dose-0vlmcq/assets/pcs06g33hrqw/person.png',
                        ),
                        width: 24.0,
                        height: 24.0,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Icon(
                          Icons.person,
                          color: FFAppState().menu == 'conta'
                              ? Color(0xFF5983B1)
                              : Color(0xFF94A3B8),
                          size: 24.0,
                        ),
                      ),
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        'xzmt37qj' /* Conta */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: valueOrDefault<Color>(
                              FFAppState().menu == 'conta'
                                  ? Color(0xFF5983B1)
                                  : Color(0xFF94A3B8),
                              Color(0xFF94A3B8),
                            ),
                            fontSize: 12.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ].divide(SizedBox(height: 4.0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

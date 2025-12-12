import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'loading_medicamentos_model.dart';
export 'loading_medicamentos_model.dart';

class LoadingMedicamentosWidget extends StatefulWidget {
  const LoadingMedicamentosWidget({super.key});

  @override
  State<LoadingMedicamentosWidget> createState() =>
      _LoadingMedicamentosWidgetState();
}

class _LoadingMedicamentosWidgetState extends State<LoadingMedicamentosWidget>
    with TickerProviderStateMixin {
  late LoadingMedicamentosModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoadingMedicamentosModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        loop: true,
        reverse: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        loop: true,
        reverse: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        loop: true,
        reverse: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation4': AnimationInfo(
        loop: true,
        reverse: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation5': AnimationInfo(
        loop: true,
        reverse: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
      child: Builder(
        builder: (context) {
          final lists = _model.list.map((e) => e).toList();

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: List.generate(lists.length, (listsIndex) {
                final listsItem = lists[listsIndex];
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFD6D6D6),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: Color(0xFF456A92),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 100.0,
                                      height: 24.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFBABABA),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ).animateOnPageLoad(animationsMap[
                                        'containerOnPageLoadAnimation2']!),
                                  ),
                                  Container(
                                    width: 24.0,
                                    height: 24.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFBABABA),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ).animateOnPageLoad(animationsMap[
                                      'containerOnPageLoadAnimation3']!),
                                  Container(
                                    width: 24.0,
                                    height: 24.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFBABABA),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ).animateOnPageLoad(animationsMap[
                                      'containerOnPageLoadAnimation4']!),
                                  Container(
                                    width: 24.0,
                                    height: 24.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFBABABA),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ).animateOnPageLoad(animationsMap[
                                      'containerOnPageLoadAnimation5']!),
                                ].divide(SizedBox(width: 8.0)),
                              ),
                            ].divide(SizedBox(height: 8.0)),
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation1']!),
                    ),
                  ],
                );
              }).divide(SizedBox(height: 12.0)),
            ),
          );
        },
      ),
    );
  }
}

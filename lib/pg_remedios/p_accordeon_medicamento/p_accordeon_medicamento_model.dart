import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'p_accordeon_medicamento_widget.dart' show PAccordeonMedicamentoWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PAccordeonMedicamentoModel
    extends FlutterFlowModel<PAccordeonMedicamentoWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for SliderPrincipal widget.
  double? sliderPrincipalValue;
  // State field(s) for Slider widget.
  double? sliderValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}

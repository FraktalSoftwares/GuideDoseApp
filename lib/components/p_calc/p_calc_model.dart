import '/auth/supabase_auth/auth_util.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'p_calc_widget.dart' show PCalcWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class PCalcModel extends FlutterFlowModel<PCalcWidget> {
  ///  Local state fields for this component.

  String? sexoSelecionado;

  ///  State fields for stateful widgets in this component.

  // State field(s) for inputKG widget.
  FocusNode? inputKGFocusNode;
  TextEditingController? inputKGTextController;
  late MaskTextInputFormatter inputKGMask;
  String? Function(BuildContext, String?)? inputKGTextControllerValidator;
  // State field(s) for inputAltura widget.
  FocusNode? inputAlturaFocusNode1;
  TextEditingController? inputAlturaTextController1;
  late MaskTextInputFormatter inputAlturaMask1;
  String? Function(BuildContext, String?)? inputAlturaTextController1Validator;
  // State field(s) for inputAltura widget.
  FocusNode? inputAlturaFocusNode2;
  TextEditingController? inputAlturaTextController2;
  late MaskTextInputFormatter inputAlturaMask2;
  String? Function(BuildContext, String?)? inputAlturaTextController2Validator;
  // State field(s) for DropDownAnos widget.
  String? dropDownAnosValue;
  FormFieldController<String>? dropDownAnosValueController;
  // Stores action output result for [Custom Action - checkAgeCategory] action in Button widget.
  String? retornoCategoria;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    inputKGFocusNode?.dispose();
    inputKGTextController?.dispose();

    inputAlturaFocusNode1?.dispose();
    inputAlturaTextController1?.dispose();

    inputAlturaFocusNode2?.dispose();
    inputAlturaTextController2?.dispose();
  }
}

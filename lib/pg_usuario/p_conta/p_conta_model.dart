import '/auth/supabase_auth/auth_util.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/p_checkout/p_checkout_widget.dart';
import '/components/p_consentimento/p_consentimento_widget.dart';
import '/components/p_feedback/p_feedback_widget.dart';
import '/components/p_header_logo/p_header_logo_widget.dart';
import '/components/p_politica/p_politica_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_language_selector.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pg_usuario/p_country/p_country_widget.dart';
import '/pg_usuario/p_excluir_conta/p_excluir_conta_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'p_conta_widget.dart' show PContaWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PContaModel extends FlutterFlowModel<PContaWidget> {
  ///  Local state fields for this component.

  bool editPermitido = false;

  ///  State fields for stateful widgets in this component.

  // Model for p_header_logo component.
  late PHeaderLogoModel pHeaderLogoModel;
  // Model for p_feedback component.
  late PFeedbackModel pFeedbackModel;
  // Model for p_politica component.
  late PPoliticaModel pPoliticaModel;
  // Model for p_excluir_conta component.
  late PExcluirContaModel pExcluirContaModel;
  // Model for p_checkout component.
  late PCheckoutModel pCheckoutModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for input_email widget.
  FocusNode? inputEmailFocusNode;
  TextEditingController? inputEmailTextController;
  String? Function(BuildContext, String?)? inputEmailTextControllerValidator;
  // State field(s) for Novasenha widget.
  FocusNode? novasenhaFocusNode;
  TextEditingController? novasenhaTextController;
  late bool novasenhaVisibility;
  String? Function(BuildContext, String?)? novasenhaTextControllerValidator;
  // State field(s) for DropDownMedidaAltura widget.
  String? dropDownMedidaAlturaValue;
  FormFieldController<String>? dropDownMedidaAlturaValueController;
  // State field(s) for DropDownMedidaPeso widget.
  String? dropDownMedidaPesoValue;
  FormFieldController<String>? dropDownMedidaPesoValueController;

  @override
  void initState(BuildContext context) {
    pHeaderLogoModel = createModel(context, () => PHeaderLogoModel());
    pFeedbackModel = createModel(context, () => PFeedbackModel());
    pPoliticaModel = createModel(context, () => PPoliticaModel());
    pExcluirContaModel = createModel(context, () => PExcluirContaModel());
    pCheckoutModel = createModel(context, () => PCheckoutModel());
    novasenhaVisibility = false;
  }

  @override
  void dispose() {
    pHeaderLogoModel.dispose();
    pFeedbackModel.dispose();
    pPoliticaModel.dispose();
    pExcluirContaModel.dispose();
    pCheckoutModel.dispose();
    textFieldFocusNode?.dispose();
    textController1?.dispose();

    inputEmailFocusNode?.dispose();
    inputEmailTextController?.dispose();

    novasenhaFocusNode?.dispose();
    novasenhaTextController?.dispose();
  }
}

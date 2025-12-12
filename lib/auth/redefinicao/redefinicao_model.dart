import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/p_aviso/p_aviso_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'redefinicao_widget.dart' show RedefinicaoWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RedefinicaoModel extends FlutterFlowModel<RedefinicaoWidget> {
  ///  Local state fields for this page.

  String step = 'email';

  ///  State fields for stateful widgets in this page.

  final formKey2 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // Stores action output result for [Validate Form] action in Button widget.
  bool? ok;
  // Stores action output result for [Backend Call - API (Send email reset senha)] action in Button widget.
  ApiCallResponse? apiResultely;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Stores action output result for [Validate Form] action in Button widget.
  bool? okx;
  // Stores action output result for [Backend Call - API (Validar Codigo Reset)] action in Button widget.
  ApiCallResponse? apiResultxlq;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}

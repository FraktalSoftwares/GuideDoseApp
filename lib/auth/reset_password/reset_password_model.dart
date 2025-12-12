import '/backend/api_requests/api_calls.dart';
import '/components/comp_senha/comp_senha_widget.dart';
import '/components/p_aviso/p_aviso_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'reset_password_widget.dart' show ResetPasswordWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ResetPasswordModel extends FlutterFlowModel<ResetPasswordWidget> {
  ///  Local state fields for this page.

  List<String> firstPassword = ['0'];
  void addToFirstPassword(String item) => firstPassword.add(item);
  void removeFromFirstPassword(String item) => firstPassword.remove(item);
  void removeAtIndexFromFirstPassword(int index) =>
      firstPassword.removeAt(index);
  void insertAtIndexInFirstPassword(int index, String item) =>
      firstPassword.insert(index, item);
  void updateFirstPasswordAtIndex(int index, Function(String) updateFn) =>
      firstPassword[index] = updateFn(firstPassword[index]);

  List<String> secondPassword = ['0'];
  void addToSecondPassword(String item) => secondPassword.add(item);
  void removeFromSecondPassword(String item) => secondPassword.remove(item);
  void removeAtIndexFromSecondPassword(int index) =>
      secondPassword.removeAt(index);
  void insertAtIndexInSecondPassword(int index, String item) =>
      secondPassword.insert(index, item);
  void updateSecondPasswordAtIndex(int index, Function(String) updateFn) =>
      secondPassword[index] = updateFn(secondPassword[index]);

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  late bool passwordVisibility1;
  String? Function(BuildContext, String?)? textController1Validator;
  // Stores action output result for [Custom Action - checkPasswordRequirements] action in TextField widget.
  List<String>? resultFirst;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  late bool passwordVisibility2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Stores action output result for [Custom Action - checkPasswordRequirements] action in TextField widget.
  List<String>? resultSecond;
  // Stores action output result for [Validate Form] action in Button widget.
  bool? ok;
  // Stores action output result for [Backend Call - API (Reset senha)] action in Button widget.
  ApiCallResponse? apiResultgx7;

  @override
  void initState(BuildContext context) {
    passwordVisibility1 = false;
    passwordVisibility2 = false;
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}

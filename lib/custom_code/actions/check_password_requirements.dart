// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<String>> checkPasswordRequirements(String password) async {
  List<String> errors = [];

  if (password.length < 8) {
    errors.add("A senha deve ter no mínimo 8 caracteres");
  }
  if (!password.contains(RegExp(r'[A-Z]'))) {
    errors.add("Deve conter pelo menos uma letra maiúscula");
  }
  if (!password.contains(RegExp(r'[a-z]'))) {
    errors.add("Deve conter pelo menos uma letra minúscula");
  }
  if (!password.contains(RegExp(r'[0-9]'))) {
    errors.add("Deve conter pelo menos um número");
  }
  if (!password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-+=]'))) {
    errors.add("Deve conter pelo menos um caractere especial");
  }

  return errors;
}

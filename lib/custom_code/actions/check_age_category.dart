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

String checkAgeCategory(int age, String language) {
  if (age < 0) {
    return {
          'Português': 'Idade inválida',
          'English': 'Invalid age',
          'Español': 'Edad inválida',
        }[language] ??
        'Idade inválida';
  } else if (age <= 12) {
    return {
          'Português': 'Criança',
          'English': 'Child',
          'Español': 'Niño',
        }[language] ??
        'Criança';
  } else if (age <= 17) {
    return {
          'Português': 'Adolescente',
          'English': 'Teenager',
          'Español': 'Adolescente',
        }[language] ??
        'Adolescente';
  } else if (age <= 59) {
    return {
          'Português': 'Adulto',
          'English': 'Adult',
          'Español': 'Adulto',
        }[language] ??
        'Adulto';
  } else {
    return {
          'Português': 'Idoso',
          'English': 'Elderly',
          'Español': 'Anciano',
        }[language] ??
        'Idoso';
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

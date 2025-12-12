import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'backend/supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      if (prefs.containsKey('ff_User')) {
        try {
          final serializedData = prefs.getString('ff_User') ?? '{}';
          _User = UserStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _menu = prefs.getString('ff_menu') ?? _menu;
    });
    _safeInit(() {
      _modulo = prefs.getString('ff_modulo') ?? _modulo;
    });
    _safeInit(() {
      _paisSelecionado =
          prefs.getString('ff_paisSelecionado') ?? _paisSelecionado;
    });
    _safeInit(() {
      _countryCode = prefs.getString('ff_countryCode') ?? _countryCode;
    });
    _safeInit(() {
      _generoSelecionado =
          prefs.getString('ff_generoSelecionado') ?? _generoSelecionado;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  UserStruct _User = UserStruct();
  UserStruct get User => _User;
  set User(UserStruct value) {
    _User = value;
    prefs.setString('ff_User', value.serialize());
  }

  void updateUserStruct(Function(UserStruct) updateFn) {
    updateFn(_User);
    prefs.setString('ff_User', _User.serialize());
  }

  String _menu = 'inducao';
  String get menu => _menu;
  set menu(String value) {
    _menu = value;
    prefs.setString('ff_menu', value);
  }

  String _modulo = 'Dose de Indução';
  String get modulo => _modulo;
  set modulo(String value) {
    _modulo = value;
    prefs.setString('ff_modulo', value);
  }

  String _paisSelecionado = '';
  String get paisSelecionado => _paisSelecionado;
  set paisSelecionado(String value) {
    _paisSelecionado = value;
    prefs.setString('ff_paisSelecionado', value);
  }

  String _countryCode = '';
  String get countryCode => _countryCode;
  set countryCode(String value) {
    _countryCode = value;
    prefs.setString('ff_countryCode', value);
  }

  String _generoSelecionado = '';
  String get generoSelecionado => _generoSelecionado;
  set generoSelecionado(String value) {
    _generoSelecionado = value;
    prefs.setString('ff_generoSelecionado', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

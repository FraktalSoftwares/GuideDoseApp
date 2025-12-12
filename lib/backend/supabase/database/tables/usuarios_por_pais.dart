import '../database.dart';

class UsuariosPorPaisTable extends SupabaseTable<UsuariosPorPaisRow> {
  @override
  String get tableName => 'usuarios_por_pais';

  @override
  UsuariosPorPaisRow createRow(Map<String, dynamic> data) =>
      UsuariosPorPaisRow(data);
}

class UsuariosPorPaisRow extends SupabaseDataRow {
  UsuariosPorPaisRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UsuariosPorPaisTable();

  String? get pais => getField<String>('pais');
  set pais(String? value) => setField<String>('pais', value);

  int? get totalUsuarios => getField<int>('total_usuarios');
  set totalUsuarios(int? value) => setField<int>('total_usuarios', value);

  DateTime? get primeiroRegistro => getField<DateTime>('primeiro_registro');
  set primeiroRegistro(DateTime? value) =>
      setField<DateTime>('primeiro_registro', value);

  DateTime? get ultimoRegistro => getField<DateTime>('ultimo_registro');
  set ultimoRegistro(DateTime? value) =>
      setField<DateTime>('ultimo_registro', value);
}

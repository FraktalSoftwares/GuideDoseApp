import '../database.dart';

class UserPermissoesTable extends SupabaseTable<UserPermissoesRow> {
  @override
  String get tableName => 'user_permissoes';

  @override
  UserPermissoesRow createRow(Map<String, dynamic> data) =>
      UserPermissoesRow(data);
}

class UserPermissoesRow extends SupabaseDataRow {
  UserPermissoesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UserPermissoesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  bool? get acessoDashboard => getField<bool>('acesso_dashboard');
  set acessoDashboard(bool? value) => setField<bool>('acesso_dashboard', value);

  bool? get editarFeedback => getField<bool>('editar_feedback');
  set editarFeedback(bool? value) => setField<bool>('editar_feedback', value);

  bool? get gerenciarEquipe => getField<bool>('gerenciar_equipe');
  set gerenciarEquipe(bool? value) => setField<bool>('gerenciar_equipe', value);

  bool? get gerenciarUserApp => getField<bool>('gerenciar_user_app');
  set gerenciarUserApp(bool? value) =>
      setField<bool>('gerenciar_user_app', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get usrEmail => getField<String>('usr_email');
  set usrEmail(String? value) => setField<String>('usr_email', value);
}

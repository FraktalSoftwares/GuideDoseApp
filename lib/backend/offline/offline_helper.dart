import '/backend/supabase/supabase.dart';
import 'sync_manager.dart';
import 'offline_database.dart';

class OfflineHelper {
  static Future<List<Map<String, dynamic>>> loadMedicamentos(
      String searchText) async {
    final syncManager = SyncManager.instance;
    final search = searchText.toLowerCase();

    if (syncManager.isOnline) {
      try {
        final rows = await VwMedicamentosOrdernadosTable().queryRows(
          queryFn: (q) => q
              .ilike('nome_chave', '%$search%')
              .order('favorito_flag')
              .order('nome_chave', ascending: true),
        );
        return rows
            .map((r) => {
                  'remote_id': r.id,
                  'nome': r.ptNomePrincipioAtivo,
                  'nome_en': r.usNomePrincipioAtivo,
                  'nome_es': r.esNomePrincipioAtivo,
                  'is_favorite': r.favoritoFlag == true ? 1 : 0,
                })
            .toList();
      } catch (e) {
        print('Erro ao buscar medicamentos online: $e');
        return await OfflineDatabase.instance.getAllMedicamentos();
      }
    } else {
      final allMeds = await OfflineDatabase.instance.getAllMedicamentos();
      if (search.isEmpty) return allMeds;

      return allMeds.where((med) {
        final nome = (med['nome'] ?? '').toString().toLowerCase();
        return nome.contains(search);
      }).toList();
    }
  }

  static Future<List<Map<String, dynamic>>> loadInducoes(
      String searchText) async {
    final syncManager = SyncManager.instance;
    final search = searchText.toLowerCase();

    if (syncManager.isOnline) {
      try {
        final rows = await VwInducoesOrdenadasTable().queryRows(
          queryFn: (q) => q
              .ilike('ind_nome', '%$search%')
              .order('favorito_flag')
              .order('ind_nome', ascending: true),
        );
        return rows
            .map((r) => {
                  'remote_id': r.id,
                  'nome': r.indNome,
                  'nome_en': r.indNomeEn,
                  'nome_es': r.indNomeEs,
                  'is_favorite': r.favoritoFlag == true ? 1 : 0,
                })
            .toList();
      } catch (e) {
        print('Erro ao buscar induções online: $e');
        return await OfflineDatabase.instance.getAllInducoes();
      }
    } else {
      final allInds = await OfflineDatabase.instance.getAllInducoes();
      if (search.isEmpty) return allInds;

      return allInds.where((ind) {
        final nome = (ind['nome'] ?? '').toString().toLowerCase();
        return nome.contains(search);
      }).toList();
    }
  }
}

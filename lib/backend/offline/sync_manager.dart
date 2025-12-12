import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'offline_database.dart';

class SyncManager {
  static final SyncManager instance = SyncManager._init();

  SyncManager._init();

  final _connectivity = Connectivity();
  final _offlineDb = OfflineDatabase.instance;
  final _supabase = Supabase.instance.client;

  StreamController<bool> _onlineStatusController =
      StreamController<bool>.broadcast();
  Stream<bool> get onlineStatus => _onlineStatusController.stream;

  bool _isOnline = true;
  bool get isOnline => _isOnline;

  Timer? _syncTimer;

  Future<void> initialize() async {
    // Verifica status inicial
    await _checkConnectivity();

    // Monitora mudanças de conectividade
    _connectivity.onConnectivityChanged.listen((result) {
      _checkConnectivity();
    });

    // Sincroniza a cada 5 minutos quando online
    _syncTimer = Timer.periodic(Duration(minutes: 5), (timer) {
      if (_isOnline) {
        syncData();
      }
    });
  }

  Future<void> _checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    final wasOnline = _isOnline;
    _isOnline = result != ConnectivityResult.none;

    if (_isOnline != wasOnline) {
      _onlineStatusController.add(_isOnline);

      if (_isOnline) {
        // Voltou online, sincroniza
        await syncData();
      }
    }
  }

  /// Sincroniza dados do Supabase para o cache local
  Future<void> syncData() async {
    if (!_isOnline) return;

    try {
      // Sincroniza medicamentos
      await _syncMedicamentos();

      // Sincroniza induções
      await _syncInducoes();

      // Sincroniza favoritos pendentes
      await _syncPendingFavorites();

      print('✅ Sincronização concluída');
    } catch (e) {
      print('❌ Erro na sincronização: $e');
    }
  }

  Future<void> _syncMedicamentos() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      // Busca medicamentos do Supabase
      final response = await _supabase
          .from('vw_medicamentos_ordernados')
          .select()
          .eq('user_id', userId);

      // Salva no cache local
      for (var item in response) {
        await _offlineDb.insertMedicamento({
          'remote_id': item['id'],
          'nome': item['nome'] ?? '',
          'nome_en': item['nome_en'],
          'nome_es': item['nome_es'],
          'descricao': item['descricao'],
          'descricao_en': item['descricao_en'],
          'descricao_es': item['descricao_es'],
          'categoria': item['categoria'],
          'is_favorite': item['is_favorite'] == true ? 1 : 0,
          'last_sync': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      print('Erro ao sincronizar medicamentos: $e');
    }
  }

  Future<void> _syncInducoes() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      // Busca induções do Supabase
      final response = await _supabase
          .from('vw_inducoes_ordenadas')
          .select()
          .eq('user_id', userId);

      // Salva no cache local
      for (var item in response) {
        await _offlineDb.insertInducao({
          'remote_id': item['id'],
          'nome': item['nome'] ?? '',
          'nome_en': item['nome_en'],
          'nome_es': item['nome_es'],
          'descricao': item['descricao'],
          'descricao_en': item['descricao_en'],
          'descricao_es': item['descricao_es'],
          'categoria': item['categoria'],
          'is_favorite': item['is_favorite'] == true ? 1 : 0,
          'last_sync': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      print('Erro ao sincronizar induções: $e');
    }
  }

  Future<void> _syncPendingFavorites() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      final pending = await _offlineDb.getPendingFavorites();

      for (var item in pending) {
        try {
          final table = item['type'] == 'medicamento'
              ? 'medicamentos_fav'
              : 'inducoes_fav';

          if (item['action'] == 'add') {
            await _supabase.from(table).insert({
              'user_id': userId,
              '${item['type']}_id': item['item_id'],
            });
          } else if (item['action'] == 'remove') {
            await _supabase
                .from(table)
                .delete()
                .eq('user_id', userId)
                .eq('${item['type']}_id', item['item_id']);
          }

          // Remove da fila de pendentes
          await _offlineDb.deletePendingFavorite(item['id']);
        } catch (e) {
          print('Erro ao sincronizar favorito: $e');
        }
      }
    } catch (e) {
      print('Erro ao sincronizar favoritos pendentes: $e');
    }
  }

  /// Adiciona favorito (funciona offline)
  Future<void> addFavorite(String type, int itemId) async {
    // Atualiza cache local imediatamente
    if (type == 'medicamento') {
      await _offlineDb.updateMedicamentoFavorite(itemId, true);
    } else {
      await _offlineDb.updateInducaoFavorite(itemId, true);
    }

    if (_isOnline) {
      // Se online, sincroniza imediatamente
      try {
        final userId = _supabase.auth.currentUser?.id;
        if (userId != null) {
          final table =
              type == 'medicamento' ? 'medicamentos_fav' : 'inducoes_fav';
          await _supabase.from(table).insert({
            'user_id': userId,
            '${type}_id': itemId,
          });
        }
      } catch (e) {
        // Se falhar, adiciona à fila
        await _offlineDb.addPendingFavorite(type, itemId, 'add');
      }
    } else {
      // Se offline, adiciona à fila
      await _offlineDb.addPendingFavorite(type, itemId, 'add');
    }
  }

  /// Remove favorito (funciona offline)
  Future<void> removeFavorite(String type, int itemId) async {
    // Atualiza cache local imediatamente
    if (type == 'medicamento') {
      await _offlineDb.updateMedicamentoFavorite(itemId, false);
    } else {
      await _offlineDb.updateInducaoFavorite(itemId, false);
    }

    if (_isOnline) {
      // Se online, sincroniza imediatamente
      try {
        final userId = _supabase.auth.currentUser?.id;
        if (userId != null) {
          final table =
              type == 'medicamento' ? 'medicamentos_fav' : 'inducoes_fav';
          await _supabase
              .from(table)
              .delete()
              .eq('user_id', userId)
              .eq('${type}_id', itemId);
        }
      } catch (e) {
        // Se falhar, adiciona à fila
        await _offlineDb.addPendingFavorite(type, itemId, 'remove');
      }
    } else {
      // Se offline, adiciona à fila
      await _offlineDb.addPendingFavorite(type, itemId, 'remove');
    }
  }

  void dispose() {
    _syncTimer?.cancel();
    _onlineStatusController.close();
  }
}

import 'dart:async';
import 'dart:convert';
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
    // Garante que a tabela de subtópicos existe
    await _ensureSubtopicosTableExists();

    // Verifica status inicial
    await _checkConnectivity();

    // Sincroniza imediatamente se estiver online
    if (_isOnline) {
      print('Iniciando sincronizacao automatica...');
      syncData();
    }

    // Monitora mudanças de conectividade
    _connectivity.onConnectivityChanged.listen((result) {
      _checkConnectivity();
    });

    // Sincroniza a cada 5 minutos quando online
    _syncTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      if (_isOnline) {
        syncData();
      }
    });
  }

  Future<void> _ensureSubtopicosTableExists() async {
    try {
      final db = await _offlineDb.database;

      // Verifica se a tabela existe
      final tables = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='inducoes_subtopicos'");

      if (tables.isEmpty) {
        print('⚠️ Tabela inducoes_subtopicos não existe, criando...');

        // Cria a tabela
        await db.execute('''
          CREATE TABLE inducoes_subtopicos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            remote_id INTEGER NOT NULL,
            ind_id INTEGER NOT NULL,
            ind_topico TEXT,
            ind_titulos TEXT,
            ind_titulos_en TEXT,
            ind_titulos_es TEXT,
            ind_descricao TEXT,
            ind_descricao_en TEXT,
            ind_descricao_es TEXT,
            last_sync TEXT NOT NULL
          )
        ''');

        await db.execute(
            'CREATE INDEX idx_subtopicos_ind_id ON inducoes_subtopicos(ind_id)');

        print('✅ Tabela inducoes_subtopicos criada com sucesso!');
      } else {
        print('✅ Tabela inducoes_subtopicos já existe');
      }
    } catch (e) {
      print('❌ Erro ao verificar/criar tabela de subtópicos: $e');
    }
  }

  Future<void> _checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    final wasOnline = _isOnline;
    // connectivity_plus retorna List<ConnectivityResult>
    _isOnline = !result.contains(ConnectivityResult.none);

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

      // Sincroniza dados do usuário pendentes
      await _syncPendingUserData();

      print('✅ Sincronização concluída');
    } catch (e) {
      print('❌ Erro na sincronização: $e');
    }
  }

  Future<void> _syncMedicamentos() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        print('❌ User ID null - não sincronizou medicamentos');
        return;
      }

      print('🔄 Sincronizando medicamentos...');
      print('👤 User ID: $userId');

      // Busca TODOS os medicamentos do Supabase
      // A view já filtra por usuário para mostrar favoritos
      final response =
          await _supabase.from('vw_medicamentos_ordernados').select();

      print('📦 Encontrados ${response.length} medicamentos');
      if (response.isNotEmpty) {
        print(
            '📋 Exemplo de campos do primeiro medicamento: ${response.first.keys.toList()}');
      }

      // Limpa cache antigo
      final db = await _offlineDb.database;
      await db.delete('medicamentos');

      // Salva no cache local
      for (var item in response) {
        // Verifica se é favorito do usuário atual
        final isFavorite =
            item['fav_user_id'] == userId && (item['favorito_flag'] ?? 0) > 0;

        await _offlineDb.insertMedicamento({
          'remote_id': item['id'],
          'nome': item['pt_nome_principio_ativo'] ?? '',
          'nome_en': item['us_nome_principio_ativo'],
          'nome_es': item['es_nome_principio_ativo'],
          'descricao': item['pt_classificacao'],
          'descricao_en': item['us_classificacao'],
          'descricao_es': item['es_classificacao'],
          'categoria': item['pt_classificacao'],
          'is_favorite': isFavorite ? 1 : 0,
          'last_sync': DateTime.now().toIso8601String(),
          // TODOS os campos de detalhes
          'pt_nome_principio_ativo': item['pt_nome_principio_ativo'],
          'us_nome_principio_ativo': item['us_nome_principio_ativo'],
          'es_nome_principio_ativo': item['es_nome_principio_ativo'],
          'pt_nome_comercial': item['pt_nome_comercial'],
          'us_nome_comercial': item['us_nome_comercial'],
          'es_nome_comercial': item['es_nome_comercial'],
          'pt_classificacao': item['pt_classificacao'],
          'us_classificacao': item['us_classificacao'],
          'es_classificacao': item['es_classificacao'],
          'pt_mecanismo_acao': item['pt_mecanismo_acao'],
          'us_mecanismo_acao': item['us_mecanismo_acao'],
          'es_mecanismo_acao': item['es_mecanismo_acao'],
          'pt_farmacocinetica': item['pt_farmacocinetica'],
          'us_farmacocinetica': item['us_farmacocinetica'],
          'es_farmacocinetica': item['es_farmacocinetica'],
          'pt_indicacoes': item['pt_indicacoes'],
          'us_indicacoes': item['us_indicacoes'],
          'es_indicacoes': item['es_indicacoes'],
          'pt_posologia': item['pt_posologia'],
          'us_posologia': item['us_posologia'],
          'es_posologia': item['es_posologia'],
          'pt_dose_minima': item['pt_dose_minima'],
          'us_dose_minima': item['us_dose_minima'],
          'es_dose_minima': item['es_dose_minima'],
          'pt_dose_maxima': item['pt_dose_maxima'],
          'us_dose_maxima': item['us_dose_maxima'],
          'es_dose_maxima': item['es_dose_maxima'],
          'pt_administracao': item['pt_administracao'],
          'us_administracao': item['us_administracao'],
          'es_administracao': item['es_administracao'],
          'pt_ajuste_renal': item['pt_ajuste_renal'],
          'us_ajuste_renal': item['us_ajuste_renal'],
          'es_ajuste_renal': item['es_ajuste_renal'],
          'pt_apresentacao': item['pt_apresentacao'],
          'us_apresentacao': item['us_apresentacao'],
          'es_apresentacao': item['es_apresentacao'],
          'pt_preparo': item['pt_preparo'],
          'us_preparo': item['us_preparo'],
          'es_preparo': item['es_preparo'],
          'pt_inicio_acao': item['pt_inicio_acao'],
          'us_inicio_acao': item['us_inicio_acao'],
          'es_inicio_acao': item['es_inicio_acao'],
          'pt_tempo_pico': item['pt_tempo_pico'],
          'us_tempo_pico': item['us_tempo_pico'],
          'es_tempo_pico': item['es_tempo_pico'],
          'pt_meia_vida': item['pt_meia_vida'],
          'us_meia_vida': item['us_meia_vida'],
          'es_meia_vida': item['es_meia_vida'],
        });
      }

      print('✅ Medicamentos sincronizados!');
    } catch (e) {
      print('❌ Erro ao sincronizar medicamentos: $e');
    }
  }

  Future<void> _syncInducoes() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        print('❌ User ID null - não sincronizou induções');
        return;
      }

      print('🔄 Sincronizando induções...');
      print('👤 User ID: $userId');

      // Busca TODAS as induções do Supabase
      // A view já filtra por usuário para mostrar favoritos
      final response = await _supabase.from('vw_inducoes_ordenadas').select();

      print('📦 Encontradas ${response.length} induções');
      if (response.isNotEmpty) {
        print(
            '📋 Exemplo de campos da primeira indução: ${response.first.keys.toList()}');
        print(
            '📋 Primeira indução: ID=${response.first['id']}, Nome=${response.first['ind_nome']}');
      }

      // Limpa cache antigo
      final db = await _offlineDb.database;
      await db.delete('inducoes');

      // Salva no cache local
      int count = 0;
      for (var item in response) {
        // Verifica se é favorito do usuário atual
        final isFavorite =
            item['fav_user_id'] == userId && (item['favorito_flag'] ?? 0) > 0;

        final dataToInsert = {
          'remote_id': item['id'],
          'nome': item['ind_nome'] ?? '',
          'nome_en': item['ind_nome_en'],
          'nome_es': item['ind_nome_es'],
          'descricao': item['ind_definicao'],
          'descricao_en': item['definicao_en'],
          'descricao_es': item['definicao_es'],
          'categoria': item['ind_definicao'],
          'is_favorite': isFavorite ? 1 : 0,
          'last_sync': DateTime.now().toIso8601String(),
          // TODOS os campos de detalhes
          'ind_nome': item['ind_nome'],
          'ind_nome_en': item['ind_nome_en'],
          'ind_nome_es': item['ind_nome_es'],
          'ind_definicao': item['ind_definicao'],
          'definicao_en': item['definicao_en'],
          'definicao_es': item['definicao_es'],
          'ind_epidemiologia': item['ind_epidemiologia'],
          'epidemiologia_en': item['epidemiologia_en'],
          'epidemiologia_es': item['epidemiologia_es'],
          'ind_fisiopatologia': item['ind_fisiopatologia'],
          'fisiopatologia_en': item['fisiopatologia_en'],
          'fisiopatologia_es': item['fisiopatologia_es'],
        };

        await _offlineDb.insertInducao(dataToInsert);
        count++;

        if (count == 1) {
          print('📝 Exemplo de indução salva:');
          print('   ID: ${dataToInsert['remote_id']}');
          print('   nome: ${dataToInsert['nome']}');
          print('   ind_nome: ${dataToInsert['ind_nome']}');
          print('   ind_definicao: ${dataToInsert['ind_definicao']}');
        }
      }

      print('💾 Salvou $count induções no cache');

      // Sincroniza subtópicos das induções
      await _syncInducoesSubtopicos();

      // Sincroniza accordion das induções
      await _syncAccordeonInducao();

      // Sincroniza accordion dos medicamentos
      await _syncAccordeonMedicamento();

      print('✅ Induções sincronizadas!');
    } catch (e) {
      print('❌ Erro ao sincronizar induções: $e');
    }
  }

  Future<void> _syncInducoesSubtopicos() async {
    try {
      print('🔄 Sincronizando subtópicos das induções...');

      // Busca TODOS os subtópicos do Supabase
      final response = await _supabase.from('vw_inducoes_subtopicos').select();

      print('📦 Encontrados ${response.length} subtópicos');
      if (response.isNotEmpty) {
        print('📋 Exemplo de subtópico: ${response.first}');
      }

      // Limpa cache antigo de subtópicos
      final db = await _offlineDb.database;
      await db.delete('inducoes_subtopicos');

      // Salva no cache local
      int count = 0;
      for (var item in response) {
        // A view não tem 'id', usa ind_id + ind_topico como identificador único
        final dataToInsert = {
          'remote_id': count + 1, // Gera um ID sequencial local
          'ind_id': item['ind_id'],
          'ind_topico': item['ind_topico'],
          'ind_titulos': item['ind_titulos'],
          'ind_titulos_en': item['ind_titulos_en'],
          'ind_titulos_es': item['ind_titulos_es'],
          'ind_descricao': item['conteudos_pt'], // Campo correto da view
          'ind_descricao_en': item['conteudos_en'],
          'ind_descricao_es': item['conteudos_es'],
          'last_sync': DateTime.now().toIso8601String(),
        };

        await _offlineDb.insertSubtopico(dataToInsert);
        count++;
      }

      print('💾 Salvou $count subtópicos no cache');
      print('✅ Subtópicos sincronizados!');
    } catch (e) {
      print('❌ Erro ao sincronizar subtópicos: $e');
    }
  }

  Future<void> _syncAccordeonInducao() async {
    try {
      print('🔄 Sincronizando accordion das induções...');

      // Busca TODOS os dados do accordion do Supabase
      final response = await _supabase.from('accordeon_inducao').select();

      print('📦 Encontrados ${response.length} itens do accordion');
      if (response.isNotEmpty) {
        print('📋 Exemplo de item do accordion: ${response.first}');
      }

      // Limpa cache antigo do accordion
      final db = await _offlineDb.database;
      await db.delete('accordeon_inducao');

      // Salva no cache local
      int count = 0;
      for (var item in response) {
        final dataToInsert = {
          'remote_id': item['id'],
          'inducao_id': item['inducao_id'],
          'med_nome': item['med_nome'] ?? '',
          'med_nome_en': item['med_nome_en'],
          'med_nome_es': item['med_nome_es'],
          'dose_mg_kg': item['dose_mg_kg'] ?? 0.0,
          'concentracao_mg_ml': item['concentracao_mg_ml'] ?? 0.0,
          'last_sync': DateTime.now().toIso8601String(),
        };

        await _offlineDb.insertAccordeonInducao(dataToInsert);
        count++;
      }

      print('💾 Salvou $count itens do accordion no cache');
      print('✅ Accordion sincronizado!');
    } catch (e) {
      print('❌ Erro ao sincronizar accordion: $e');
    }
  }

  Future<void> _syncAccordeonMedicamento() async {
    try {
      print('🔄 Sincronizando accordion dos medicamentos...');

      // Busca TODOS os dados com paginação (Supabase limita em 1000 por request)
      List<dynamic> allData = [];
      int pageSize = 1000;
      int offset = 0;
      bool hasMore = true;

      while (hasMore) {
        final response = await _supabase
            .from('v_medicamento_itens_detalhados')
            .select()
            .range(offset, offset + pageSize - 1);

        allData.addAll(response);
        print('Pagina ${offset ~/ pageSize + 1}: ${response.length} registros');

        if (response.length < pageSize) {
          hasMore = false;
        } else {
          offset += pageSize;
        }
      }

      print('=== TOTAL BUSCADO: ${allData.length} ===');

      // Conta medicamento 4 ANTES de salvar
      final med4InResponse =
          allData.where((item) => item['medicamento_id'] == 4).length;
      print('=== MED 4 NO SUPABASE: $med4InResponse ===');

      // Limpa cache antigo do accordion
      final db = await _offlineDb.database;
      final deletedRows = await db.delete('accordeon_medicamento');
      print('Deletados $deletedRows registros antigos');

      // Salva no cache local
      int count = 0;
      int med4Count = 0;
      for (var item in allData) {
        if (item['medicamento_id'] == 4) {
          med4Count++;
          if (med4Count <= 3) {
            print('Salvando MED 4: ${item['topico']} - ${item['titulo']}');
          }
        }
        // Converte dados_calculo para JSON string se não for null
        String? dadosCalculoStr;
        if (item['dados_calculo'] != null) {
          // Se já é string, usa direto; se é objeto, converte para JSON
          if (item['dados_calculo'] is String) {
            dadosCalculoStr = item['dados_calculo'];
          } else {
            dadosCalculoStr = jsonEncode(item['dados_calculo']);
          }

          // Debug SliderConfig
          if (item['topico'] == 'SliderConfig' && item['medicamento_id'] == 4) {
            print('SliderConfig MED 4: $dadosCalculoStr');
          }
        }

        final dataToInsert = {
          'remote_id': item['id'] ?? '',
          'medicamento_id': item['medicamento_id'],
          'topico': item['topico'] ?? '',
          'ordem': item['ordem'],
          'titulo': item['titulo'],
          'subtitulo': item['subtitulo'],
          'concentracao': item['concentracao'],
          'unidade_calculo': item['unidade_calculo'],
          'dose_min': item['dose_min'],
          'dose_max': item['dose_max'],
          'dose_teto': item['dose_teto'],
          'contexto': item['contexto'],
          'tipo_indicacao': item['tipo_indicacao'],
          'dados_calculo': dadosCalculoStr,
          'last_sync': DateTime.now().toIso8601String(),
        };

        await _offlineDb.insertAccordeonMedicamento(dataToInsert);
        count++;

        // Debug: mostra alguns exemplos
        if (count <= 3 || item['medicamento_id'] == 4) {
          print(
              'Salvando: med_id=${item['medicamento_id']} (${dataToInsert['medicamento_id']}), topico=${item['topico']}, titulo=${item['titulo']}');
        }

        // Verifica se medicamento_id é null
        if (dataToInsert['medicamento_id'] == null) {
          print('ERRO: medicamento_id NULL para item ${item['id']}');
        }
      }

      print('=== TOTAL SALVO: $count ===');
      print('=== MED 4 SALVO: $med4Count ===');

      // Verifica se realmente salvou
      final checkMed4 = await db.rawQuery(
          'SELECT COUNT(*) as total FROM accordeon_medicamento WHERE medicamento_id = 4');
      print('=== MED 4 NO BANCO: ${checkMed4.first['total']} ===');
    } catch (e) {
      print('Erro ao sincronizar accordion de medicamentos: $e');
      print('Stack trace: ${e.toString()}');
    }
  }

  Future<void> _syncPendingFavorites() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      final pending = await _offlineDb.getPendingFavorites();

      for (var item in pending) {
        try {
          final type = item['type'];
          final table =
              type == 'medicamento' ? 'medicamentos_fav' : 'inducoes_fav';
          final idField = type == 'medicamento' ? 'med_id' : 'ind_id';
          final userField = type == 'medicamento' ? 'user_id' : 'ind_usr_id';

          if (item['action'] == 'add') {
            await _supabase.from(table).insert({
              userField: userId,
              idField: item['item_id'],
            });
          } else if (item['action'] == 'remove') {
            await _supabase
                .from(table)
                .delete()
                .eq(userField, userId)
                .eq(idField, item['item_id']);
          }

          // Remove da fila de pendentes
          await _offlineDb.deletePendingFavorite(item['id']);
          print('✅ Favorito pendente sincronizado: $type #${item['item_id']}');
        } catch (e) {
          print('❌ Erro ao sincronizar favorito: $e');
        }
      }
    } catch (e) {
      print('❌ Erro ao sincronizar favoritos pendentes: $e');
    }
  }

  Future<void> _syncPendingUserData() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      final pending = await _offlineDb.getPendingUserDataSync();

      for (var item in pending) {
        try {
          await _supabase.from('usuarios').update({
            'usr_kgs': item['usr_kgs'],
            'usr_altura': item['usr_altura'],
            'usr_idade': int.tryParse(item['usr_idade'] ?? '0'),
            'usr_faixa_etaria': item['usr_faixa'],
            'usr_genero': item['usr_genero'],
            'anosMeses': item['usr_anos_meses'],
          }).eq('id', userId);

          // Marca como sincronizado
          await _offlineDb.markUserDataSynced(userId);
          print('✅ Dados do usuário sincronizados com Supabase');
        } catch (e) {
          print('❌ Erro ao sincronizar dados do usuário: $e');
        }
      }
    } catch (e) {
      print('❌ Erro ao sincronizar dados pendentes do usuário: $e');
    }
  }

  /// Adiciona favorito (funciona offline)
  Future<void> addFavorite(String type, int itemId) async {
    print('🔄 Adicionando favorito: $type #$itemId');

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
          // Campos corretos: med_id e ind_id
          final table =
              type == 'medicamento' ? 'medicamentos_fav' : 'inducoes_fav';
          final idField = type == 'medicamento' ? 'med_id' : 'ind_id';
          final userField = type == 'medicamento' ? 'user_id' : 'ind_usr_id';

          await _supabase.from(table).insert({
            userField: userId,
            idField: itemId,
          });

          print('✅ Favorito adicionado no Supabase');
        }
      } catch (e) {
        print('❌ Erro ao adicionar favorito online: $e');
        // Se falhar, adiciona à fila
        await _offlineDb.addPendingFavorite(type, itemId, 'add');
      }
    } else {
      // Se offline, adiciona à fila
      await _offlineDb.addPendingFavorite(type, itemId, 'add');
      print('📝 Favorito adicionado à fila (offline)');
    }
  }

  /// Remove favorito (funciona offline)
  Future<void> removeFavorite(String type, int itemId) async {
    print('🔄 Removendo favorito: $type #$itemId');

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
          // Campos corretos: med_id e ind_id
          final table =
              type == 'medicamento' ? 'medicamentos_fav' : 'inducoes_fav';
          final idField = type == 'medicamento' ? 'med_id' : 'ind_id';
          final userField = type == 'medicamento' ? 'user_id' : 'ind_usr_id';

          await _supabase
              .from(table)
              .delete()
              .eq(userField, userId)
              .eq(idField, itemId);

          print('✅ Favorito removido do Supabase');
        }
      } catch (e) {
        print('❌ Erro ao remover favorito online: $e');
        // Se falhar, adiciona à fila
        await _offlineDb.addPendingFavorite(type, itemId, 'remove');
      }
    } else {
      // Se offline, adiciona à fila
      await _offlineDb.addPendingFavorite(type, itemId, 'remove');
      print('📝 Favorito removido da fila (offline)');
    }
  }

  void dispose() {
    _syncTimer?.cancel();
    _onlineStatusController.close();
  }
}

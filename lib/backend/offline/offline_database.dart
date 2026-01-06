import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

class OfflineDatabase {
  static final OfflineDatabase instance = OfflineDatabase._init();
  static Database? _database;

  OfflineDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('guidedose_offline.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 8,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Adiciona TODOS os campos de detalhes aos medicamentos (v1 -> v2)
      final medicamentosFieldsToAdd = [
        'pt_nome_comercial',
        'us_nome_comercial',
        'es_nome_comercial',
        'pt_classificacao',
        'us_classificacao',
        'es_classificacao',
        'pt_mecanismo_acao',
        'us_mecanismo_acao',
        'es_mecanismo_acao',
        'pt_farmacocinetica',
        'us_farmacocinetica',
        'es_farmacocinetica',
        'pt_indicacoes',
        'us_indicacoes',
        'es_indicacoes',
        'pt_posologia',
        'us_posologia',
        'es_posologia',
        'pt_dose_minima',
        'us_dose_minima',
        'es_dose_minima',
        'pt_dose_maxima',
        'us_dose_maxima',
        'es_dose_maxima',
        'pt_administracao',
        'us_administracao',
        'es_administracao',
        'pt_ajuste_renal',
        'us_ajuste_renal',
        'es_ajuste_renal',
        'pt_apresentacao',
        'us_apresentacao',
        'es_apresentacao',
        'pt_preparo',
        'us_preparo',
        'es_preparo',
        'pt_inicio_acao',
        'us_inicio_acao',
        'es_inicio_acao',
        'pt_tempo_pico',
        'us_tempo_pico',
        'es_tempo_pico',
        'pt_meia_vida',
        'us_meia_vida',
        'es_meia_vida',
      ];

      for (final field in medicamentosFieldsToAdd) {
        await db.execute('ALTER TABLE medicamentos ADD COLUMN $field TEXT');
      }

      // Adiciona campos de detalhes às induções
      final inducoesFieldsToAdd = [
        'ind_definicao',
        'definicao_en',
        'definicao_es',
        'ind_epidemiologia',
        'epidemiologia_en',
        'epidemiologia_es',
        'ind_fisiopatologia',
        'fisiopatologia_en',
        'fisiopatologia_es',
      ];

      for (final field in inducoesFieldsToAdd) {
        await db.execute('ALTER TABLE inducoes ADD COLUMN $field TEXT');
      }
    }

    if (oldVersion < 3) {
      // Adiciona campos de detalhes às induções (v2 -> v3)
      final inducoesFieldsToAdd = [
        'ind_definicao',
        'definicao_en',
        'definicao_es',
        'ind_epidemiologia',
        'epidemiologia_en',
        'epidemiologia_es',
        'ind_fisiopatologia',
        'fisiopatologia_en',
        'fisiopatologia_es',
      ];

      for (final field in inducoesFieldsToAdd) {
        try {
          await db.execute('ALTER TABLE inducoes ADD COLUMN $field TEXT');
        } catch (e) {
          // Campo já existe, ignora
          print('Campo $field já existe: $e');
        }
      }
    }

    if (oldVersion < 4) {
      // Adiciona campos de nome de princípio ativo aos medicamentos (v3 -> v4)
      final medicamentosFieldsToAdd = [
        'pt_nome_principio_ativo',
        'us_nome_principio_ativo',
        'es_nome_principio_ativo',
      ];

      for (final field in medicamentosFieldsToAdd) {
        try {
          await db.execute('ALTER TABLE medicamentos ADD COLUMN $field TEXT');
        } catch (e) {
          // Campo já existe, ignora
          print('Campo $field já existe: $e');
        }
      }

      // Adiciona campos de nome às induções
      final inducoesFieldsToAdd = [
        'ind_nome',
        'ind_nome_en',
        'ind_nome_es',
      ];

      for (final field in inducoesFieldsToAdd) {
        try {
          await db.execute('ALTER TABLE inducoes ADD COLUMN $field TEXT');
        } catch (e) {
          // Campo já existe, ignora
          print('Campo $field já existe: $e');
        }
      }
    }

    if (oldVersion < 5) {
      // Cria tabela de subtópicos das induções (v4 -> v5)
      await db.execute('''
        CREATE TABLE IF NOT EXISTS inducoes_subtopicos (
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
          'CREATE INDEX IF NOT EXISTS idx_subtopicos_ind_id ON inducoes_subtopicos(ind_id)');
    }

    if (oldVersion < 6) {
      // Cria tabela de accordion das induções (v5 -> v6)
      await db.execute('''
        CREATE TABLE IF NOT EXISTS accordeon_inducao (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          remote_id INTEGER NOT NULL,
          inducao_id INTEGER NOT NULL,
          med_nome TEXT NOT NULL,
          med_nome_en TEXT,
          med_nome_es TEXT,
          dose_mg_kg REAL NOT NULL,
          concentracao_mg_ml REAL NOT NULL,
          last_sync TEXT NOT NULL
        )
      ''');

      await db.execute(
          'CREATE INDEX IF NOT EXISTS idx_accordeon_inducao_id ON accordeon_inducao(inducao_id)');
    }

    if (oldVersion < 7) {
      // Cria tabela de accordion dos medicamentos (v6 -> v7)
      await db.execute('''
        CREATE TABLE IF NOT EXISTS accordeon_medicamento (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          remote_id TEXT NOT NULL,
          medicamento_id INTEGER NOT NULL,
          topico TEXT NOT NULL,
          ordem INTEGER,
          titulo TEXT,
          subtitulo TEXT,
          concentracao TEXT,
          unidade_calculo TEXT,
          dose_min TEXT,
          dose_max TEXT,
          dose_teto TEXT,
          contexto TEXT,
          tipo_indicacao TEXT,
          dados_calculo TEXT,
          last_sync TEXT NOT NULL
        )
      ''');

      await db.execute(
          'CREATE INDEX IF NOT EXISTS idx_accordeon_medicamento_id ON accordeon_medicamento(medicamento_id)');
    }

    if (oldVersion < 8) {
      // Cria tabela de dados do usuário (v7 -> v8)
      await db.execute('''
        CREATE TABLE IF NOT EXISTS user_data (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id TEXT NOT NULL,
          usr_kgs TEXT,
          usr_altura TEXT,
          usr_idade TEXT,
          usr_faixa TEXT,
          usr_genero TEXT,
          usr_anos_meses TEXT,
          needs_sync INTEGER NOT NULL DEFAULT 0,
          last_sync TEXT NOT NULL
        )
      ''');
    }
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const boolType = 'INTEGER NOT NULL';

    // Tabela de medicamentos (com TODOS os campos de detalhes)
    await db.execute('''
      CREATE TABLE medicamentos (
        id $idType,
        remote_id $intType,
        nome $textType,
        nome_en TEXT,
        nome_es TEXT,
        descricao TEXT,
        descricao_en TEXT,
        descricao_es TEXT,
        categoria TEXT,
        is_favorite $boolType,
        last_sync $textType,
        pt_nome_principio_ativo TEXT,
        us_nome_principio_ativo TEXT,
        es_nome_principio_ativo TEXT,
        pt_nome_comercial TEXT,
        us_nome_comercial TEXT,
        es_nome_comercial TEXT,
        pt_classificacao TEXT,
        us_classificacao TEXT,
        es_classificacao TEXT,
        pt_mecanismo_acao TEXT,
        us_mecanismo_acao TEXT,
        es_mecanismo_acao TEXT,
        pt_farmacocinetica TEXT,
        us_farmacocinetica TEXT,
        es_farmacocinetica TEXT,
        pt_indicacoes TEXT,
        us_indicacoes TEXT,
        es_indicacoes TEXT,
        pt_posologia TEXT,
        us_posologia TEXT,
        es_posologia TEXT,
        pt_dose_minima TEXT,
        us_dose_minima TEXT,
        es_dose_minima TEXT,
        pt_dose_maxima TEXT,
        us_dose_maxima TEXT,
        es_dose_maxima TEXT,
        pt_administracao TEXT,
        us_administracao TEXT,
        es_administracao TEXT,
        pt_ajuste_renal TEXT,
        us_ajuste_renal TEXT,
        es_ajuste_renal TEXT,
        pt_apresentacao TEXT,
        us_apresentacao TEXT,
        es_apresentacao TEXT,
        pt_preparo TEXT,
        us_preparo TEXT,
        es_preparo TEXT,
        pt_inicio_acao TEXT,
        us_inicio_acao TEXT,
        es_inicio_acao TEXT,
        pt_tempo_pico TEXT,
        us_tempo_pico TEXT,
        es_tempo_pico TEXT,
        pt_meia_vida TEXT,
        us_meia_vida TEXT,
        es_meia_vida TEXT
      )
    ''');

    // Tabela de induções (com TODOS os campos de detalhes)
    await db.execute('''
      CREATE TABLE inducoes (
        id $idType,
        remote_id $intType,
        nome $textType,
        nome_en TEXT,
        nome_es TEXT,
        descricao TEXT,
        descricao_en TEXT,
        descricao_es TEXT,
        categoria TEXT,
        is_favorite $boolType,
        last_sync $textType,
        ind_nome TEXT,
        ind_nome_en TEXT,
        ind_nome_es TEXT,
        ind_definicao TEXT,
        definicao_en TEXT,
        definicao_es TEXT,
        ind_epidemiologia TEXT,
        epidemiologia_en TEXT,
        epidemiologia_es TEXT,
        ind_fisiopatologia TEXT,
        fisiopatologia_en TEXT,
        fisiopatologia_es TEXT
      )
    ''');

    // Tabela de favoritos (para sincronizar depois)
    await db.execute('''
      CREATE TABLE pending_favorites (
        id $idType,
        type $textType,
        item_id $intType,
        action $textType,
        created_at $textType
      )
    ''');

    // Tabela de subtópicos das induções
    await db.execute('''
      CREATE TABLE inducoes_subtopicos (
        id $idType,
        remote_id $intType,
        ind_id $intType,
        ind_topico TEXT,
        ind_titulos TEXT,
        ind_titulos_en TEXT,
        ind_titulos_es TEXT,
        ind_descricao TEXT,
        ind_descricao_en TEXT,
        ind_descricao_es TEXT,
        last_sync $textType
      )
    ''');

    // Tabela de accordion das induções
    await db.execute('''
      CREATE TABLE accordeon_inducao (
        id $idType,
        remote_id $intType,
        inducao_id $intType,
        med_nome $textType,
        med_nome_en TEXT,
        med_nome_es TEXT,
        dose_mg_kg REAL NOT NULL,
        concentracao_mg_ml REAL NOT NULL,
        last_sync $textType
      )
    ''');

    // Tabela de accordion dos medicamentos
    await db.execute('''
      CREATE TABLE accordeon_medicamento (
        id $idType,
        remote_id $textType,
        medicamento_id $intType,
        topico $textType,
        ordem INTEGER,
        titulo TEXT,
        subtitulo TEXT,
        concentracao TEXT,
        unidade_calculo TEXT,
        dose_min TEXT,
        dose_max TEXT,
        dose_teto TEXT,
        contexto TEXT,
        tipo_indicacao TEXT,
        dados_calculo TEXT,
        last_sync $textType
      )
    ''');

    // Tabela de dados do usuário
    await db.execute('''
      CREATE TABLE user_data (
        id $idType,
        user_id $textType,
        usr_kgs TEXT,
        usr_altura TEXT,
        usr_idade TEXT,
        usr_faixa TEXT,
        usr_genero TEXT,
        usr_anos_meses TEXT,
        needs_sync $boolType,
        last_sync $textType
      )
    ''');

    // Índices para melhor performance
    await db.execute(
        'CREATE INDEX idx_medicamentos_remote_id ON medicamentos(remote_id)');
    await db
        .execute('CREATE INDEX idx_inducoes_remote_id ON inducoes(remote_id)');
    await db.execute(
        'CREATE INDEX idx_subtopicos_ind_id ON inducoes_subtopicos(ind_id)');
    await db.execute(
        'CREATE INDEX idx_accordeon_inducao_id ON accordeon_inducao(inducao_id)');
    await db.execute(
        'CREATE INDEX idx_accordeon_medicamento_id ON accordeon_medicamento(medicamento_id)');
  }

  // Medicamentos
  Future<int> insertMedicamento(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('medicamentos', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getAllMedicamentos() async {
    final db = await database;
    return await db.query('medicamentos',
        orderBy: 'is_favorite DESC, nome ASC');
  }

  Future<Map<String, dynamic>?> getMedicamentoById(int remoteId) async {
    final db = await database;
    final result = await db.query(
      'medicamentos',
      where: 'remote_id = ?',
      whereArgs: [remoteId],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> updateMedicamentoFavorite(int remoteId, bool isFavorite) async {
    final db = await database;
    return await db.update(
      'medicamentos',
      {'is_favorite': isFavorite ? 1 : 0},
      where: 'remote_id = ?',
      whereArgs: [remoteId],
    );
  }

  // Induções
  Future<int> insertInducao(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('inducoes', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getAllInducoes() async {
    final db = await database;
    return await db.query('inducoes', orderBy: 'is_favorite DESC, nome ASC');
  }

  Future<Map<String, dynamic>?> getInducaoById(int remoteId) async {
    final db = await database;
    final result = await db.query(
      'inducoes',
      where: 'remote_id = ?',
      whereArgs: [remoteId],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> updateInducaoFavorite(int remoteId, bool isFavorite) async {
    final db = await database;
    return await db.update(
      'inducoes',
      {'is_favorite': isFavorite ? 1 : 0},
      where: 'remote_id = ?',
      whereArgs: [remoteId],
    );
  }

  // Favoritos pendentes (para sincronizar quando voltar online)
  Future<int> addPendingFavorite(String type, int itemId, String action) async {
    final db = await database;
    return await db.insert('pending_favorites', {
      'type': type,
      'item_id': itemId,
      'action': action,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getPendingFavorites() async {
    final db = await database;
    return await db.query('pending_favorites', orderBy: 'created_at ASC');
  }

  Future<int> deletePendingFavorite(int id) async {
    final db = await database;
    return await db
        .delete('pending_favorites', where: 'id = ?', whereArgs: [id]);
  }

  // Subtópicos das induções
  Future<int> insertSubtopico(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('inducoes_subtopicos', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getSubtopicosByInducaoId(int indId) async {
    final db = await database;

    // Debug: verifica se a tabela existe
    final tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='inducoes_subtopicos'");
    print('🔍 Tabela inducoes_subtopicos existe? ${tables.isNotEmpty}');

    if (tables.isEmpty) {
      print('❌ Tabela inducoes_subtopicos não existe!');
      return [];
    }

    final result = await db.query(
      'inducoes_subtopicos',
      where: 'ind_id = ?',
      whereArgs: [indId],
      orderBy: 'id ASC',
    );

    print('📊 Total de subtópicos para indução $indId: ${result.length}');
    return result;
  }

  // Accordion das induções
  Future<int> insertAccordeonInducao(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('accordeon_inducao', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getAccordeonByInducaoId(
      int inducaoId) async {
    final db = await database;

    // Debug: verifica se a tabela existe
    final tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='accordeon_inducao'");
    print('🔍 Tabela accordeon_inducao existe? ${tables.isNotEmpty}');

    if (tables.isEmpty) {
      print('❌ Tabela accordeon_inducao não existe!');
      return [];
    }

    final result = await db.query(
      'accordeon_inducao',
      where: 'inducao_id = ?',
      whereArgs: [inducaoId],
      orderBy: 'id ASC',
    );

    print(
        '📊 Total de medicamentos no accordion para indução $inducaoId: ${result.length}');
    return result;
  }

  // Accordion dos medicamentos
  Future<int> insertAccordeonMedicamento(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('accordeon_medicamento', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getAccordeonByMedicamentoId(
      int medicamentoId) async {
    final db = await database;

    // Debug: verifica se a tabela existe
    final tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='accordeon_medicamento'");
    print('🔍 Tabela accordeon_medicamento existe? ${tables.isNotEmpty}');

    if (tables.isEmpty) {
      print('❌ Tabela accordeon_medicamento não existe!');
      return [];
    }

    // Debug: conta total de registros na tabela
    final totalCount = await db
        .rawQuery('SELECT COUNT(*) as total FROM accordeon_medicamento');
    print('Total geral na tabela: ${totalCount.first['total']}');

    final result = await db.query(
      'accordeon_medicamento',
      where: 'medicamento_id = ?',
      whereArgs: [medicamentoId],
      orderBy: 'ordem ASC',
    );

    print('Total para medicamento $medicamentoId: ${result.length}');
    if (result.isNotEmpty) {
      print(
          'Exemplo: topico=${result.first['topico']}, titulo=${result.first['titulo']}');
    } else {
      // Debug: verifica alguns IDs salvos
      final sampleIds = await db.rawQuery(
          'SELECT DISTINCT medicamento_id FROM accordeon_medicamento LIMIT 10');
      print(
          'IDs salvos: ${sampleIds.map((e) => e['medicamento_id']).toList()}');
    }

    // Decodificar dados_calculo de string JSON para objeto
    return result.map((row) {
      final item = Map<String, dynamic>.from(row);

      // Decodificar dados_calculo se for string
      if (item['dados_calculo'] != null && item['dados_calculo'] is String) {
        try {
          final dadosStr = item['dados_calculo'] as String;
          if (dadosStr.trim().isNotEmpty) {
            item['dados_calculo'] = jsonDecode(dadosStr);
            print('✅ Decodificou dados_calculo para ${item['titulo']}');
          }
        } catch (e) {
          print('❌ Erro ao decodificar dados_calculo: $e');
          item['dados_calculo'] = null;
        }
      }

      return item;
    }).toList();
  }

  // Dados do usuário
  Future<int> saveUserData(Map<String, dynamic> data) async {
    final db = await database;

    // Verifica se já existe um registro para este usuário
    final existing = await db.query(
      'user_data',
      where: 'user_id = ?',
      whereArgs: [data['user_id']],
    );

    if (existing.isNotEmpty) {
      // Atualiza o registro existente
      return await db.update(
        'user_data',
        data,
        where: 'user_id = ?',
        whereArgs: [data['user_id']],
      );
    } else {
      // Insere novo registro
      return await db.insert('user_data', data);
    }
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    final db = await database;
    final result = await db.query(
      'user_data',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getPendingUserDataSync() async {
    final db = await database;
    return await db.query(
      'user_data',
      where: 'needs_sync = ?',
      whereArgs: [1],
    );
  }

  Future<int> markUserDataSynced(String userId) async {
    final db = await database;
    return await db.update(
      'user_data',
      {'needs_sync': 0, 'last_sync': DateTime.now().toIso8601String()},
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  // Limpar cache
  Future<void> clearCache() async {
    final db = await database;
    await db.delete('medicamentos');
    await db.delete('inducoes');
    await db.delete('inducoes_subtopicos');
    await db.delete('accordeon_inducao');
    await db.delete('accordeon_medicamento');
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}

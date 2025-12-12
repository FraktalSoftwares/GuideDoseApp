import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const boolType = 'INTEGER NOT NULL';

    // Tabela de medicamentos
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
        last_sync $textType
      )
    ''');

    // Tabela de induções
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
        last_sync $textType
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

    // Índices para melhor performance
    await db.execute(
        'CREATE INDEX idx_medicamentos_remote_id ON medicamentos(remote_id)');
    await db
        .execute('CREATE INDEX idx_inducoes_remote_id ON inducoes(remote_id)');
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

  // Limpar cache
  Future<void> clearCache() async {
    final db = await database;
    await db.delete('medicamentos');
    await db.delete('inducoes');
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}

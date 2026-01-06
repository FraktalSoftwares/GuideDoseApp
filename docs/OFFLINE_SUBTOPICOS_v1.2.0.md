# Implementação de Subtópicos Offline - v1.2.0+21

## Problema
Os campos principais das induções (nome, definição, epidemiologia, fisiopatologia) estavam aparecendo offline, mas os **subtópicos** (manifestações clínicas, diagnóstico, tratamento, etc.) não eram sincronizados e não apareciam quando offline.

## Solução Implementada

### 1. Nova Tabela no Banco de Dados Local (SQLite)

Criada tabela `inducoes_subtopicos` com os campos:
- `id` - ID local (autoincrement)
- `remote_id` - ID do subtópico no Supabase
- `ind_id` - ID da indução (foreign key)
- `ind_topico` - Tipo do tópico (manifestações_clinicas, diagnostico, tratamento, etc.)
- `ind_titulos` - Título em português
- `ind_titulos_en` - Título em inglês
- `ind_titulos_es` - Título em espanhol
- `ind_descricao` - Descrição em português
- `ind_descricao_en` - Descrição em inglês
- `ind_descricao_es` - Descrição em espanhol
- `last_sync` - Data da última sincronização

### 2. Atualização do Banco de Dados

**Versão do banco**: v4 → v5

**Migration automática**: Quando o usuário abrir o app com a nova versão, a tabela será criada automaticamente.

### 3. Novos Métodos no OfflineDatabase

```dart
// Inserir subtópico no cache
Future<int> insertSubtopico(Map<String, dynamic> data)

// Buscar subtópicos de uma indução
Future<List<Map<String, dynamic>>> getSubtopicosByInducaoId(int indId)
```

### 4. Sincronização Automática

Adicionado método `_syncInducoesSubtopicos()` no `SyncManager` que:
- Busca todos os subtópicos da view `vw_inducoes_subtopicos` do Supabase
- Limpa o cache antigo
- Salva todos os subtópicos no banco local
- É chamado automaticamente após sincronizar as induções

### 5. Carregamento Offline no Widget

Modificado o método `_loadSubtopicos()` em `p_detalhe_inducao_widget.dart`:
- **Online**: Busca do Supabase (comportamento original)
- **Offline**: Busca do cache local e converte para o tipo esperado

```dart
// Offline: busca do cache
final cached = await OfflineDatabase.instance.getSubtopicosByInducaoId(widget.id!);

// Converte Map para InducoesSubtopicosRow
return cached.map((map) => InducoesSubtopicosRow(map)).toList();
```

## Arquivos Modificados

1. **lib/backend/offline/offline_database.dart**
   - Versão do banco: 4 → 5
   - Adicionada tabela `inducoes_subtopicos`
   - Adicionados métodos `insertSubtopico()` e `getSubtopicosByInducaoId()`
   - Atualizado `clearCache()` para limpar subtópicos

2. **lib/backend/offline/sync_manager.dart**
   - Adicionado método `_syncInducoesSubtopicos()`
   - Integrado na sincronização de induções

3. **lib/pg_inducao/p_detalhe_inducao/p_detalhe_inducao_widget.dart**
   - Modificado `_loadSubtopicos()` para buscar do cache quando offline

4. **pubspec.yaml**
   - Versão: 1.1.9+20 → 1.2.0+21

## Como Testar

1. **Com Internet (primeira vez)**:
   - Abra o app
   - Aguarde a sincronização automática (acontece ao abrir e a cada 5 minutos)
   - Verifique nos logs: "✅ Subtópicos sincronizados!"

2. **Sem Internet (offline)**:
   - Desative WiFi e dados móveis
   - Abra os detalhes de uma indução
   - Verifique se os subtópicos aparecem:
     - Manifestações Clínicas
     - Diagnóstico
     - Tratamento
     - Prognóstico
     - Etc.

## Logs Esperados

### Durante Sincronização (Online):
```
🔄 Sincronizando induções...
📦 Encontradas 83 induções
💾 Salvou 83 induções no cache
🔄 Sincronizando subtópicos das induções...
📦 Encontrados XXX subtópicos
💾 Salvou XXX subtópicos no cache
✅ Subtópicos sincronizados!
✅ Induções sincronizadas!
```

### Durante Carregamento (Offline):
```
💾 Buscando subtópicos do cache para indução ID: X
📦 Encontrados Y subtópicos no cache
```

## Estrutura de Dados

### View do Supabase: `vw_inducoes_subtopicos`
Contém todos os subtópicos de todas as induções com campos multilíngues.

### Tabela Local: `inducoes_subtopicos`
Espelha a estrutura da view do Supabase para acesso offline.

## Próximos Passos

1. ✅ Testar sincronização inicial (com internet)
2. ✅ Testar carregamento offline dos subtópicos
3. ✅ Verificar se todos os tipos de subtópicos aparecem
4. ⏳ Build final para deploy

## Data
15/12/2024 - 07:45

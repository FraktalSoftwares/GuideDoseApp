# Suporte Offline para Accordion de Induções - v1.2.3+28

## Implementação Realizada

### Problema
O menu colapsável (accordion) que mostra medicamentos e doses/volumes nas induções não funcionava offline.

### Solução
Implementado suporte completo offline para o accordion das induções.

## Alterações Realizadas

### 1. Banco de Dados Offline (`lib/backend/offline/offline_database.dart`)

#### Nova Tabela: `accordeon_inducao`
```sql
CREATE TABLE accordeon_inducao (
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
```

#### Novos Métodos
- `insertAccordeonInducao()` - Insere dados do accordion
- `getAccordeonByInducaoId()` - Busca dados do accordion por ID da indução

#### Versão do Banco
- Atualizada de v5 para v6
- Migração automática para usuários existentes

### 2. Sincronização (`lib/backend/offline/sync_manager.dart`)

#### Novo Método: `_syncAccordeonInducao()`
- Busca todos os dados do accordion do Supabase
- Salva no cache local
- Logs detalhados para debug

#### Integração
- Chamado automaticamente após sincronizar induções
- Sincroniza junto com subtópicos

### 3. Widget do Accordion (`lib/pg_inducao/p_accordeon_inducao/p_accordeon_inducao_widget.dart`)

#### Novo Método: `_loadAccordeonData()`
```dart
Future<List<Map<String, dynamic>>> _loadAccordeonData() async {
  final syncManager = SyncManager.instance;

  if (syncManager.isOnline) {
    // Busca do Supabase
    final rows = await AccordeonInducaoTable().queryRows(...);
    return rows.map((row) => {...}).toList();
  }

  // Offline: busca do cache
  return await OfflineDatabase.instance.getAccordeonByInducaoId(widget.idInducao!);
}
```

#### Mudanças no Build
- Alterado de `FutureBuilder<List<AccordeonInducaoRow>>` para `FutureBuilder<List<Map<String, dynamic>>>`
- Acesso aos dados via Map ao invés de propriedades do objeto
- Suporte a valores null com operador `??`

## Estrutura de Dados

### Tabela Supabase: `accordeon_inducao`
```sql
- id: bigint (PK)
- created_at: timestamp
- inducao_id: bigint (FK para inducoes)
- med_nome: text
- med_nome_en: text
- med_nome_es: text
- dose_mg_kg: numeric
- concentracao_mg_ml: numeric
```

### Dados Exibidos
- **Medicamento**: Nome em PT/EN/ES (multilíngue)
- **Dose**: Calculada com base no peso do usuário (mg)
- **Volume**: Calculado com base na dose e concentração (mL)

## Fluxo de Funcionamento

### Online
1. Widget chama `_loadAccordeonData()`
2. Detecta que está online
3. Busca dados do Supabase via `AccordeonInducaoTable`
4. Converte para Map e retorna

### Offline
1. Widget chama `_loadAccordeonData()`
2. Detecta que está offline
3. Busca dados do cache SQLite
4. Retorna dados salvos na última sincronização

### Sincronização
1. Usuário faz login ou puxa para atualizar
2. `SyncManager.syncData()` é chamado
3. Sincroniza medicamentos → induções → subtópicos → **accordion**
4. Dados ficam disponíveis offline

## Testes Necessários

### Teste 1: Sincronização Inicial
1. Fazer login com internet
2. Aguardar sincronização completa
3. Verificar logs: `✅ Accordion sincronizado!`
4. Abrir uma indução e expandir o accordion
5. Verificar se medicamentos e doses aparecem

### Teste 2: Modo Offline
1. Com dados sincronizados, ativar modo avião
2. Abrir o app
3. Navegar para lista de induções
4. Abrir uma indução
5. Expandir o accordion
6. **Verificar**: Medicamentos e doses devem aparecer

### Teste 3: Cálculos
1. No accordion, verificar se:
   - Dose (mg) está calculada corretamente
   - Volume (mL) está calculado corretamente
   - Valores mudam ao alterar peso do usuário

### Teste 4: Multilíngue
1. Mudar idioma do app (PT/EN/ES)
2. Verificar se nomes dos medicamentos mudam

## Logs de Debug

### Sincronização
```
🔄 Sincronizando accordion das induções...
📦 Encontrados X itens do accordion
📋 Exemplo de item do accordion: {...}
💾 Salvou X itens do accordion no cache
✅ Accordion sincronizado!
```

### Carregamento Online
```
🌐 Buscando accordion online para indução X
```

### Carregamento Offline
```
💾 Buscando accordion do cache para indução X
🔍 Tabela accordeon_inducao existe? true
📦 Encontrados X itens no cache
📊 Total de medicamentos no accordion para indução X: Y
```

## Arquivos Modificados

1. `lib/backend/offline/offline_database.dart`
   - Adicionada tabela `accordeon_inducao`
   - Métodos de insert e query
   - Migração v5 → v6

2. `lib/backend/offline/sync_manager.dart`
   - Método `_syncAccordeonInducao()`
   - Integração no fluxo de sincronização

3. `lib/pg_inducao/p_accordeon_inducao/p_accordeon_inducao_widget.dart`
   - Imports de offline
   - Método `_loadAccordeonData()`
   - Suporte a Map ao invés de Row

## Próximos Passos

1. Testar sincronização inicial
2. Testar modo offline
3. Verificar cálculos de dose/volume
4. Testar multilíngue
5. Build e deploy

## Versão
- **Anterior**: 1.2.2+27
- **Atual**: 1.2.3+28

## Data
15/12/2024 - 09:30

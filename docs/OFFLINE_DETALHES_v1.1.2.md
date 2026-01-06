# Implementação de Detalhes Offline - v1.1.2+13

## Resumo
Implementado suporte offline completo para os modais de detalhes de Medicamentos e Induções. Agora os usuários podem visualizar informações detalhadas mesmo sem conexão com a internet.

## Alterações Realizadas

### 1. Backend - Banco de Dados Offline (`lib/backend/offline/offline_database.dart`)

#### Versão do Banco: v2 → v3

**Tabela `medicamentos`:**
- Já continha todos os campos de detalhes (adicionados na v2):
  - Nomes: `pt_nome_comercial`, `us_nome_comercial`, `es_nome_comercial`
  - Classificação: `pt_classificacao`, `us_classificacao`, `es_classificacao`
  - Mecanismo de ação: `pt_mecanismo_acao`, `us_mecanismo_acao`, `es_mecanismo_acao`
  - Farmacocinética: `pt_farmacocinetica`, `us_farmacocinetica`, `es_farmacocinetica`
  - Indicações: `pt_indicacoes`, `us_indicacoes`, `es_indicacoes`
  - Posologia: `pt_posologia`, `us_posologia`, `es_posologia`
  - Doses: `pt_dose_minima`, `us_dose_minima`, `es_dose_minima`, `pt_dose_maxima`, `us_dose_maxima`, `es_dose_maxima`
  - Administração: `pt_administracao`, `us_administracao`, `es_administracao`
  - Ajuste renal: `pt_ajuste_renal`, `us_ajuste_renal`, `es_ajuste_renal`
  - Apresentação: `pt_apresentacao`, `us_apresentacao`, `es_apresentacao`
  - Preparo: `pt_preparo`, `us_preparo`, `es_preparo`
  - Farmacodinâmica: `pt_inicio_acao`, `us_inicio_acao`, `es_inicio_acao`, `pt_tempo_pico`, `us_tempo_pico`, `es_tempo_pico`, `pt_meia_vida`, `us_meia_vida`, `es_meia_vida`

**Tabela `inducoes` (NOVO na v3):**
- Adicionados campos de detalhes:
  - Definição: `ind_definicao`, `definicao_en`, `definicao_es`
  - Epidemiologia: `ind_epidemiologia`, `epidemiologia_en`, `epidemiologia_es`
  - Fisiopatologia: `ind_fisiopatologia`, `fisiopatologia_en`, `fisiopatologia_es`

**Novos Métodos:**
- `getMedicamentoById(int remoteId)` - Busca medicamento do cache por ID
- `getInducaoById(int remoteId)` - Busca indução do cache por ID

### 2. Backend - Sincronização (`lib/backend/offline/sync_manager.dart`)

**Método `_syncMedicamentos()`:**
- Já sincronizava TODOS os campos de detalhes dos medicamentos

**Método `_syncInducoes()` (ATUALIZADO):**
- Agora sincroniza os campos de detalhes das induções:
  - `ind_definicao`, `definicao_en`, `definicao_es`
  - `ind_epidemiologia`, `epidemiologia_en`, `epidemiologia_es`
  - `ind_fisiopatologia`, `fisiopatologia_en`, `fisiopatologia_es`

### 3. Modal de Detalhes de Medicamentos (`lib/pg_remedios/p_detalhe_medicamento/p_detalhe_medicamento_widget.dart`)

**Alterações:**
- ✅ Adicionados imports: `SyncManager` e `OfflineDatabase`
- ✅ Criado método `_loadMedicamentoDetails()`:
  - Verifica se está online/offline
  - Se online: busca do Supabase
  - Se offline ou falha: busca do cache local
  - Retorna `Map<String, dynamic>` com os dados
- ✅ FutureBuilder alterado de `List<MedicamentosRow>` para `Map<String, dynamic>?`
- ✅ Todas as referências `containerMedicamentosRow?.ptNomePrincipioAtivo` substituídas por `medicamento?['pt_nome_principio_ativo']`

### 4. Modal de Detalhes de Induções (`lib/pg_inducao/p_detalhe_inducao/p_detalhe_inducao_widget.dart`)

**Alterações:**
- ✅ Adicionados imports: `SyncManager` e `OfflineDatabase`
- ✅ Criado método `_loadInducaoDetails()`:
  - Verifica se está online/offline
  - Se online: busca do Supabase
  - Se offline ou falha: busca do cache local
  - Retorna `Map<String, dynamic>` com os dados
- ✅ FutureBuilder alterado de `List<InducoesRow>` para `Map<String, dynamic>?`
- ✅ Todas as referências substituídas:
  - `containerInducoesRow?.indNome` → `inducao?['ind_nome']`
  - `containerInducoesRow?.indNomeEn` → `inducao?['ind_nome_en']`
  - `containerInducoesRow?.indNomeEs` → `inducao?['ind_nome_es']`
  - `containerInducoesRow?.indDefinicao` → `inducao?['ind_definicao']`
  - `containerInducoesRow?.definicaoEn` → `inducao?['definicao_en']`
  - `containerInducoesRow?.definicaoEs` → `inducao?['definicao_es']`
  - `containerInducoesRow?.indEpidemiologia` → `inducao?['ind_epidemiologia']`
  - `containerInducoesRow?.epidemiologiaEn` → `inducao?['epidemiologia_en']`
  - `containerInducoesRow?.epidemiologiaEs` → `inducao?['epidemiologia_es']`
  - `containerInducoesRow?.indFisiopatologia` → `inducao?['ind_fisiopatologia']`
  - `containerInducoesRow?.fisiopatologiaEn` → `inducao?['fisiopatologia_en']`
  - `containerInducoesRow?.fisiopatologiaEs` → `inducao?['fisiopatologia_es']`

### 5. Versão Atualizada

**pubspec.yaml:**
- Versão: `1.1.1+12` → `1.1.2+13`

## Comportamento

### Online:
1. Usuário clica no ícone "i" de um medicamento ou indução
2. Modal abre e busca dados do Supabase
3. Exibe todas as informações disponíveis

### Offline:
1. Usuário clica no ícone "i" de um medicamento ou indução
2. Modal abre e detecta que está offline
3. Busca dados do cache local (SQLite)
4. Exibe as informações que foram sincronizadas

### Sincronização:
- Automática a cada 5 minutos quando online
- Ao voltar online após período offline
- Pode ser forçada pelo usuário com pull-to-refresh nas listas

## Observações Importantes

### Campos Adicionais no Modal de Medicamentos
O modal de medicamentos possui MUITOS campos adicionais que não foram incluídos no cache inicial:
- Reações adversas
- Risco na gravidez/lactação
- Ajuste hepático
- Contraindicações
- Interações medicamentosas
- Soluções compatíveis
- Armazenamento
- Cuidados (médicos, farmacêuticos, enfermagem)
- Efeito clínico
- Via de eliminação
- Estabilidade pós-diluição
- E outros...

**Decisão de Design:**
- Estes campos NÃO foram adicionados ao cache nesta versão
- Quando offline, estes campos aparecerão vazios/indefinidos
- Isso mantém o banco de dados local menor e mais rápido
- Os campos essenciais (nome, classificação, mecanismo, indicações, posologia, doses) estão disponíveis offline
- Em versões futuras, podemos adicionar mais campos conforme necessário

### Migração do Banco de Dados
- O banco de dados será automaticamente atualizado da v2 para v3 na próxima execução do app
- Usuários existentes não perderão dados
- A migração adiciona os novos campos às induções

## Próximos Passos

1. **Testar no dispositivo:**
   - Abrir app online e deixar sincronizar
   - Ativar modo avião
   - Testar abertura de detalhes de medicamentos
   - Testar abertura de detalhes de induções
   - Verificar que informações básicas aparecem

2. **Se necessário adicionar mais campos:**
   - Identificar quais campos são mais importantes
   - Adicionar à tabela medicamentos no `offline_database.dart`
   - Adicionar ao sync em `sync_manager.dart`
   - Incrementar versão do banco de dados
   - Adicionar migração em `_upgradeDB`

3. **Build do APK:**
   ```bash
   flutter build apk --release
   ```
   ou
   ```bash
   flutter build appbundle --release
   ```

## Arquivos Modificados

1. `lib/backend/offline/offline_database.dart`
2. `lib/backend/offline/sync_manager.dart`
3. `lib/pg_remedios/p_detalhe_medicamento/p_detalhe_medicamento_widget.dart`
4. `lib/pg_inducao/p_detalhe_inducao/p_detalhe_inducao_widget.dart`
5. `pubspec.yaml`

## Status

✅ **CONCLUÍDO** - Código pronto para teste e build

### Compilação
- ✅ Sem erros de compilação
- ⚠️ Apenas warnings de imports não utilizados e operadores desnecessários (não afetam funcionalidade)

### Campos Disponíveis Offline

**Medicamentos:**
- ✅ Nome do princípio ativo (PT, EN, ES)
- ✅ Nome comercial (PT, EN, ES)
- ✅ Classificação (PT, EN, ES)
- ✅ Mecanismo de ação (PT, EN, ES)
- ✅ Farmacocinética (PT, EN, ES)
- ✅ Indicações (PT, EN, ES)
- ✅ Posologia (PT, EN, ES)
- ✅ Doses mínima e máxima (PT, EN, ES)
- ✅ Administração (PT, EN, ES)
- ✅ Ajuste renal (PT, EN, ES)
- ✅ Apresentação (PT, EN, ES)
- ✅ Preparo (PT, EN, ES)
- ✅ Início de ação, tempo de pico, meia-vida (PT, EN, ES)
- ❌ Reações adversas (não disponível offline)
- ❌ Risco na gravidez/lactação (não disponível offline)
- ❌ Ajuste hepático (não disponível offline)
- ❌ Contraindicações (não disponível offline)
- ❌ Interações medicamentosas (não disponível offline)
- ❌ Soluções compatíveis (não disponível offline)
- ❌ Armazenamento (não disponível offline)
- ❌ Cuidados (médicos, farmacêuticos, enfermagem) (não disponível offline)
- ❌ Efeito clínico (não disponível offline)
- ❌ Via de eliminação (não disponível offline)
- ❌ Estabilidade pós-diluição (não disponível offline)
- ❌ Precauções específicas (não disponível offline)
- ❌ Fontes bibliográficas (não disponível offline)

**Induções:**
- ✅ Nome (PT, EN, ES)
- ✅ Definição (PT, EN, ES)
- ✅ Epidemiologia (PT, EN, ES)
- ✅ Fisiopatologia (PT, EN, ES)
- ✅ Subtópicos (manifestações clínicas, diagnóstico, tratamento, etc.) - carregados online

### Comportamento Offline
- Campos não disponíveis no cache aparecerão como "Indefinido" quando offline
- Ao voltar online, todos os campos serão carregados normalmente
- Os campos essenciais para consulta rápida estão disponíveis offline

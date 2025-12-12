# Changelog - GuideDose App

## [1.0.2] - 2025-12-12

### 🌐 Modo Offline Completo

**Adicionado:**
- Sistema completo de cache offline com SQLite
- Sincronização automática quando volta online
- Indicador visual de status offline (banner laranja)
- Favoritos funcionam completamente offline
- Fila de sincronização para ações offline

**Arquivos Criados:**
- `lib/backend/offline/offline_database.dart` - Banco de dados local
- `lib/backend/offline/sync_manager.dart` - Gerenciador de sincronização
- `lib/components/offline_indicator/offline_indicator_widget.dart` - Indicador visual
- `OFFLINE_MODE.md` - Documentação completa

**Modificado:**
- `lib/main.dart` - Inicialização do modo offline
- `lib/pg_remedios/p_medicamentos/p_medicamentos_widget.dart` - Integração offline
- `lib/pg_inducao/p_inducao/p_inducao_widget.dart` - Integração offline
- `lib/pg_remedios/icon_fav/icon_fav_widget.dart` - Favoritos offline
- `lib/pg_inducao/icon_fav_inducao/icon_fav_inducao_widget.dart` - Favoritos offline
- `pubspec.yaml` - Adicionada dependência `connectivity_plus: 6.1.2`

**Benefícios:**
- ✅ App funciona 100% sem internet
- ✅ Dados carregam instantaneamente
- ✅ Médicos podem usar em áreas sem sinal
- ✅ Sincronização transparente
- ✅ Não perde dados offline

**Como funciona:**
1. Primeira vez online: baixa todos os dados e salva localmente
2. Offline: lê dados do cache local, favoritos salvos na fila
3. Volta online: sincroniza automaticamente favoritos pendentes

---

## [1.0.1] - 2025-12-12

### 🔒 Correção de Segurança e Favoritos

**Corrigido:**
- Problema de favoritos mostrando dados de outros usuários
- Favoritos não atualizavam instantaneamente

**Adicionado:**
- RLS (Row Level Security) nas tabelas `medicamentos_fav` e `inducoes_fav`
- Políticas de segurança (SELECT, INSERT, DELETE) filtradas por `auth.uid()`
- Callback `onFavChanged` nos componentes de favorito
- Atualização automática das listas ao modificar favoritos

**Arquivos Modificados:**
- Migration: `fix_favoritos_rls_policies`
- `lib/pg_inducao/icon_fav_inducao/icon_fav_inducao_widget.dart`
- `lib/pg_remedios/icon_fav/icon_fav_widget.dart`
- `lib/pg_inducao/p_inducao/p_inducao_widget.dart`
- `lib/pg_remedios/p_medicamentos/p_medicamentos_widget.dart`

---

## [1.0.0] - 2025-12-11

### 🎉 Lançamento Inicial

**Funcionalidades:**
- Catálogo de medicamentos com dosagens
- Catálogo de induções clínicas
- Sistema de favoritos
- Suporte multilíngue (PT, EN, ES)
- Autenticação com Supabase
- Interface responsiva

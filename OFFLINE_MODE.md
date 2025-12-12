## 📱 Modo Offline - GuideDose App

### ✅ O que foi implementado

O app agora funciona completamente offline! Aqui está o que foi feito:

#### 1. **Cache Local com SQLite**
- Todos os medicamentos e induções são salvos localmente
- Favoritos funcionam offline
- Dados persistem mesmo sem internet

#### 2. **Sincronização Automática**
- Sincroniza automaticamente quando volta online
- Sincronização a cada 5 minutos (quando online)
- Fila de ações pendentes (favoritos adicionados/removidos offline)

#### 3. **Indicador Visual**
- Banner laranja aparece quando está offline
- Mostra "Modo Offline - Dados salvos localmente"
- Desaparece automaticamente quando volta online

### 🔧 Como usar

#### Passo 1: Instalar dependências
```bash
flutter pub get
```

#### Passo 2: Inicializar no main.dart

Adicione no início do `main()`:

```dart
import 'package:guide_dose/backend/offline/sync_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializa Supabase
  await SupaFlow.initialize();
  
  // Inicializa modo offline
  await SyncManager.instance.initialize();
  
  // Faz sincronização inicial
  await SyncManager.instance.syncData();
  
  runApp(MyApp());
}
```

#### Passo 3: Adicionar indicador nas páginas

Adicione o `OfflineIndicatorWidget` no topo das páginas principais:

```dart
import '/components/offline_indicator/offline_indicator_widget.dart';

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        OfflineIndicatorWidget(), // Adicione aqui
        // ... resto do conteúdo
      ],
    ),
  );
}
```

#### Passo 4: Usar dados do cache

Nas páginas de medicamentos e induções, use o cache quando offline:

```dart
import '/backend/offline/sync_manager.dart';
import '/backend/offline/offline_database.dart';

Future<List<Map<String, dynamic>>> _loadData() async {
  final syncManager = SyncManager.instance;
  
  if (syncManager.isOnline) {
    // Busca do Supabase (como está agora)
    return await SupaFlow.client
        .from('vw_medicamentos_ordernados')
        .select();
  } else {
    // Busca do cache local
    return await OfflineDatabase.instance.getAllMedicamentos();
  }
}
```

#### Passo 5: Favoritos offline

Substitua as chamadas de favorito para usar o SyncManager:

```dart
// Adicionar favorito
await SyncManager.instance.addFavorite('medicamento', medicamentoId);

// Remover favorito
await SyncManager.instance.removeFavorite('medicamento', medicamentoId);

// Para induções, use 'inducao' ao invés de 'medicamento'
await SyncManager.instance.addFavorite('inducao', inducaoId);
```

### 📊 Estrutura do Banco Local

**Tabelas criadas:**

1. **medicamentos**
   - Armazena todos os medicamentos
   - Inclui traduções (PT, EN, ES)
   - Flag de favorito

2. **inducoes**
   - Armazena todas as induções
   - Inclui traduções (PT, EN, ES)
   - Flag de favorito

3. **pending_favorites**
   - Fila de favoritos para sincronizar
   - Sincroniza automaticamente quando volta online

### 🔄 Como funciona a sincronização

1. **Primeira vez (online):**
   - Baixa todos os dados do Supabase
   - Salva no cache local
   - App pronto para usar offline

2. **Usando offline:**
   - Lê dados do cache local
   - Favoritos são salvos localmente
   - Ações ficam na fila de sincronização

3. **Volta online:**
   - Detecta conexão automaticamente
   - Sincroniza favoritos pendentes
   - Atualiza cache com dados mais recentes
   - Banner desaparece

### 🎯 Benefícios

✅ **Funciona sem internet** - Médicos podem usar em áreas sem sinal
✅ **Rápido** - Dados locais carregam instantaneamente
✅ **Confiável** - Não perde dados mesmo offline
✅ **Transparente** - Usuário nem percebe a diferença
✅ **Sincronização automática** - Tudo é sincronizado quando volta online

### 🧪 Como testar

1. **Teste básico:**
   - Abra o app com internet
   - Ative modo avião
   - Navegue pelo app - tudo deve funcionar
   - Adicione/remova favoritos
   - Desative modo avião
   - Favoritos devem sincronizar automaticamente

2. **Teste de sincronização:**
   - Use o app offline
   - Adicione 3 favoritos
   - Volte online
   - Verifique no Supabase se os favoritos foram salvos

### 📝 Próximos passos (opcional)

Se quiser melhorar ainda mais:

1. **Imagens offline** - Cache de imagens com `cached_network_image` (já instalado)
2. **Busca offline** - Implementar busca no cache local
3. **Indicador de sincronização** - Mostrar progresso da sincronização
4. **Configurações** - Permitir usuário escolher quando sincronizar
5. **Tamanho do cache** - Limpar cache antigo automaticamente

### 🐛 Troubleshooting

**Problema:** Dados não aparecem offline
- **Solução:** Certifique-se de que `syncData()` foi chamado pelo menos uma vez online

**Problema:** Favoritos não sincronizam
- **Solução:** Verifique se o usuário está autenticado (`auth.currentUser != null`)

**Problema:** App lento
- **Solução:** O cache local é muito mais rápido que Supabase. Se estiver lento, pode ser outro problema.

### 📞 Suporte

Giovanni Manzatto - giovanni.manzatto@fraktalsoftwares.com.br

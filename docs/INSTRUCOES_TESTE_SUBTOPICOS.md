# INSTRUÇÕES PARA TESTAR SUBTÓPICOS OFFLINE

## PROBLEMA ATUAL
A tabela `inducoes_subtopicos` existe mas está **VAZIA** (0 subtópicos).
Isso acontece porque a sincronização ainda não foi executada.

## SOLUÇÃO: SINCRONIZAR DADOS

### Passo 1: Ativar Internet
1. Ative WiFi ou dados móveis no celular
2. Certifique-se que está conectado

### Passo 2: Abrir o App
1. Abra o app GuideDose
2. **AGUARDE 5-10 segundos** na tela inicial
3. A sincronização acontece automaticamente ao abrir o app

### Passo 3: Verificar Logs
Execute no computador:
```
.\ver-logs.bat
```

**Logs esperados (COM INTERNET):**
```
✅ Tabela inducoes_subtopicos já existe
🔄 Sincronizando medicamentos...
📦 Encontrados 108 medicamentos
💾 Salvou 108 medicamentos no cache
🔄 Sincronizando induções...
📦 Encontradas 83 induções
💾 Salvou 83 induções no cache
🔄 Sincronizando subtópicos das induções...
📦 Encontrados XXX subtópicos
💾 Salvou XXX subtópicos no cache
✅ Subtópicos sincronizados!
✅ Induções sincronizadas!
✅ Sincronização concluída
```

### Passo 4: Testar Offline
1. **Desative a internet** (WiFi e dados móveis)
2. Abra os detalhes de uma indução (clique no ícone "i")
3. **Verifique se os subtópicos aparecem:**
   - Manifestações Clínicas
   - Diagnóstico
   - Tratamento
   - Prognóstico
   - Etc.

## SE NÃO SINCRONIZAR

Se após 10 segundos com internet os logs não mostrarem a sincronização:

### Opção 1: Forçar Sincronização
1. Feche o app completamente (force stop)
2. Abra novamente
3. Aguarde 10 segundos

### Opção 2: Limpar Dados do App
1. Vá em Configurações > Apps > GuideDose
2. Limpar dados (Clear data)
3. Abra o app novamente
4. Faça login
5. Aguarde a sincronização

### Opção 3: Reinstalar
1. Desinstale o app
2. Instale novamente o APK
3. Faça login
4. Aguarde a sincronização

## VERIFICAR SE SINCRONIZOU

Execute:
```
.\ver-logs.bat
```

E procure por:
- "📦 Encontrados XXX subtópicos" (deve ser > 0)
- "💾 Salvou XXX subtópicos no cache" (deve ser > 0)
- "✅ Subtópicos sincronizados!"

## IMPORTANTE

⚠️ **A sincronização SÓ acontece COM INTERNET**
⚠️ **Aguarde pelo menos 10 segundos após abrir o app**
⚠️ **A sincronização automática acontece:**
   - Ao abrir o app
   - A cada 5 minutos (se estiver online)
   - Quando a conexão volta (offline → online)

## VERSÃO ATUAL
- APK: v1.2.2+23
- Localização: `build\app\outputs\flutter-apk\app-release.apk`

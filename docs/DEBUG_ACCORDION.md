# Debug do Accordion - Não Aparece

## Problema
O accordion não está aparecendo na lista de induções.

## Como o Accordion Funciona

O accordion é um menu **colapsável** que precisa ser **expandido** para aparecer.

### Passos para Ver o Accordion:

1. Abra o app
2. Vá em "Dose de Indução"
3. Você verá uma lista de induções
4. Cada indução tem 3 ícones à direita:
   - ⭐ (Favorito)
   - ℹ️ (Info/Detalhes)
   - **▲ (Seta para CIMA)** ← CLIQUE AQUI!

5. **Clique na seta ▲** para expandir
6. O accordion deve aparecer abaixo mostrando:
   ```
   Medicamento          Dose / Volume
   Rocurônio           120.0 mg / 12.0 mL
   Adrenalina          1.2 mg / 1.2 mL
   Quetamina           120.0 mg / 2.4 mL
   ```

7. Para fechar, clique na seta ▼ (para BAIXO)

## Teste com Logs

### 1. Build e Instalar
```bash
.\build-debug-apk.bat
.\instalar-apk.bat
```

### 2. Monitorar Logs
Em um terminal separado:
```bash
.\ver-logs.bat
```

### 3. Testar no App
1. Abra o app
2. Vá em "Dose de Indução"
3. **Clique na seta ▲** de qualquer indução
4. Observe os logs

### 4. Logs Esperados

#### Se estiver ONLINE:
```
🔍 ACCORDION: Iniciando carregamento para indução 4
📡 ACCORDION: Status online: true
🌐 ACCORDION: Buscando online para indução 4
✅ ACCORDION: Encontrados 3 itens online
📋 ACCORDION: Primeiro item: Rocurônio
🎯 ACCORDION: Retornando 3 itens
```

#### Se estiver OFFLINE:
```
🔍 ACCORDION: Iniciando carregamento para indução 4
📡 ACCORDION: Status online: false
💾 ACCORDION: Buscando do cache para indução 4
🔍 Tabela accordeon_inducao existe? true
📊 Total de medicamentos no accordion para indução 4: 3
✅ ACCORDION: Encontrados 3 itens no cache
📋 ACCORDION: Primeiro item: Rocurônio
```

## Possíveis Problemas

### 1. Você não está clicando na seta
**Solução**: Procure o ícone ▲ à direita de cada indução e clique nele

### 2. Dados não foram sincronizados
**Sintoma**: Logs mostram "Encontrados 0 itens"
**Solução**: 
- Faça login com internet
- Puxe para baixo na lista (pull to refresh)
- Aguarde sincronização

### 3. Erro ao buscar dados
**Sintoma**: Logs mostram "❌ ACCORDION: Erro..."
**Solução**: Me envie os logs completos

### 4. Widget não está sendo chamado
**Sintoma**: Nenhum log aparece ao clicar na seta
**Solução**: 
- Verifique se está clicando na seta correta (▲)
- Reinstale o app

## Teste Específico: Anafilaxia

Para testar com a indução "Anafilaxia com Instabilidade Hemodinâmica":

1. Abra "Dose de Indução"
2. Procure por "Anafilaxia com Instabilidade Hemodinâmica"
3. Clique na seta ▲ à direita
4. Deve aparecer:
   ```
   Medicamento          Dose / Volume
   Rocurônio           120.0 mg / 12.0 mL
   Adrenalina          1.2 mg / 1.2 mL
   Quetamina           120.0 mg / 2.4 mL
   ```

## Dados Confirmados no Banco

✅ Tabela `accordeon_inducao` tem 198 registros
✅ Indução ID 4 (Anafilaxia) tem 3 medicamentos:
- Rocurônio: 1.0 mg/kg, 10 mg/mL
- Adrenalina: 0.01 mg/kg, 1 mg/mL
- Quetamina: 1.0 mg/kg, 50 mg/mL

## Próximos Passos

1. **Teste clicando na seta ▲**
2. Se não aparecer, me envie:
   - Screenshot da tela
   - Logs completos do `.\ver-logs.bat`
   - Confirme se clicou na seta

## Comandos Úteis

```bash
# Build
.\build-debug-apk.bat

# Instalar
.\instalar-apk.bat

# Ver logs
.\ver-logs.bat

# Ver logs completos
.\ver-logs-completo.bat

# Desinstalar e reinstalar
adb uninstall com.guidedose.app
.\instalar-apk.bat
```

## Versão
v1.2.3+28

## Data
15/12/2024 - 10:00

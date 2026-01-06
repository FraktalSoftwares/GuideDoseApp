# Correção Accordion Offline - v1.3.3

## Problemas Identificados

### 1. ✅ RESOLVIDO: Dados não sincronizavam
- **Causa**: Supabase limitava em 1000 registros
- **Solução**: Implementada paginação para buscar todos os 1.281 registros
- **Status**: Funcionando - 22 registros da Adrenalina sincronizados

### 2. ⚠️ EM ANDAMENTO: Slider não atualiza vazão offline
- **Causa**: `dados_calculo` pode não estar sendo convertido corretamente do cache
- **Localização**: `lib/pg_remedios/p_accordeon_medicamento/p_accordeon_medicamento_widget.dart` linha 724-736
- **Função**: `functions.calcularResultadoMestre()` recebe `dados_calculo` que pode estar null

### 3. ⚠️ NOVO: Informações duplicadas
- **Causa**: Falta filtro de duplicatas (como foi feito nas induções)
- **Solução**: Adicionar filtro único por `id` ou `titulo + topico`

## Próximos Passos

1. Verificar logs do SliderConfig para ver se `dados_calculo` está sendo salvo
2. Adicionar filtro de duplicatas
3. Garantir que `dados_calculo` seja convertido corretamente do JSON

## Logs para Debug

Execute após sincronizar:
```
.\ver-logs-sync.bat
```

Procure por:
- `SliderConfig MED 4:` - deve mostrar o JSON do slider
- `=== MED 4 SALVO: 22 ===` - confirma sincronização

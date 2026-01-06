# Debug Subtópicos - Checklist

## Problema Atual
- ✅ Títulos dos subtópicos aparecem
- ❌ Conteúdo dos subtópicos não aparece (loading infinito ou "• -")

## Possíveis Causas

### 1. Dados não foram salvos corretamente
Execute `.\ver-logs.bat` e procure por:
```
💾 Salvou 760 subtópicos no cache
```

Se não aparecer, os dados não foram sincronizados.

### 2. Dados salvos mas campos errados
Os logs devem mostrar ao abrir detalhes:
```
💾 Buscando subtópicos do cache para indução ID: X
📦 Encontrados Y subtópicos no cache
```

Se Y = 0, os dados não estão no banco.

### 3. Mapeamento incorreto
Verifique se os campos estão sendo mapeados:
- `ind_descricao` → `conteudos_pt`
- `ind_descricao_en` → `conteudos_en`
- `ind_descricao_es` → `conteudos_es`

## Ações Necessárias

### Teste 1: Verificar se sincronizou
1. Ative internet
2. Abra o app
3. Execute `.\ver-logs.bat`
4. Procure por "💾 Salvou XXX subtópicos no cache"

### Teste 2: Verificar se carrega do cache
1. Desative internet
2. Abra detalhes de uma indução
3. Execute `.\ver-logs.bat`
4. Procure por "📦 Encontrados XXX subtópicos no cache"

### Teste 3: Verificar dados no banco
Precisamos adicionar logs para ver o conteúdo real que está sendo carregado.

## Próximo Passo
Adicionar logs detalhados para ver:
1. Quais campos existem no Map do cache
2. Qual o valor de `ind_descricao`
3. Se o mapeamento está funcionando

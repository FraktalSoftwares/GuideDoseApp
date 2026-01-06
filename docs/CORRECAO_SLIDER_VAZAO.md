# Correção Slider Vazão - Offline

## Problema
O valor da vazão (ex: "Vazão: 0.0 mL/h") não atualiza quando:
- O usuário muda o dropdown
- O usuário move o slider

## Causa
O `Text` que mostra o resultado está fora do escopo de reconstrução do `setState`.

## Solução
O `Text` da vazão precisa estar dentro de um widget que reconstrói quando:
- `_model.sliderPrincipalValue` muda
- `_model.dropDownValue` muda

O código já chama `safeSetState()` quando o slider muda (linha ~662), mas o `Text` da vazão (linha ~746) não está sendo reconstruído.

## Localização
Arquivo: `lib/pg_remedios/p_accordeon_medicamento/p_accordeon_medicamento_widget.dart`
- Slider: linha ~649-664
- Dropdown: linha ~490-520
- Text da vazão: linha ~745-760

## Implementação
O `Text` já está dentro do `Column` que deveria reconstruir com `safeSetState()`. 
O problema pode ser que o `FutureBuilder` está cacheando os dados e não permitindo reconstrução.

Preciso verificar se o `dados_calculo` está chegando corretamente do cache offline.

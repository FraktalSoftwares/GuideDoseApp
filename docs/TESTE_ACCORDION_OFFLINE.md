# Como Testar o Accordion Offline - v1.2.3+28

## Preparação

### 1. Build do APK
```bash
.\build-debug-apk.bat
```

### 2. Instalar no Dispositivo
```bash
.\instalar-apk.bat
```

## Testes

### Teste 1: Sincronização Inicial ✅

**Objetivo**: Verificar se os dados do accordion são sincronizados

**Passos**:
1. Abra o app com internet ativa
2. Faça login
3. Aguarde a sincronização (spinner no topo)
4. Monitore os logs:
   ```bash
   .\ver-logs.bat
   ```
5. **Procure por**:
   ```
   🔄 Sincronizando accordion das induções...
   📦 Encontrados X itens do accordion
   💾 Salvou X itens do accordion no cache
   ✅ Accordion sincronizado!
   ```

**Resultado Esperado**: Logs confirmam sincronização bem-sucedida

---

### Teste 2: Visualização Online ✅

**Objetivo**: Verificar se o accordion funciona online

**Passos**:
1. Com internet ativa
2. Navegue para "Dose de Indução"
3. Toque em qualquer indução (ex: "Anafilaxia com Instabilidade Hemodinâmica")
4. Observe o menu colapsável abaixo do nome
5. **Verifique**:
   - Coluna "Medicamento" mostra nomes (Rocurônio, Adrenalina, Quetamina)
   - Coluna "Dose / Volume" mostra valores calculados (ex: "120.0 mg / 12.0 mL")

**Resultado Esperado**: Medicamentos e doses aparecem corretamente

---

### Teste 3: Modo Offline 🎯

**Objetivo**: Verificar se o accordion funciona offline

**Passos**:
1. Com dados sincronizados (Teste 1 concluído)
2. **Ative o modo avião** no dispositivo
3. Feche e reabra o app
4. Navegue para "Dose de Indução"
5. Toque em uma indução
6. Observe o accordion
7. Monitore os logs:
   ```bash
   .\ver-logs.bat
   ```
8. **Procure por**:
   ```
   💾 Buscando accordion do cache para indução X
   📦 Encontrados X itens no cache
   ```

**Resultado Esperado**: 
- Medicamentos e doses aparecem mesmo offline
- Logs confirmam busca do cache

---

### Teste 4: Cálculos de Dose/Volume 📊

**Objetivo**: Verificar se os cálculos estão corretos

**Passos**:
1. Abra uma indução com accordion
2. Anote os valores exibidos
3. **Cálculo Manual**:
   - Dose (mg) = Peso do usuário (kg) × dose_mg_kg
   - Volume (mL) = Dose (mg) / concentracao_mg_ml
4. Compare com os valores exibidos

**Exemplo**:
- Usuário: 120 kg
- Rocurônio: 1.0 mg/kg, concentração 10 mg/mL
- **Dose esperada**: 120 kg × 1.0 = 120.0 mg
- **Volume esperado**: 120.0 mg / 10 mg/mL = 12.0 mL
- **Exibido**: "120.0 mg / 12.0 mL" ✅

**Resultado Esperado**: Valores calculados corretamente

---

### Teste 5: Multilíngue 🌍

**Objetivo**: Verificar se os nomes mudam com o idioma

**Passos**:
1. Abra uma indução com accordion
2. Anote os nomes dos medicamentos em PT
3. Vá em "Conta" → Mude o idioma para EN
4. Volte para a mesma indução
5. **Verifique**: Nomes dos medicamentos mudaram para inglês

**Exemplo**:
- PT: "Rocurônio"
- EN: "Rocuronium"
- ES: "Rocuronio"

**Resultado Esperado**: Nomes mudam conforme o idioma

---

### Teste 6: Múltiplas Induções 📋

**Objetivo**: Verificar se cada indução tem seu próprio accordion

**Passos**:
1. Abra "Anafilaxia com Instabilidade Hemodinâmica"
   - Deve mostrar: Rocurônio, Adrenalina, Quetamina
2. Volte e abra "Angioedema Grave (Alérgico ou por IECA)"
   - Deve mostrar medicamentos diferentes
3. **Verifique**: Cada indução mostra seus próprios medicamentos

**Resultado Esperado**: Accordions são independentes por indução

---

## Checklist de Testes

- [ ] Teste 1: Sincronização inicial
- [ ] Teste 2: Visualização online
- [ ] Teste 3: Modo offline (PRINCIPAL)
- [ ] Teste 4: Cálculos corretos
- [ ] Teste 5: Multilíngue
- [ ] Teste 6: Múltiplas induções

## Problemas Conhecidos

### Se o accordion não aparecer offline:

1. **Verificar sincronização**:
   ```bash
   .\ver-logs.bat
   ```
   Procure por: `✅ Accordion sincronizado!`

2. **Forçar nova sincronização**:
   - Puxe para baixo na lista de induções (pull to refresh)
   - Aguarde sincronização completa

3. **Limpar cache e reinstalar**:
   ```bash
   adb uninstall com.guidedose.app
   .\instalar-apk.bat
   ```

### Se os cálculos estiverem errados:

1. Verifique o peso do usuário em "Conta"
2. Verifique se os dados foram sincronizados corretamente
3. Veja os logs para valores de dose_mg_kg e concentracao_mg_ml

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

# Desinstalar
adb uninstall com.guidedose.app
```

## Versão
v1.2.3+28

## Data
15/12/2024

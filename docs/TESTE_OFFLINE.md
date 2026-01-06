# 🧪 Guia de Teste - Modo Offline

## Como testar o modo offline

### 1️⃣ Preparação (com internet)

1. **Abra o app com internet ativa**
2. **Faça login** com sua conta
3. **Aguarde alguns segundos** - O app está baixando todos os dados para o cache local
4. **Navegue pelas páginas:**
   - Vá em "Medicamentos" - veja a lista completa
   - Vá em "Induções" - veja a lista completa
   - Adicione alguns favoritos

### 2️⃣ Teste Offline

1. **Ative o modo avião** no seu celular
   - Ou desconecte do WiFi

2. **Observe o banner laranja** aparecer no topo:
   ```
   🌥️ Modo Offline - Dados salvos localmente
   ```

3. **Teste as funcionalidades:**
   - ✅ Navegue entre Medicamentos e Induções
   - ✅ Use a busca (funciona no cache local)
   - ✅ Adicione favoritos (ícone de estrela)
   - ✅ Remova favoritos
   - ✅ Abra detalhes dos itens
   - ✅ Expanda/colapsa acordeões

4. **Tudo deve funcionar normalmente!**

### 3️⃣ Teste de Sincronização

1. **Desative o modo avião** (volte online)

2. **Observe:**
   - Banner laranja desaparece automaticamente
   - Favoritos adicionados offline são sincronizados
   - Dados são atualizados em background

3. **Verifique no Supabase:**
   - Acesse o dashboard do Supabase
   - Vá em "Table Editor"
   - Abra `medicamentos_fav` ou `inducoes_fav`
   - Veja que os favoritos adicionados offline foram salvos!

### 4️⃣ Teste de Múltiplos Dispositivos

1. **No dispositivo A (offline):**
   - Adicione 3 favoritos

2. **No dispositivo B (online):**
   - Veja que ainda não aparecem os favoritos do A

3. **Volte online no dispositivo A:**
   - Aguarde alguns segundos
   - Favoritos são sincronizados

4. **Atualize no dispositivo B:**
   - Pull to refresh
   - Favoritos do A agora aparecem!

## 🎯 Checklist de Teste

- [ ] App abre com internet
- [ ] Dados carregam na primeira vez
- [ ] Banner offline aparece quando desconecta
- [ ] Listas funcionam offline
- [ ] Busca funciona offline
- [ ] Favoritos funcionam offline
- [ ] Banner desaparece quando volta online
- [ ] Favoritos sincronizam automaticamente
- [ ] Dados atualizam quando volta online

## 🐛 Problemas Comuns

### "Não vejo dados offline"
**Solução:** Certifique-se de abrir o app online pelo menos uma vez para baixar os dados.

### "Favoritos não sincronizam"
**Solução:** Aguarde alguns segundos após voltar online. A sincronização é automática mas pode levar até 5 minutos.

### "Banner não aparece"
**Solução:** Reinicie o app. O sistema de detecção de conectividade é inicializado no startup.

## 📊 Logs de Debug

Para ver logs de sincronização, procure no console:

```
✅ Sincronização concluída
❌ Erro na sincronização: [detalhes]
```

## 🎉 Sucesso!

Se todos os testes passaram, o modo offline está funcionando perfeitamente!

O app agora pode ser usado por médicos em:
- 🏥 Hospitais com sinal fraco
- ✈️ Aviões
- 🚇 Metrôs
- 🏔️ Áreas remotas
- 📵 Qualquer lugar sem internet

---

**Versão:** 1.0.2  
**Data:** 12/12/2025

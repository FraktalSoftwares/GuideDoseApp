# Adicionar Secrets Restantes no GitHub

## Secrets que ainda precisam ser adicionados

### Secret 6: KEYCHAIN_PASSWORD

1. No GitHub, clique em **"New repository secret"**
2. **Name**: `KEYCHAIN_PASSWORD`
3. **Secret**: Digite qualquer senha aleatória segura (ex: `MySecureKeychain2024!@#`)
4. Clique em **"Add secret"**

> **Nota**: Esta senha é usada apenas para criar um keychain temporário durante o build. Pode ser qualquer senha aleatória.

---

### Secret 7: APP_STORE_CONNECT_API_KEY

1. Abra o arquivo: `C:\Users\giova\Downloads\AuthKey_59DPBRW7G5.p8`
2. Selecione **TODO o conteúdo** (Ctrl+A) e copie (Ctrl+C)
   - Deve incluir as linhas `-----BEGIN PRIVATE KEY-----` e `-----END PRIVATE KEY-----`
3. No GitHub, clique em **"New repository secret"**
4. **Name**: `APP_STORE_CONNECT_API_KEY`
5. **Secret**: Cole o conteúdo completo do arquivo .p8
6. Clique em **"Add secret"**

**Conteúdo esperado:**
```
-----BEGIN PRIVATE KEY-----
MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgFMsE/sThBFGdnvRV
tqNAZF8EQhUEY9l64/Jukm12l2ygCgYIKoZIzj0DAQehRANCAATwNtFFYNL78xaD
xhwAQQk1TSt6iHK476TM2NrxKbLQmycP7NuMaUnl0uECoIlGiNEyLM49+EnnNNWn
TsFDlJCe
-----END PRIVATE KEY-----
```

---

### Secret 8: APP_STORE_CONNECT_KEY_ID

1. No GitHub, clique em **"New repository secret"**
2. **Name**: `APP_STORE_CONNECT_KEY_ID`
3. **Secret**: `59DPBRW7G5`
4. Clique em **"Add secret"**

> **Nota**: Este é o Key ID extraído do nome do arquivo `AuthKey_59DPBRW7G5.p8`

---

### Secret 9: APP_STORE_CONNECT_ISSUER_ID

1. Acesse: https://appstoreconnect.apple.com/access/api
2. Faça login com sua conta Apple Developer
3. Na página, você verá o **Issuer ID** (formato: UUID, ex: `12345678-1234-1234-1234-123456789012`)
4. Copie o Issuer ID completo
5. No GitHub, clique em **"New repository secret"**
6. **Name**: `APP_STORE_CONNECT_ISSUER_ID`
7. **Secret**: Cole o Issuer ID copiado
8. Clique em **"Add secret"**

> **Nota**: O Issuer ID é um UUID único da sua conta/organização Apple Developer.

---

## Resumo Final

Após adicionar todos os secrets, você terá:

| # | Secret Name | Status |
|---|-------------|--------|
| 1 | APPLE_CERTIFICATE_BASE64 | ✅ Configurado |
| 2 | APPLE_CERTIFICATE_PASSWORD | ✅ Configurado |
| 3 | APPLE_PROVISIONING_PROFILE_BASE64 | ✅ Configurado |
| 4 | APPLE_TEAM_ID | ✅ Configurado |
| 5 | PROVISIONING_PROFILE_SPECIFIER | ✅ Configurado |
| 6 | KEYCHAIN_PASSWORD | ⚠️ Adicionar |
| 7 | APP_STORE_CONNECT_API_KEY | ⚠️ Adicionar |
| 8 | APP_STORE_CONNECT_KEY_ID | ⚠️ Adicionar |
| 9 | APP_STORE_CONNECT_ISSUER_ID | ⚠️ Adicionar |

---

## Próximos Passos

Após adicionar todos os secrets:

1. Faça um commit e push para a branch `master`
2. O workflow será executado automaticamente
3. O app será buildado e enviado para o TestFlight

---

## Troubleshooting

### Erro: "Invalid API Key"
- Verifique se copiou TODO o conteúdo do arquivo .p8 (incluindo BEGIN e END)
- Verifique se não há espaços extras ou quebras de linha incorretas

### Erro: "Invalid Issuer ID"
- Verifique se copiou o Issuer ID completo (formato UUID)
- Certifique-se de que não há espaços antes ou depois

### Erro: "Keychain password"
- Qualquer senha aleatória funciona, desde que seja segura
- Exemplo: `MySecureKeychain2024!@#`

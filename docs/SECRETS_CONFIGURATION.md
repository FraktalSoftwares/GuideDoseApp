# 🔐 Configuração de Secrets - GuideDose iOS

## ✅ Informações da API Key (Já Configuradas)

- **Arquivo:** `AuthKey_3WPT9X8U4F.p8`
- **Key ID:** `3WPT9X8U4F`
- **Issuer ID:** `044c0b43-edab-4738-aaad-b1dbfe1928f6`
- **Base64 (já convertido):** Ver abaixo

---

## 📋 Secrets para Configurar no GitHub

Acesse: https://github.com/FraktalSoftwares/GuideDoseApp/settings/secrets/actions

### 1. APP_STORE_CONNECT_ISSUER_ID
```
044c0b43-edab-4738-aaad-b1dbfe1928f6
```

### 2. APP_STORE_CONNECT_KEY_ID
```
3WPT9X8U4F
```

### 3. APP_STORE_CONNECT_API_KEY
```
LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JR1RBZ0VBTUJNR0J5cUdTTTQ5QWdFR0NDcUdTTTQ5QXdFSEJIa3dkd0lCQVFRZ1FjaHNiOWlxOUtsbEJSOTYKS3E2TVdGd2EvOWRFYjFXUG1tUlR2UzN4YURTZ0NnWUlLb1pJemowREFRZWhSQU5DQUFSWkg0bm8wRFpwdnZaZwpPZHNKSlFJMkYxUGMzU25KdGViclBLZWthTWFSU0JkLzdXejZSV2hQcEM5VjQ5SzR0Y2pteUNrSmhJZXpLSTNDCmtEOWZGVURVCi0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0=
```

### 4. APPLE_CERTIFICATE_BASE64
*(Converter seu certificado .p12 para base64)*

No PowerShell:
```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("caminho\para\certificado.p12"))
```

### 5. APPLE_CERTIFICATE_PASSWORD
*(Senha que você definiu ao exportar o certificado .p12)*

### 6. APPLE_PROVISIONING_PROFILE_BASE64
*(Converter seu provisioning profile .mobileprovision para base64)*

No PowerShell:
```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("caminho\para\profile.mobileprovision"))
```

### 7. KEYCHAIN_PASSWORD
```
temp123
```
*(Qualquer senha temporária - usada apenas durante o build)*

---

## ✅ Checklist de Configuração

- [ ] `APP_STORE_CONNECT_ISSUER_ID` configurado
- [ ] `APP_STORE_CONNECT_KEY_ID` configurado
- [ ] `APP_STORE_CONNECT_API_KEY` configurado (base64 acima)
- [ ] `APPLE_CERTIFICATE_BASE64` configurado
- [ ] `APPLE_CERTIFICATE_PASSWORD` configurado
- [ ] `APPLE_PROVISIONING_PROFILE_BASE64` configurado
- [ ] `KEYCHAIN_PASSWORD` configurado

---

## 🚀 Próximo Passo

Após configurar todos os secrets, faça um push para a branch `master` ou execute o workflow manualmente em:
**Actions > iOS Build and Deploy to TestFlight > Run workflow**

---

## 📝 Notas

- O workflow usa a **App Store Connect API Key** (método moderno e recomendado)
- Não é necessário configurar `APPLE_ID` ou `APP_SPECIFIC_PASSWORD` quando usando API Key
- O Bundle ID do app é: `com.mycompany.mcguidedose.apps`

# ⚡ GitHub Actions iOS - Quick Start

## 🚀 Configuração Rápida (5 minutos)

### 1. Secrets Necessários

Configure estes secrets no GitHub:
- Settings > Secrets and variables > Actions > New repository secret

| Secret | O que é | Valor GuideDose |
|--------|---------|-----------------|
| `APPLE_CERTIFICATE_BASE64` | Certificado `.p12` em base64 | (converter) |
| `APPLE_CERTIFICATE_PASSWORD` | Senha do certificado `.p12` | (sua senha) |
| `APPLE_PROVISIONING_PROFILE_BASE64` | Profile `.mobileprovision` em base64 | (converter) |
| `APP_STORE_CONNECT_ISSUER_ID` | Issuer ID da API Key | `044c0b43-edab-4738-aaad-b1dbfe1928f6` |
| `APP_STORE_CONNECT_KEY_ID` | Key ID da API Key | `3WPT9X8U4F` |
| `APP_STORE_CONNECT_API_KEY` | Arquivo `.p8` em base64 | (converter AuthKey_3WPT9X8U4F.p8) |
| `KEYCHAIN_PASSWORD` | Qualquer senha temporária | `temp123` |

### 2. Converter para Base64 (PowerShell)

```powershell
# Certificado
[Convert]::ToBase64String([IO.File]::ReadAllBytes("certificado.p12"))

# Provisioning Profile
[Convert]::ToBase64String([IO.File]::ReadAllBytes("profile.mobileprovision"))

# API Key (.p8) - IMPORTANTE: inclui BEGIN/END
[Convert]::ToBase64String([IO.File]::ReadAllBytes("AuthKey_3WPT9X8U4F.p8"))
```

### 3. Executar

**Automático:** Push para `master`  
**Manual:** Actions > iOS Build and Deploy > Run workflow

---

## 📋 Checklist

- [ ] Certificado `.p12` criado
- [ ] Provisioning Profile criado
- [ ] App-Specific Password gerada
- [ ] Todos os secrets configurados no GitHub
- [ ] Workflow testado

---

## 🆘 Problemas?

Veja o guia completo: [`docs/GITHUB_ACTIONS_IOS_SETUP.md`](GITHUB_ACTIONS_IOS_SETUP.md)

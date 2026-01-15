# ⚡ GitHub Actions iOS - Quick Start

## 🚀 Configuração Rápida (5 minutos)

### 1. Secrets Necessários

Configure estes secrets no GitHub:
- Settings > Secrets and variables > Actions > New repository secret

| Secret | O que é |
|--------|---------|
| `APPLE_CERTIFICATE_BASE64` | Certificado `.p12` em base64 |
| `APPLE_CERTIFICATE_PASSWORD` | Senha do certificado `.p12` |
| `APPLE_PROVISIONING_PROFILE_BASE64` | Profile `.mobileprovision` em base64 |
| `APPLE_TEAM_ID` | Team ID (encontre em developer.apple.com) |
| `APPLE_ID` | Email da conta Apple Developer |
| `APP_SPECIFIC_PASSWORD` | App-Specific Password (appleid.apple.com) |
| `KEYCHAIN_PASSWORD` | Qualquer senha temporária (ex: `temp123`) |

### 2. Converter para Base64 (PowerShell)

```powershell
# Certificado
[Convert]::ToBase64String([IO.File]::ReadAllBytes("certificado.p12"))

# Provisioning Profile
[Convert]::ToBase64String([IO.File]::ReadAllBytes("profile.mobileprovision"))
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

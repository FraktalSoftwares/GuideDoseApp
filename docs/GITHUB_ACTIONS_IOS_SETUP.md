# 🚀 Configuração do GitHub Actions para iOS - GuideDose

Este guia explica como configurar o GitHub Actions para fazer build e deploy automático do app GuideDose para o TestFlight e App Store.

## 📋 Pré-requisitos

- Conta Apple Developer (US$ 99/ano)
- Conta GitHub com acesso ao repositório `FraktalSoftwares/GuideDoseApp`
- Certificado iOS Distribution (arquivo `.p12`)
- Provisioning Profile App Store (arquivo `.mobileprovision`)
- App Store Connect API Key (arquivo `.p8`) - **Recomendado** (alternativa: App-Specific Password)

---

## 🔧 Passo 1: Preparar Certificados

### 1.1. Certificado de Distribuição (.p12)

1. Acesse: https://developer.apple.com/account/resources/certificates
2. Baixe o certificado `.cer`
3. **No Mac:**
   - Abra o Keychain Access
   - Importe o arquivo `.cer`
   - Clique com botão direito > **"Export"**
   - Salve como `.p12` e defina uma senha (anote essa senha!)

### 1.2. Provisioning Profile (.mobileprovision)

1. Acesse: https://developer.apple.com/account/resources/profiles
2. Crie ou baixe o Provisioning Profile para **App Store**
3. Bundle ID: `com.mycompany.mcguidedose.apps`
4. Baixe o arquivo `.mobileprovision`

### 1.3. App Store Connect API Key (Recomendado) ✅

**Você já tem a API Key configurada!**

- **Arquivo:** `AuthKey_3WPT9X8U4F.p8`
- **Key ID:** `3WPT9X8U4F`
- **Issuer ID:** `044c0b43-edab-4738-aaad-b1dbfe1928f6`

**Para converter o arquivo .p8 para base64:**

No Windows (PowerShell):
```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("AuthKey_3WPT9X8U4F.p8"))
```

No Mac/Linux:
```bash
base64 -i AuthKey_3WPT9X8U4F.p8
```

**Copie o conteúdo base64 completo** (incluindo `-----BEGIN PRIVATE KEY-----` e `-----END PRIVATE KEY-----`) para usar no secret `APP_STORE_CONNECT_API_KEY`.

---

## 🔐 Passo 2: Converter Arquivos para Base64

### No Windows (PowerShell):

```powershell
# Converter certificado .p12 para base64
[Convert]::ToBase64String([IO.File]::ReadAllBytes("C:\caminho\para\certificado.p12"))

# Converter provisioning profile para base64
[Convert]::ToBase64String([IO.File]::ReadAllBytes("C:\caminho\para\profile.mobileprovision"))
```

### No Mac/Linux:

```bash
# Certificado .p12
base64 -i certificado.p12 -o certificado_base64.txt

# Provisioning profile
base64 -i profile.mobileprovision -o profile_base64.txt
```

**Copie o conteúdo base64** (sem quebras de linha) para usar nos secrets do GitHub.

---

## 🌐 Passo 3: Configurar Secrets no GitHub

1. Acesse: https://github.com/FraktalSoftwares/GuideDoseApp/settings/secrets/actions
2. Clique em **"New repository secret"**
3. Adicione cada um dos secrets abaixo:

### Secrets Obrigatórios:

| Nome do Secret | Descrição | Valor para GuideDose |
|---------------|-----------|----------------------|
| `APPLE_CERTIFICATE_BASE64` | Certificado `.p12` em base64 | (converter seu certificado) |
| `APPLE_CERTIFICATE_PASSWORD` | Senha do certificado `.p12` | (sua senha) |
| `APPLE_PROVISIONING_PROFILE_BASE64` | Provisioning profile em base64 | (converter seu profile) |
| `APP_STORE_CONNECT_ISSUER_ID` | Issuer ID da API Key | `044c0b43-edab-4738-aaad-b1dbfe1928f6` |
| `APP_STORE_CONNECT_KEY_ID` | Key ID da API Key | `3WPT9X8U4F` |
| `APP_STORE_CONNECT_API_KEY` | Conteúdo do arquivo `.p8` em base64 | (converter AuthKey_3WPT9X8U4F.p8) |
| `KEYCHAIN_PASSWORD` | Senha temporária para keychain | `temp123` (qualquer senha) |

### Secrets Opcionais:

| Nome do Secret | Descrição | Quando usar |
|----------------|-----------|-------------|
| `APPLE_APP_ID` | App ID do App Store Connect | Não necessário (opcional) |
| `PROVISIONING_PROFILE_SPECIFIER` | Nome do provisioning profile | Se tiver múltiplos profiles |

**Nota:** O workflow usa a **App Store Connect API Key** (método moderno) em vez de App-Specific Password. Isso é mais seguro e recomendado pela Apple.

---

## 📝 Passo 4: Verificar Configuração

### 4.1. Verificar Bundle ID

Certifique-se de que o Bundle ID no projeto corresponde ao do Provisioning Profile:

- **Bundle ID:** `com.mycompany.mcguidedose.apps`
- Verificar em: `ios/Runner.xcodeproj/project.pbxproj`

### 4.2. Verificar Workflow

O workflow está configurado em: `.github/workflows/ios-deploy.yml`

**Triggers:**
- Push para branch `master` (quando há mudanças em `ios/`, `lib/`, `pubspec.yaml`)
- Manual via `workflow_dispatch`

---

## ▶️ Passo 5: Executar o Workflow

### Opção 1: Push Automático

Faça push para a branch `master` com alterações relevantes:

```bash
git add .
git commit -m "feat: Nova funcionalidade"
git push origin master
```

O workflow será executado automaticamente.

### Opção 2: Execução Manual

1. Acesse: https://github.com/FraktalSoftwares/GuideDoseApp/actions
2. Clique em **"iOS Build and Deploy to TestFlight"**
3. Clique em **"Run workflow"**
4. Selecione a branch `master`
5. (Opcional) Marque **"Deploy to App Store"** para enviar direto para a loja
6. Clique em **"Run workflow"**

---

## 🔍 Passo 6: Monitorar o Build

1. Acesse: https://github.com/FraktalSoftwares/GuideDoseApp/actions
2. Clique no workflow em execução
3. Acompanhe os logs em tempo real
4. O IPA será enviado automaticamente para o TestFlight/App Store

**Tempo estimado:** 15-25 minutos

---

## 🆘 Troubleshooting

### Erro: "No signing certificate found"

**Solução:**
- Verifique se `APPLE_CERTIFICATE_BASE64` está correto
- Certifique-se de que o certificado é de **Distribution** (não Development)
- Verifique se a senha do certificado está correta

### Erro: "No provisioning profile found"

**Solução:**
- Verifique se `APPLE_PROVISIONING_PROFILE_BASE64` está correto
- Certifique-se de que o profile é para **App Store** (não Ad Hoc)
- Verifique se o Bundle ID corresponde: `com.mycompany.mcguidedose.apps`

### Erro: "Invalid credentials"

**Solução:**
- Verifique se `APPLE_ID` está correto
- Se usar App-Specific Password, gere uma nova
- Se usar API Key, verifique se o arquivo `.p8` está correto

### Erro: "Bundle ID mismatch"

**Solução:**
- Verifique o Bundle ID no `project.pbxproj`
- Certifique-se de que corresponde ao do Provisioning Profile

### Build falha com timeout

**Solução:**
- O timeout padrão é 60 minutos
- Se precisar aumentar, edite `timeout-minutes: 60` no workflow

---

## 📊 Status do Deploy

Após o build bem-sucedido:

1. **TestFlight:**
   - Acesse: https://appstoreconnect.apple.com
   - Vá em **"TestFlight"**
   - O build aparecerá em alguns minutos
   - Distribua para testadores

2. **App Store:**
   - Acesse: https://appstoreconnect.apple.com
   - Vá em **"My Apps"** > **"GuideDose"**
   - O build aparecerá em **"App Store"** > **"TestFlight and Beta"**
   - Submeta para revisão quando estiver pronto

---

## 🔄 Atualizar Secrets

Se precisar atualizar algum secret:

1. Acesse: https://github.com/FraktalSoftwares/GuideDoseApp/settings/secrets/actions
2. Clique no secret que deseja atualizar
3. Clique em **"Update"**
4. Cole o novo valor
5. Clique em **"Update secret"**

---

## 📝 Informações do App

- **Bundle ID:** `com.mycompany.mcguidedose.apps`
- **App Name:** GuideDose
- **Versão atual:** Verificar em `pubspec.yaml`

---

## 🆘 Precisa de Ajuda?

**Documentação oficial:**
- GitHub Actions: https://docs.github.com/en/actions
- App Store Connect API: https://developer.apple.com/documentation/appstoreconnectapi

**Ou me chame que eu te ajudo!**

Giovanni Manzatto - giovanni.manzatto@fraktalsoftwares.com.br

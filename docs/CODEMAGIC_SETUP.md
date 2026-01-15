# 🚀 Configuração do Codemagic para iOS - GuideDose

Este guia explica passo a passo como configurar o Codemagic para fazer build e deploy automático do app GuideDose para o TestFlight/App Store.

## 📋 Pré-requisitos

- Conta Apple Developer (US$ 99/ano)
- Conta GitHub com acesso ao repositório `FraktalSoftwares/GuideDoseApp`
- Conta Codemagic (gratuita - 500 minutos/mês)

---

## 🔧 Passo 1: Criar App Store Connect API Key

1. Acesse: https://appstoreconnect.apple.com/access/api
2. Clique em **"Keys"** no menu lateral
3. Clique no botão **"+"** (Generate API Key)
4. Preencha:
   - **Name:** `Codemagic GuideDose`
   - **Access:** `Developer` (ou `Admin` se necessário)
5. Clique em **"Generate"**
6. **IMPORTANTE:** Baixe o arquivo `.p8` imediatamente (você só pode baixar uma vez!)
7. Anote:
   - **Key ID:** (ex: `ABC123XYZ`)
   - **Issuer ID:** (ex: `12345678-1234-1234-1234-123456789012`)

---

## 🔑 Passo 2: Criar Certificado de Distribuição

1. Acesse:  
2. Clique em **"+"** para criar novo certificado
3. Selecione **"iOS Distribution"**
4. Siga as instruções para criar o certificado
5. Baixe o arquivo `.cer`
6. **No Mac:**
   - Abra o Keychain Access
   - Importe o arquivo `.cer`
   - Clique com botão direito no certificado > **"Export"**
   - Salve como `.p12` e defina uma senha (anote essa senha!)

---

## 📱 Passo 3: Criar Provisioning Profile

1. Acesse: https://developer.apple.com/account/resources/profiles
2. Clique em **"+"** para criar novo profile
3. Selecione **"App Store"**
4. Selecione o **App ID:** `com.mycompany.mcguidedose.apps`
5. Selecione o **certificado** criado no passo anterior
6. Dê um nome (ex: `GuideDose App Store`)
7. Baixe o arquivo `.mobileprovision`

---

## 🔐 Passo 4: Converter Arquivos para Base64

Você precisa converter os arquivos para base64 para adicionar no Codemagic:

### No Windows (PowerShell):

```powershell
# Converter certificado .p12 para base64
[Convert]::ToBase64String([IO.File]::ReadAllBytes("C:\caminho\para\certificado.p12"))

# Converter provisioning profile para base64
[Convert]::ToBase64String([IO.File]::ReadAllBytes("C:\caminho\para\profile.mobileprovision"))

# Converter arquivo .p8 para base64
[Convert]::ToBase64String([IO.File]::ReadAllBytes("C:\caminho\para\AuthKey_XXXXX.p8"))
```

### No Mac/Linux:

```bash
# Certificado .p12
base64 -i certificado.p12 -o certificado_base64.txt

# Provisioning profile
base64 -i profile.mobileprovision -o profile_base64.txt

# Arquivo .p8
base64 -i AuthKey_XXXXX.p8 -o key_base64.txt
```

---

## 🌐 Passo 5: Configurar Codemagic

### 5.1. Criar Conta e Conectar Repositório

1. Acesse: https://codemagic.io/signup
2. Faça login com sua conta **GitHub**
3. Clique em **"Add application"**
4. Selecione o repositório: **`FraktalSoftwares/GuideDoseApp`**
5. Escolha **"Flutter App"**
6. Clique em **"Finish: Add application"**

### 5.2. Configurar Code Signing

1. No Codemagic, vá em **"Team settings"** (ícone de engrenagem no canto superior direito)
2. Clique em **"Code signing identities"**
3. Clique em **"Add code signing identity"**
4. Faça upload:
   - **Certificate (.p12):** Seu arquivo `certificado.p12`
   - **Certificate password:** A senha que você definiu
   - **Provisioning profile (.mobileprovision):** Seu arquivo `profile.mobileprovision`
5. Dê um nome (ex: `GuideDose iOS Distribution`)
6. Clique em **"Save"**

### 5.3. Configurar Environment Variables

1. Ainda em **"Team settings"**, clique em **"Environment variables"**
2. Clique em **"Add variable"** e adicione cada uma:

   **a) APP_STORE_CONNECT_ISSUER_ID**
   - **Value:** O Issuer ID anotado no Passo 1
   - **Group:** (deixe vazio ou crie um grupo "iOS")

   **b) APP_STORE_CONNECT_KEY_IDENTIFIER**
   - **Value:** O Key ID anotado no Passo 1
   - **Group:** (mesmo grupo acima)

   **c) APP_STORE_CONNECT_PRIVATE_KEY**
   - **Value:** O conteúdo do arquivo `.p8` em base64 (do Passo 4)
   - **Group:** (mesmo grupo acima)
   - **Secure:** ✅ Marque como seguro

   **d) CERTIFICATE_PRIVATE_KEY**
   - **Value:** O certificado `.p12` em base64 (do Passo 4)
   - **Group:** (mesmo grupo acima)
   - **Secure:** ✅ Marque como seguro

   **e) CERTIFICATE_PASSWORD**
   - **Value:** A senha do certificado `.p12`
   - **Group:** (mesmo grupo acima)
   - **Secure:** ✅ Marque como seguro

3. Clique em **"Save"** para cada variável

### 5.4. Configurar o Workflow

1. Volte para a página do app no Codemagic
2. Clique em **"Start new build"**
3. Selecione o branch (geralmente `main` ou `master`)
4. O workflow **"ios-workflow"** será detectado automaticamente do arquivo `codemagic.yaml`
5. Clique em **"Start new build"**

---

## ✅ Passo 6: Verificar Build e TestFlight

1. O build começará automaticamente
2. Você receberá um email quando o build for concluído
3. O app será enviado automaticamente para o **TestFlight**
4. Acesse: https://appstoreconnect.apple.com
5. Vá em **"My Apps"** > **"GuideDose"** > **"TestFlight"**
6. O build aparecerá em alguns minutos

---

## 📝 Informações do App

- **Bundle ID:** `com.mycompany.mcguidedose.apps`
- **App Name:** GuideDose
- **Versão Atual:** 1.3.6+41
  - **Version Name:** 1.3.6
  - **Build Number:** 41

---

## 🔍 Troubleshooting

### Erro: "No code signing identity found"
- Verifique se o certificado e provisioning profile foram carregados corretamente
- Certifique-se de que o Bundle ID no profile corresponde ao do app

### Erro: "Invalid API Key"
- Verifique se o arquivo `.p8` foi convertido corretamente para base64
- Confirme que o Key ID e Issuer ID estão corretos

### Erro: "Provisioning profile doesn't match"
- Verifique se o provisioning profile foi criado para o Bundle ID correto
- Certifique-se de que o certificado no profile corresponde ao carregado

---

## 📚 Recursos Úteis

- **Documentação Codemagic:** https://docs.codemagic.io/flutter-code-signing/ios-code-signing/
- **App Store Connect:** https://appstoreconnect.apple.com
- **Apple Developer:** https://developer.apple.com/account

---

## 🆘 Suporte

Se precisar de ajuda:
- **Codemagic:** Chat ao vivo no site ou email support@codemagic.io
- **Giovanni Manzatto:** giovanni.manzatto@fraktalsoftwares.com.br


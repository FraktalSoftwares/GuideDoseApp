# Deploy iOS - GuideDose App

## 🍎 Opções para Build iOS no Windows

### Opção 1: Codemagic (RECOMENDADO)

**Vantagens:**
- ✅ Não precisa de Mac
- ✅ Interface visual simples
- ✅ 500 minutos grátis/mês
- ✅ Envia automaticamente para TestFlight

**Passo a passo:**

1. **Acesse:** https://codemagic.io/signup
   - Faça login com sua conta GitHub

2. **Conecte o repositório:**
   - Clique em "Add application"
   - Selecione o repositório: `FraktalSoftwares/GuideDoseApp`
   - Escolha "Flutter App"

3. **Configure os certificados Apple:**
   
   a) **App Store Connect API Key:**
   - Acesse: https://appstoreconnect.apple.com/access/api
   - Clique em "Keys" > "Generate API Key"
   - Dê um nome (ex: "Codemagic")
   - Selecione "Developer" como role
   - Baixe o arquivo `.p8`
   - Anote: `Key ID` e `Issuer ID`
   
   b) **Certificado de Distribuição:**
   - Acesse: https://developer.apple.com/account/resources/certificates
   - Crie um "iOS Distribution" certificate
   - Baixe o arquivo `.cer`
   - Converta para `.p12` (veja instruções abaixo)
   
   c) **Provisioning Profile:**
   - Acesse: https://developer.apple.com/account/resources/profiles
   - Crie um "App Store" profile
   - Selecione o App ID: `com.mycompany.mcguidedose.apps`
   - Selecione o certificado criado acima
   - Baixe o arquivo `.mobileprovision`

4. **Configure no Codemagic:**
   - Vá em "Team settings" > "Code signing identities"
   - Faça upload do certificado `.p12` e provisioning profile
   - Em "Environment variables", adicione:
     - `APP_STORE_CONNECT_ISSUER_ID`
     - `APP_STORE_CONNECT_KEY_IDENTIFIER`
     - `APP_STORE_CONNECT_PRIVATE_KEY` (conteúdo do arquivo .p8 em base64)

5. **Inicie o build:**
   - Clique em "Start new build"
   - Selecione o workflow "ios-workflow"
   - O Codemagic vai fazer o build e enviar para TestFlight automaticamente!

---

### Opção 2: GitHub Actions com macOS Runner

**Vantagens:**
- ✅ Integrado com seu repositório
- ✅ 2000 minutos grátis/mês (conta gratuita)

**Desvantagens:**
- ⚠️ Configuração mais técnica
- ⚠️ Precisa configurar secrets manualmente

**Arquivo já criado:** `.github/workflows/build-and-deploy.yml`

**Você precisa adicionar estes secrets no GitHub:**
1. Acesse: https://github.com/FraktalSoftwares/GuideDoseApp/settings/secrets/actions
2. Adicione:
   - `APPLE_CERTIFICATE_BASE64` (certificado .p12 em base64)
   - `APPLE_CERTIFICATE_PASSWORD` (senha do .p12)
   - `APPLE_PROVISIONING_PROFILE_BASE64` (profile em base64)
   - `APPLE_API_KEY_ID`
   - `APPLE_API_ISSUER_ID`
   - `APPLE_API_KEY_BASE64` (arquivo .p8 em base64)

---

### Opção 3: Usar um Mac (emprestado ou alugado)

Se você tiver acesso a um Mac:

1. Clone o repositório
2. Abra o projeto: `open ios/Runner.xcworkspace`
3. Configure o signing no Xcode
4. Archive: Product > Archive
5. Distribua para TestFlight

---

## 🔑 Como converter certificado para .p12 (se necessário)

**No Mac:**
```bash
# Abra o Keychain Access
# Encontre o certificado "iPhone Distribution"
# Clique com botão direito > Export
# Salve como .p12 e defina uma senha
```

**No Windows (usando OpenSSL):**
```bash
# Instale OpenSSL: https://slproweb.com/products/Win32OpenSSL.html
openssl pkcs12 -export -out certificate.p12 -inkey privateKey.key -in certificate.crt
```

---

## 📝 Informações do App

- **Bundle ID:** `com.mycompany.mcguidedose.apps`
- **App Name:** GuideDose
- **Versão:** 1.0.1 (Build 2)

---

## 🆘 Precisa de Ajuda?

**Codemagic tem suporte excelente:**
- Documentação: https://docs.codemagic.io/flutter-code-signing/ios-code-signing/
- Chat ao vivo no site

**Ou me chame que eu te ajudo!**

Giovanni Manzatto - giovanni.manzatto@fraktalsoftwares.com.br

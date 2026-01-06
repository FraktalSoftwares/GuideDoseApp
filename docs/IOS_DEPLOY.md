# Deploy iOS - GuideDose App

## 🍎 Opções para Build iOS no Windows

### Opção 1: Codemagic (RECOMENDADO) ⭐

**Vantagens:**
- ✅ Não precisa de Mac
- ✅ Interface visual simples
- ✅ 500 minutos grátis/mês
- ✅ Envia automaticamente para TestFlight
- ✅ Configuração completa já preparada

**📖 Guia Completo:**
👉 **Veja o guia detalhado:** [`docs/CODEMAGIC_SETUP.md`](../docs/CODEMAGIC_SETUP.md)

**Resumo rápido:**

1. **Criar App Store Connect API Key** (arquivo `.p8`)
2. **Criar Certificado de Distribuição** (arquivo `.p12`)
3. **Criar Provisioning Profile** (arquivo `.mobileprovision`)
4. **Configurar no Codemagic:**
   - Conectar repositório GitHub
   - Fazer upload dos certificados
   - Adicionar variáveis de ambiente
5. **Iniciar build** - O Codemagic faz tudo automaticamente!

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

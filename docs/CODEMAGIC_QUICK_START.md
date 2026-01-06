# 🚀 Codemagic - Quick Start Guide

## ⚡ Configuração Rápida (5 minutos)

### 1. Criar Conta Codemagic
- Acesse: https://codemagic.io/signup
- Faça login com GitHub
- Conecte o repositório: `FraktalSoftwares/GuideDoseApp`

### 2. Certificados Necessários

Você precisa ter:
- ✅ App Store Connect API Key (arquivo `.p8`)
- ✅ Certificado iOS Distribution (arquivo `.p12`)
- ✅ Provisioning Profile App Store (arquivo `.mobileprovision`)

**Não tem?** Veja o guia completo: [`docs/CODEMAGIC_SETUP.md`](CODEMAGIC_SETUP.md)

### 3. Configurar no Codemagic

**Team Settings > Code Signing:**
- Upload do `.p12` e `.mobileprovision`

**Team Settings > Environment Variables:**
- `APP_STORE_CONNECT_ISSUER_ID`
- `APP_STORE_CONNECT_KEY_IDENTIFIER`
- `APP_STORE_CONNECT_PRIVATE_KEY` (conteúdo do `.p8` em base64)
- `CERTIFICATE_PRIVATE_KEY` (conteúdo do `.p12` em base64)
- `CERTIFICATE_PASSWORD` (senha do `.p12`)

### 4. Iniciar Build

- Clique em "Start new build"
- Selecione o branch
- O workflow `ios-workflow` será usado automaticamente
- Aguarde ~10-15 minutos
- O app será enviado automaticamente para TestFlight! 🎉

---

## 📋 Checklist

- [ ] Conta Codemagic criada
- [ ] Repositório conectado
- [ ] App Store Connect API Key criada (`.p8`)
- [ ] Certificado iOS Distribution criado (`.p12`)
- [ ] Provisioning Profile criado (`.mobileprovision`)
- [ ] Certificados carregados no Codemagic
- [ ] Variáveis de ambiente configuradas
- [ ] Build iniciado

---

## 📝 Informações do App

- **Bundle ID:** `com.mycompany.mcguidedose.apps`
- **Versão:** 1.3.6+41
- **Workflow:** `ios-workflow` (definido em `codemagic.yaml`)

---

## 🆘 Problemas?

Consulte o guia completo: [`docs/CODEMAGIC_SETUP.md`](CODEMAGIC_SETUP.md)


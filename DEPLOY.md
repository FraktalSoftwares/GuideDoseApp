# Guia de Deploy - GuideDose App

## ✅ O que já foi feito

1. **Código enviado para GitHub**: https://github.com/FraktalSoftwares/GuideDoseApp.git
2. **Versão atualizada**: v1.0.1+2
3. **GitHub Actions configurado**: Workflow que faz build automático para Android e iOS

## 📱 Próximos Passos para Deploy

### Android (Google Play Internal Testing)

#### Opção 1: Usar o build do GitHub Actions (Recomendado)
1. Acesse: https://github.com/FraktalSoftwares/GuideDoseApp/actions
2. Clique no workflow "Build and Deploy"
3. Baixe o artifact "android-release" (arquivo .aab)
4. Faça upload no Google Play Console:
   - Acesse: https://play.google.com/console
   - Selecione o app GuideDose
   - Vá em "Testes internos" > "Criar nova versão"
   - Faça upload do arquivo .aab
   - Preencha as notas de versão
   - Clique em "Revisar versão" e depois "Iniciar lançamento"

#### Opção 2: Build local (requer Android Studio)
1. Instale o Android Studio: https://developer.android.com/studio
2. Configure o Android SDK
3. Execute: `flutter build appbundle --release`
4. O arquivo estará em: `build/app/outputs/bundle/release/app-release.aab`
5. Faça upload no Google Play Console

### iOS (TestFlight)

**IMPORTANTE**: Para iOS você precisa de:
- Conta Apple Developer (US$ 99/ano)
- Certificados e Provisioning Profiles configurados
- Um Mac (ou usar serviço de CI/CD na nuvem)

#### Opção 1: Usar Codemagic (Recomendado - tem plano gratuito)
1. Acesse: https://codemagic.io
2. Conecte seu repositório GitHub
3. Configure os certificados da Apple
4. O Codemagic fará o build e enviará para TestFlight automaticamente

#### Opção 2: Usar GitHub Actions com certificados
1. Configure os secrets no GitHub:
   - `APPLE_CERTIFICATE_BASE64`
   - `APPLE_CERTIFICATE_PASSWORD`
   - `APPLE_PROVISIONING_PROFILE_BASE64`
   - `APPLE_API_KEY_ID`
   - `APPLE_API_ISSUER_ID`
   - `APPLE_API_KEY_BASE64`
2. Atualize o workflow `.github/workflows/build-and-deploy.yml`
3. O GitHub Actions fará o build e upload para TestFlight

#### Opção 3: Build local em um Mac
1. Abra o projeto no Xcode: `open ios/Runner.xcworkspace`
2. Configure o signing (Team e Bundle ID)
3. Archive o app: Product > Archive
4. Distribua para TestFlight via Xcode

## 🔑 Configurações Necessárias

### Android - Keystore (para assinar o app)
Se você ainda não tem um keystore, crie um:
```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Depois configure em `android/key.properties`:
```properties
storePassword=<senha>
keyPassword=<senha>
keyAlias=upload
storeFile=<caminho-do-keystore>
```

### iOS - Certificados Apple
1. Acesse: https://developer.apple.com/account
2. Vá em "Certificates, Identifiers & Profiles"
3. Crie:
   - App ID (Bundle ID: com.fraktalsoftwares.guidedose)
   - Distribution Certificate
   - Provisioning Profile (App Store)

## 📝 Notas de Versão (v1.0.1)

**Melhorias:**
- ✅ Corrigido problema de favoritos mostrando dados de outros usuários
- ✅ Implementado RLS (Row Level Security) nas tabelas de favoritos
- ✅ Atualização instantânea ao favoritar/desfavoritar itens
- ✅ Favoritos agora sobem para o topo da lista automaticamente

**Técnico:**
- Habilitado RLS em `medicamentos_fav` e `inducoes_fav`
- Criadas políticas de segurança (SELECT, INSERT, DELETE)
- Adicionado callback `onFavChanged` nos componentes de favorito
- Atualização automática das listas ao modificar favoritos

## 🆘 Precisa de Ajuda?

- **GitHub Actions não funcionando?** Verifique os logs em: https://github.com/FraktalSoftwares/GuideDoseApp/actions
- **Problemas com certificados iOS?** Considere usar Codemagic ou Fastlane
- **Erro no build Android?** Certifique-se de que o keystore está configurado corretamente

## 📞 Contato

Giovanni Manzatto - giovanni.manzatto@fraktalsoftwares.com.br

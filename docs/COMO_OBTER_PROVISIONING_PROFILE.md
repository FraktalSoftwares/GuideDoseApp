# Como Obter o Provisioning Profile para iOS

## Diferença entre .p8 e Provisioning Profile

- **Arquivo .p8**: Chave privada da API do App Store Connect (usado para autenticação na API)
- **Provisioning Profile (.mobileprovision)**: Arquivo que vincula seu app, certificado e dispositivos (necessário para assinar o app)

## Passo a Passo para Obter o Provisioning Profile

### Pré-requisitos

1. Conta Apple Developer ativa
2. App ID criado com o bundle ID `com.mycompany.mcguidedose.apps`
3. Certificado de distribuição (Apple Distribution) criado e instalado

### Passo 1: Acessar o Apple Developer Console

1. Acesse: https://developer.apple.com/account
2. Faça login com sua conta Apple Developer
3. Vá em **Certificates, Identifiers & Profiles**

### Passo 2: Criar/Verificar o App ID

1. No menu lateral, clique em **Identifiers**
2. Procure pelo App ID `com.mycompany.mcguidedose.apps`
3. Se não existir, clique em **+** para criar:
   - **Description**: GuideDose App
   - **Bundle ID**: `com.mycompany.mcguidedose.apps`
   - Selecione as **Capabilities** necessárias (Push Notifications, etc.)
   - Clique em **Continue** e depois **Register**

### Passo 3: Criar o Provisioning Profile

1. No menu lateral, clique em **Profiles**
2. Clique no botão **+** (canto superior esquerdo)
3. Selecione **App Store** (para distribuição via TestFlight/App Store)
4. Clique em **Continue**
5. Selecione o **App ID**: `com.mycompany.mcguidedose.apps`
6. Clique em **Continue**
7. Selecione o **Certificado de Distribuição** (Apple Distribution)
8. Clique em **Continue**
9. Dê um nome ao profile (ex: "GuideDose App Store Distribution")
10. Clique em **Generate**

### Passo 4: Baixar o Provisioning Profile

1. Após criar, você verá a lista de profiles
2. Clique no profile que acabou de criar
3. Clique no botão **Download** (ícone de download)
4. O arquivo será baixado como `GuideDose_App_Store_Distribution.mobileprovision` (ou nome similar)

### Passo 5: Obter o UUID do Provisioning Profile

O UUID é necessário para algumas configurações. Você pode obter de duas formas:

#### Opção A: Via Xcode (se tiver Mac)

1. Abra o Xcode
2. Vá em **Preferences** > **Accounts**
3. Selecione sua conta Apple Developer
4. Clique em **Download Manual Profiles**
5. Os profiles serão salvos em: `~/Library/MobileDevice/Provisioning Profiles/`
6. O nome do arquivo será o UUID (ex: `A1B2C3D4-E5F6-7890-ABCD-EF1234567890.mobileprovision`)

#### Opção B: Via Terminal (Mac) ou PowerShell (Windows)

**No Mac:**
```bash
security cms -D -i GuideDose_App_Store_Distribution.mobileprovision | grep -A1 UUID
```

**No Windows (PowerShell):**
```powershell
# Instale o OpenSSL ou use uma ferramenta online para decodificar
# Ou use o Xcode se tiver acesso a um Mac
```

#### Opção C: Via Site Online

1. Acesse: https://developer.apple.com/account/resources/profiles/list
2. Clique no profile criado
3. O UUID estará visível na página de detalhes

### Passo 6: Converter para Base64 (para GitHub Actions/Codemagic)

Se você precisa do provisioning profile em base64 para usar em CI/CD:

**No Mac/Linux:**
```bash
base64 -i GuideDose_App_Store_Distribution.mobileprovision -o profile_base64.txt
```

**No Windows (PowerShell):**
```powershell
$content = [System.IO.File]::ReadAllBytes("GuideDose_App_Store_Distribution.mobileprovision")
$base64 = [System.Convert]::ToBase64String($content)
$base64 | Out-File -FilePath "profile_base64.txt" -Encoding ASCII
```

### Passo 7: Obter o Nome do Profile (Specifier)

O **Provisioning Profile Specifier** é o nome que você deu ao profile. No exemplo acima seria:
```
GuideDose App Store Distribution
```

Você também pode usar o UUID como specifier em alguns casos.

## Configuração no Projeto

### Para GitHub Actions

Adicione os seguintes secrets no GitHub:

1. `APPLE_PROVISIONING_PROFILE_BASE64`: Conteúdo do arquivo .mobileprovision em base64
2. `PROVISIONING_PROFILE_SPECIFIER`: Nome do profile (ex: "GuideDose App Store Distribution") ou UUID

### Para Codemagic

No Codemagic UI, configure:

1. Vá em **Team settings** > **Code signing identities**
2. Adicione o **Provisioning Profile**:
   - Faça upload do arquivo `.mobileprovision`
   - Ou cole o conteúdo em base64
3. Configure o **Provisioning Profile Specifier** no workflow

## Verificação

Para verificar se o provisioning profile está correto:

1. Abra o arquivo `.mobileprovision` em um editor de texto
2. Procure por:
   - `application-identifier`: Deve conter `com.mycompany.mcguidedose.apps`
   - `TeamIdentifier`: Seu Team ID da Apple
   - `UUID`: O UUID do profile

## Troubleshooting

### Erro: "No provisioning profiles found"

- Verifique se o bundle ID no projeto corresponde ao do profile
- Verifique se o certificado usado no profile está instalado
- Verifique se o profile não expirou (profiles expiram após 1 ano)

### Erro: "Provisioning profile doesn't match bundle identifier"

- Verifique se o bundle ID no `project.pbxproj` está correto: `com.mycompany.mcguidedose.apps`
- Verifique se o App ID no Apple Developer Console corresponde

### Erro: "Certificate not found"

- Certifique-se de que o certificado Apple Distribution está instalado no keychain
- Verifique se o certificado usado no profile é o mesmo que está instalado

## Próximos Passos

Após obter o provisioning profile:

1. Configure no GitHub Actions ou Codemagic conforme instruções acima
2. Teste o build para garantir que está funcionando
3. Faça o deploy para TestFlight

# Configurar Credenciais Apple para Deploy iOS

## Arquivos Disponíveis

Na pasta `D:\GuideDose Apple Atual` você tem:

1. **`Fraktal_GuideDose.mobileprovision`** - Provisioning Profile (12,02 KB)
2. **`fraktal_guidedose.p12`** - Certificado Apple Distribution (3,01 KB)
3. **`profile_base64.txt`** - Provisioning Profile em base64 (gerado automaticamente)

## Configuração no GitHub Actions

### Passo 1: Adicionar Secrets no GitHub

1. Acesse: https://github.com/FraktalSoftwares/GuideDoseApp/settings/secrets/actions
2. Clique em **New repository secret** para cada um dos seguintes:

#### Secret 1: APPLE_PROVISIONING_PROFILE_BASE64
- **Name**: `APPLE_PROVISIONING_PROFILE_BASE64`
- **Value**: Abra o arquivo `D:\GuideDose Apple Atual\profile_base64.txt` e copie TODO o conteúdo (é uma string muito longa)

#### Secret 2: APPLE_CERTIFICATE_BASE64
- **Name**: `APPLE_CERTIFICATE_BASE64`
- **Value**: Execute no PowerShell:
```powershell
$content = [System.IO.File]::ReadAllBytes("D:\GuideDose Apple Atual\fraktal_guidedose.p12")
$base64 = [System.Convert]::ToBase64String($content)
$base64
```
Copie o resultado completo.

#### Secret 3: APPLE_CERTIFICATE_PASSWORD
- **Name**: `APPLE_CERTIFICATE_PASSWORD`
- **Value**: A senha do certificado .p12 (você deve ter essa senha)

#### Secret 4: APPLE_TEAM_ID
- **Name**: `APPLE_TEAM_ID`
- **Value**: Seu Team ID da Apple (encontre em: https://developer.apple.com/account - canto superior direito)

#### Secret 5: PROVISIONING_PROFILE_SPECIFIER
- **Name**: `PROVISIONING_PROFILE_SPECIFIER`
- **Value**: O nome do provisioning profile (provavelmente "Fraktal GuideDose" ou o UUID do profile)

### Passo 2: Obter o UUID do Provisioning Profile

Para obter o UUID do profile, você pode:

**Opção A: Via Apple Developer Console**
1. Acesse: https://developer.apple.com/account/resources/profiles/list
2. Clique no profile "Fraktal GuideDose"
3. O UUID estará visível na página

**Opção B: Usar o nome do profile**
O workflow do GitHub Actions pode usar o nome do profile ao invés do UUID.

### Passo 3: Verificar o Workflow

O workflow `.github/workflows/ios-deploy.yml` já está configurado para usar esses secrets. Verifique se está correto.

## Configuração no Codemagic

### Passo 1: Adicionar Certificado

1. Acesse o Codemagic: https://codemagic.io
2. Vá em **Team settings** > **Code signing identities**
3. Clique em **Add certificate**
4. Faça upload do arquivo `fraktal_guidedose.p12`
5. Digite a senha do certificado
6. Selecione o tipo: **Apple Distribution**

### Passo 2: Adicionar Provisioning Profile

1. Ainda em **Code signing identities**
2. Clique em **Add provisioning profile**
3. Faça upload do arquivo `Fraktal_GuideDose.mobileprovision`
4. Ou cole o conteúdo em base64 do arquivo `profile_base64.txt`

### Passo 3: Configurar Variáveis de Ambiente

No Codemagic UI, vá em **Environment variables** e adicione:

- `APP_STORE_CONNECT_ISSUER_ID`: Seu Issuer ID (encontre em: https://appstoreconnect.apple.com/access/api)
- `APP_STORE_CONNECT_KEY_IDENTIFIER`: Key ID da sua chave .p8
- `APP_STORE_CONNECT_PRIVATE_KEY`: Conteúdo do arquivo .p8 (se você tiver)

## Verificação

Após configurar, teste o build:

1. **GitHub Actions**: Faça um push para a branch main/master
2. **Codemagic**: Dispare um build manualmente

## Troubleshooting

### Erro: "No provisioning profiles found"
- Verifique se o bundle ID no projeto é `com.mycompany.mcguidedose.apps`
- Verifique se o provisioning profile corresponde ao bundle ID

### Erro: "Certificate not found"
- Verifique se o certificado .p12 está correto
- Verifique se a senha do certificado está correta

### Erro: "Invalid provisioning profile"
- Verifique se o profile não expirou (profiles expiram após 1 ano)
- Verifique se o certificado usado no profile está instalado

## Próximos Passos

1. Configure os secrets no GitHub Actions ou Codemagic
2. Teste o build
3. Faça o deploy para TestFlight

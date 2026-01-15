# 🔐 Como Converter Certificado .p12 para Base64

## 📋 Pré-requisitos

Você precisa ter:
- ✅ Certificado `.p12` exportado do Keychain (Mac) ou gerado
- ✅ Senha do certificado `.p12` (a que você definiu ao exportar)

---

## 🪟 Método 1: PowerShell (Windows) - Recomendado

### Passo 1: Abrir PowerShell

1. Pressione `Win + X`
2. Selecione **"Windows PowerShell"** ou **"Terminal"**

### Passo 2: Navegar até a pasta do certificado

```powershell
cd "C:\caminho\para\seu\certificado"
```

**Exemplo:**
```powershell
cd "D:\Fraktal\MC GuideDose"
```

### Passo 3: Converter para Base64

```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("nome-do-certificado.p12"))
```

**Exemplo completo:**
```powershell
# Se o arquivo está em D:\Fraktal\MC GuideDose\certificado.p12
[Convert]::ToBase64String([IO.File]::ReadAllBytes("D:\Fraktal\MC GuideDose\certificado.p12"))
```

### Passo 4: Copiar o resultado

1. O PowerShell exibirá uma string longa (várias linhas)
2. **Selecione todo o texto** (clique e arraste ou `Ctrl + A`)
3. **Copie** (`Ctrl + C`)
4. Cole no secret `APPLE_CERTIFICATE_BASE64` do GitHub

---

## 🍎 Método 2: Terminal (Mac/Linux)

### Passo 1: Abrir Terminal

1. Pressione `Cmd + Espaço`
2. Digite "Terminal" e pressione Enter

### Passo 2: Navegar até a pasta do certificado

```bash
cd /caminho/para/seu/certificado
```

### Passo 3: Converter para Base64

```bash
base64 -i certificado.p12
```

**Ou salvar em arquivo:**
```bash
base64 -i certificado.p12 -o certificado_base64.txt
```

### Passo 4: Copiar o resultado

1. Se usou `base64 -i`, copie a saída do terminal
2. Se salvou em arquivo, abra `certificado_base64.txt` e copie o conteúdo
3. Cole no secret `APPLE_CERTIFICATE_BASE64` do GitHub

---

## 📝 Script PowerShell Completo (Copiar e Colar)

Crie um arquivo `converter-certificado.ps1` e cole este código:

```powershell
# Script para converter certificado .p12 para base64
Write-Host "🔐 Conversor de Certificado .p12 para Base64" -ForegroundColor Cyan
Write-Host ""

# Solicita o caminho do arquivo
$caminhoArquivo = Read-Host "Digite o caminho completo do arquivo .p12 (ou arraste o arquivo aqui)"

# Remove aspas se o usuário arrastou o arquivo
$caminhoArquivo = $caminhoArquivo -replace '"', ''

# Verifica se o arquivo existe
if (-not (Test-Path $caminhoArquivo)) {
    Write-Host "❌ Arquivo não encontrado: $caminhoArquivo" -ForegroundColor Red
    exit 1
}

# Verifica se é arquivo .p12
if (-not $caminhoArquivo.EndsWith(".p12")) {
    Write-Host "⚠️  Aviso: O arquivo não tem extensão .p12" -ForegroundColor Yellow
    $continuar = Read-Host "Deseja continuar mesmo assim? (S/N)"
    if ($continuar -ne "S" -and $continuar -ne "s") {
        exit 1
    }
}

# Converte para base64
Write-Host ""
Write-Host "🔄 Convertendo..." -ForegroundColor Yellow
try {
    $base64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes($caminhoArquivo))
    
    Write-Host ""
    Write-Host "✅ Conversão concluída!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📋 Base64 (copie tudo abaixo):" -ForegroundColor Cyan
    Write-Host "─" * 60
    Write-Host $base64
    Write-Host "─" * 60
    Write-Host ""
    
    # Pergunta se quer salvar em arquivo
    $salvar = Read-Host "Deseja salvar em um arquivo .txt? (S/N)"
    if ($salvar -eq "S" -or $salvar -eq "s") {
        $arquivoSaida = $caminhoArquivo -replace '\.p12$', '_base64.txt'
        $base64 | Out-File -FilePath $arquivoSaida -Encoding UTF8
        Write-Host "✅ Salvo em: $arquivoSaida" -ForegroundColor Green
    }
    
    Write-Host ""
    Write-Host "📝 Próximo passo: Cole o base64 acima no secret APPLE_CERTIFICATE_BASE64 do GitHub" -ForegroundColor Cyan
    
} catch {
    Write-Host "❌ Erro ao converter: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Read-Host "Pressione Enter para sair"
```

**Como usar:**
1. Salve o código acima em `converter-certificado.ps1`
2. Abra PowerShell na pasta do script
3. Execute: `.\converter-certificado.ps1`
4. Siga as instruções na tela

---

## ⚠️ Importante

### ✅ O que fazer:
- ✅ Copiar **TODO** o texto base64 (pode ter várias linhas)
- ✅ Incluir quebras de linha se houver
- ✅ Verificar se não há espaços extras no início/fim

### ❌ O que NÃO fazer:
- ❌ Não adicionar quebras de linha extras
- ❌ Não adicionar espaços no início ou fim
- ❌ Não copiar apenas parte do texto

---

## 🔍 Verificar se está correto

O base64 deve:
- Começar com letras/números (ex: `MIIKpAIBAzCCCl...`)
- Ter várias linhas (normalmente 10-20 linhas)
- Terminar com `==` ou `=` (marcador de padding)

**Exemplo de base64 válido:**
```
MIIKpAIBAzCCCl8GCSqGSIb3DQEHAaCCCk8EggpLMIIKRzCCBXcGCSqGSIb3DQEH
BqCCBWgwggVkAgEAMIIFXQYJKoZIhvcNAQcBMBwGCiqGSIb3DQEMAQYwDgQI...
```

---

## 🆘 Problemas Comuns

### Erro: "Arquivo não encontrado"
**Solução:** Verifique o caminho. Use caminho completo ou arraste o arquivo para o PowerShell.

### Erro: "Acesso negado"
**Solução:** Execute o PowerShell como Administrador ou verifique permissões do arquivo.

### Base64 muito curto
**Solução:** Certifique-se de copiar TODO o texto, incluindo todas as linhas.

### Como saber o tamanho correto?
Um certificado `.p12` geralmente gera um base64 de:
- **Pequeno:** ~2-3 KB (1-2 linhas) - pode estar incompleto
- **Normal:** ~5-15 KB (10-30 linhas) - correto
- **Grande:** ~20+ KB (40+ linhas) - também pode estar correto

---

## 📝 Próximos Passos

Após converter:

1. ✅ Copie o base64 completo
2. ✅ Acesse: https://github.com/FraktalSoftwares/GuideDoseApp/settings/secrets/actions
3. ✅ Crie/edite o secret `APPLE_CERTIFICATE_BASE64`
4. ✅ Cole o base64
5. ✅ Salve

**Também configure:**
- `APPLE_CERTIFICATE_PASSWORD` → Senha do certificado `.p12`

---

## 💡 Dica

Se você tiver o certificado em outro formato (`.cer`, `.crt`), primeiro converta para `.p12`:

**No Mac (Keychain Access):**
1. Importe o `.cer` no Keychain
2. Clique com botão direito > Export
3. Escolha formato `.p12`
4. Defina uma senha

**No Windows (OpenSSL):**
```bash
openssl pkcs12 -export -out certificado.p12 -inkey privateKey.key -in certificado.crt
```

---

## 🆘 Precisa de Ajuda?

Se tiver problemas, verifique:
1. O arquivo `.p12` existe e está acessível?
2. Você tem permissão para ler o arquivo?
3. O PowerShell/Terminal está na pasta correta?

**Ou me chame que eu te ajudo!**

Giovanni Manzatto - giovanni.manzatto@fraktalsoftwares.com.br

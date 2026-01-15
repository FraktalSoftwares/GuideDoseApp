# Script para converter certificado .p12 para base64
# Uso: .\converter-certificado.ps1

Write-Host ""
Write-Host "🔐 Conversor de Certificado .p12 para Base64" -ForegroundColor Cyan
Write-Host "=" * 60
Write-Host ""

# Solicita o caminho do arquivo
Write-Host "📁 Digite o caminho completo do arquivo .p12" -ForegroundColor Yellow
Write-Host "   (ou arraste o arquivo aqui e pressione Enter)" -ForegroundColor Gray
Write-Host ""
$caminhoArquivo = Read-Host "Caminho"

# Remove aspas se o usuário arrastou o arquivo
$caminhoArquivo = $caminhoArquivo -replace '"', ''
$caminhoArquivo = $caminhoArquivo.Trim()

# Verifica se o arquivo existe
if (-not (Test-Path $caminhoArquivo)) {
    Write-Host ""
    Write-Host "❌ ERRO: Arquivo não encontrado!" -ForegroundColor Red
    Write-Host "   Caminho: $caminhoArquivo" -ForegroundColor Gray
    Write-Host ""
    Write-Host "💡 Dica: Use o caminho completo ou arraste o arquivo para o PowerShell" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Pressione Enter para sair"
    exit 1
}

# Verifica se é arquivo .p12
if (-not $caminhoArquivo.EndsWith(".p12")) {
    Write-Host ""
    Write-Host "⚠️  AVISO: O arquivo não tem extensão .p12" -ForegroundColor Yellow
    Write-Host "   Arquivo: $caminhoArquivo" -ForegroundColor Gray
    $continuar = Read-Host "   Deseja continuar mesmo assim? (S/N)"
    if ($continuar -ne "S" -and $continuar -ne "s") {
        Write-Host ""
        Write-Host "Operação cancelada." -ForegroundColor Gray
        Read-Host "Pressione Enter para sair"
        exit 0
    }
}

# Converte para base64
Write-Host ""
Write-Host "🔄 Convertendo arquivo para base64..." -ForegroundColor Yellow
Write-Host ""

try {
    $base64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes($caminhoArquivo))
    
    Write-Host "✅ Conversão concluída com sucesso!" -ForegroundColor Green
    Write-Host ""
    Write-Host "=" * 60
    Write-Host "📋 BASE64 (copie TODO o texto abaixo):" -ForegroundColor Cyan
    Write-Host "=" * 60
    Write-Host ""
    Write-Host $base64 -ForegroundColor White
    Write-Host ""
    Write-Host "=" * 60
    Write-Host ""
    
    # Pergunta se quer salvar em arquivo
    Write-Host "💾 Deseja salvar o base64 em um arquivo .txt?" -ForegroundColor Yellow
    $salvar = Read-Host "   (S/N)"
    
    if ($salvar -eq "S" -or $salvar -eq "s") {
        $arquivoSaida = $caminhoArquivo -replace '\.p12$', '_base64.txt'
        if ($arquivoSaida -eq $caminhoArquivo) {
            $arquivoSaida = $caminhoArquivo + "_base64.txt"
        }
        
        $base64 | Out-File -FilePath $arquivoSaida -Encoding UTF8 -NoNewline
        Write-Host ""
        Write-Host "✅ Base64 salvo em:" -ForegroundColor Green
        Write-Host "   $arquivoSaida" -ForegroundColor Cyan
        Write-Host ""
    }
    
    Write-Host ""
    Write-Host "📝 PRÓXIMOS PASSOS:" -ForegroundColor Cyan
    Write-Host "   1. Copie TODO o base64 acima" -ForegroundColor Gray
    Write-Host "   2. Acesse: https://github.com/FraktalSoftwares/GuideDoseApp/settings/secrets/actions" -ForegroundColor Gray
    Write-Host "   3. Crie/edite o secret: APPLE_CERTIFICATE_BASE64" -ForegroundColor Gray
    Write-Host "   4. Cole o base64 e salve" -ForegroundColor Gray
    Write-Host ""
    
} catch {
    Write-Host ""
    Write-Host "❌ ERRO ao converter o arquivo!" -ForegroundColor Red
    Write-Host "   Erro: $_" -ForegroundColor Gray
    Write-Host ""
    Write-Host "💡 Verifique:" -ForegroundColor Yellow
    Write-Host "   - O arquivo não está corrompido" -ForegroundColor Gray
    Write-Host "   - Você tem permissão para ler o arquivo" -ForegroundColor Gray
    Write-Host "   - O arquivo é realmente um certificado .p12 válido" -ForegroundColor Gray
    Write-Host ""
    Read-Host "Pressione Enter para sair"
    exit 1
}

Write-Host ""
Read-Host "Pressione Enter para sair"

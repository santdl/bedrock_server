#Requires -RunAsAdministrator
<#
.SYNOPSIS
    Corrige e estabiliza a sincronizacao de relogio do Windows, que ja derrubou
    o tunel playit.gg duas vezes (16,8 s em 01/09/2026 e 28,0 s em 17/09/2026).

.DESCRIPTION
    O protocolo de controle do playit valida timestamps e degrada acima de 10 s
    de desvio. Sem sessao de controle estavel o tunel nao serve trafego: a LAN
    continua funcionando, mas o acesso de fora de casa cai (o cliente Bedrock
    mostra erro de "initialconnection").

    Alem do resync imediato, o script ataca as duas causas de o desvio voltar:
      - o servico w32time nao ficar ligado o tempo todo;
      - o w32time RECUSAR correcoes grandes em silencio, pelos limites
        MaxPosPhaseCorrection / MaxNegPhaseCorrection.

    Rode num PowerShell como Administrador. Sem elevacao, w32tm /resync
    retorna "Acesso negado. (0x80070005)".

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\scripts\fix-time-sync.ps1
#>

[CmdletBinding()]
param(
    # Intervalo entre sincronizacoes, em segundos. Padrao do Windows costuma
    # ser muito longo para uma maquina que atrasa sozinha.
    [int] $PollIntervalSeconds = 900,

    # Fontes NTP, em ordem de preferencia. 0x9 = SpecialInterval + Client.
    [string[]] $NtpPeers = @('time.windows.com', 'a.st1.ntp.br', 'pool.ntp.org')
)

$ErrorActionPreference = 'Stop'

function Get-ClockOffsetSeconds {
    # Le o desvio pelo stripchart; devolve $null se nao der para medir.
    $out = & w32tm /stripchart /computer:time.windows.com /samples:3 /dataonly 2>&1
    $offsets = $out |
        Select-String -Pattern '([+-]\d+\.\d+)s' |
        ForEach-Object { [double] $_.Matches[0].Groups[1].Value }
    if (-not $offsets) { return $null }
    return [math]::Round(($offsets | Measure-Object -Average).Average, 3)
}

Write-Host '== Desvio antes ==' -ForegroundColor Cyan
$before = Get-ClockOffsetSeconds
if ($null -eq $before) {
    Write-Host 'Nao foi possivel medir (porta 123 bloqueada?). Seguindo assim mesmo.'
} else {
    Write-Host ("offset = {0} s" -f $before)
}

Write-Host '== Servico w32time em automatico ==' -ForegroundColor Cyan
Set-Service -Name w32time -StartupType Automatic
if ((Get-Service w32time).Status -ne 'Running') { Start-Service w32time }

Write-Host '== Fontes NTP e intervalo de poll ==' -ForegroundColor Cyan
$peerList = ($NtpPeers | ForEach-Object { "$_,0x9" }) -join ' '
& w32tm /config /manualpeerlist:"$peerList" /syncfromflags:manual /update | Write-Host

$ntpClient = 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient'
Set-ItemProperty -Path $ntpClient -Name SpecialPollInterval -Value $PollIntervalSeconds -Type DWord

Write-Host '== Liberando correcoes grandes ==' -ForegroundColor Cyan
# 0xFFFFFFFF = sempre corrigir, por maior que seja o desvio. Com o limite
# padrao, um atraso grande e ignorado em silencio - exatamente o caso dos 28 s.
$config = 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Config'
Set-ItemProperty -Path $config -Name MaxPosPhaseCorrection -Value 0xFFFFFFFF -Type DWord
Set-ItemProperty -Path $config -Name MaxNegPhaseCorrection -Value 0xFFFFFFFF -Type DWord

Write-Host '== Aplicando ==' -ForegroundColor Cyan
Restart-Service w32time
& w32tm /resync /force | Write-Host

Write-Host '== Desvio depois ==' -ForegroundColor Cyan
# O w32time corrige por slew (ajuste gradual, ~0,05 s/s), nao por salto: medir
# logo apos o resync mostra o desvio quase intacto e parece falha. Acompanha
# ate convergir, com teto de tempo.
$deadline = (Get-Date).AddMinutes(12)
do {
    $after = Get-ClockOffsetSeconds
    if ($null -eq $after) { break }
    Write-Host ("offset = {0} s" -f $after)
    if ([math]::Abs($after) -lt 1) { break }
    Start-Sleep -Seconds 30
} while ((Get-Date) -lt $deadline)

& w32tm /query /status | Write-Host

if ($null -ne $after -and [math]::Abs($after) -lt 1) {
    Write-Host ''
    Write-Host 'Relogio dentro de 1 s. Agora reinicie o tunel:' -ForegroundColor Green
    Write-Host '    docker compose restart playit'
    Write-Host '    docker compose logs --tail 20 playit'
    Write-Host 'Sucesso = sumir a linha "local timestamp if over 10 seconds off".'
} else {
    Write-Host ''
    Write-Host 'Desvio ainda acima de 1 s. Verifique se a porta 123/udp sai na rede' -ForegroundColor Yellow
    Write-Host 'e veja o log: Get-WinEvent -LogName System | ? ProviderName -eq Microsoft-Windows-Time-Service | Select -First 20'
}

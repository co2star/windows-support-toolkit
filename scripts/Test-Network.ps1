Write-Host "Windows Network Test" -ForegroundColor Cyan
Write-Host "====================" -ForegroundColor Cyan

$config = Get-NetIPConfiguration | Where-Object { $_.NetAdapter.Status -eq 'Up' -and $_.IPv4Address } | Select-Object -First 1

if (-not $config) {
    Write-Host "[FAIL] No active IPv4 network adapter found." -ForegroundColor Red
    exit 1
}

$gateway = $config.IPv4DefaultGateway.NextHop

if ($gateway) {
    if (Test-Connection -ComputerName $gateway -Count 1 -Quiet) {
        Write-Host "[OK] Default gateway reachable: $gateway" -ForegroundColor Green
    } else {
        Write-Host "[FAIL] Default gateway not reachable: $gateway" -ForegroundColor Red
    }
} else {
    Write-Host "[WARN] No default gateway found." -ForegroundColor Yellow
}

if (Test-Connection -ComputerName 1.1.1.1 -Count 1 -Quiet) {
    Write-Host "[OK] Internet IP connectivity works." -ForegroundColor Green
} else {
    Write-Host "[FAIL] Internet IP connectivity failed." -ForegroundColor Red
}

try {
    Resolve-DnsName example.com -ErrorAction Stop | Out-Null
    Write-Host "[OK] DNS name resolution works." -ForegroundColor Green
} catch {
    Write-Host "[FAIL] DNS name resolution failed." -ForegroundColor Red
}

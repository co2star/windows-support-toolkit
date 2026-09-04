$desktop = [Environment]::GetFolderPath('Desktop')
$timestamp = Get-Date -Format 'yyyy-MM-dd_HH-mm-ss'
$reportPath = Join-Path $desktop "Windows-Support-Report_$timestamp.txt"

$os = Get-CimInstance Win32_OperatingSystem
$computer = Get-CimInstance Win32_ComputerSystem
$cpu = Get-CimInstance Win32_Processor | Select-Object -First 1

$lines = @()
$lines += 'WINDOWS SUPPORT REPORT'
$lines += '======================'
$lines += "Generated: $(Get-Date)"
$lines += ''
$lines += 'SYSTEM'
$lines += '------'
$lines += "Computer Name: $env:COMPUTERNAME"
$lines += "Windows: $($os.Caption)"
$lines += "Version: $($os.Version)"
$lines += "Manufacturer: $($computer.Manufacturer)"
$lines += "Model: $($computer.Model)"
$lines += "CPU: $($cpu.Name)"
$lines += "RAM (GB): $([math]::Round($computer.TotalPhysicalMemory / 1GB, 2))"
$lines += ''
$lines += 'DISKS'
$lines += '-----'

Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" | ForEach-Object {
    $size = [math]::Round($_.Size / 1GB, 2)
    $free = [math]::Round($_.FreeSpace / 1GB, 2)
    $lines += "$($_.DeviceID) Size: $size GB | Free: $free GB"
}

$lines += ''
$lines += 'NETWORK'
$lines += '-------'

Get-NetIPConfiguration | Where-Object { $_.NetAdapter.Status -eq 'Up' } | ForEach-Object {
    $lines += "Interface: $($_.InterfaceAlias)"
    $lines += "IPv4: $(($_.IPv4Address.IPAddress) -join ', ')"
    $lines += "Gateway: $(($_.IPv4DefaultGateway.NextHop) -join ', ')"
    $lines += "DNS: $(($_.DNSServer.ServerAddresses) -join ', ')"
    $lines += ''
}

$lines | Out-File -FilePath $reportPath -Encoding UTF8
Write-Host "Support report created: $reportPath" -ForegroundColor Green

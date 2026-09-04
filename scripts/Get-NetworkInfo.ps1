$configs = Get-NetIPConfiguration | Where-Object { $_.NetAdapter.Status -eq 'Up' }

foreach ($config in $configs) {
    [PSCustomObject]@{
        Interface      = $config.InterfaceAlias
        IPv4Address    = ($config.IPv4Address.IPAddress -join ', ')
        DefaultGateway = ($config.IPv4DefaultGateway.NextHop -join ', ')
        DnsServers     = ($config.DNSServer.ServerAddresses -join ', ')
    }
} | Format-Table -AutoSize

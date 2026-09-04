Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" | ForEach-Object {
    $sizeGB = [math]::Round($_.Size / 1GB, 2)
    $freeGB = [math]::Round($_.FreeSpace / 1GB, 2)
    $usedGB = [math]::Round(($_.Size - $_.FreeSpace) / 1GB, 2)

    [PSCustomObject]@{
        Drive   = $_.DeviceID
        SizeGB  = $sizeGB
        UsedGB  = $usedGB
        FreeGB  = $freeGB
        FreePct = if ($_.Size) { [math]::Round(($_.FreeSpace / $_.Size) * 100, 1) } else { 0 }
    }
} | Format-Table -AutoSize

$os = Get-CimInstance Win32_OperatingSystem
$computer = Get-CimInstance Win32_ComputerSystem
$cpu = Get-CimInstance Win32_Processor | Select-Object -First 1

[PSCustomObject]@{
    ComputerName = $env:COMPUTERNAME
    Windows      = $os.Caption
    Version      = $os.Version
    Manufacturer = $computer.Manufacturer
    Model        = $computer.Model
    CPU          = $cpu.Name
    RAM_GB       = [math]::Round($computer.TotalPhysicalMemory / 1GB, 2)
} | Format-List

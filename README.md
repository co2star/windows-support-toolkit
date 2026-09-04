# Windows Support Toolkit

A small PowerShell project for learning and practising common Windows support tasks.

This repository is part of my hands-on learning while I prepare for a **BBL ICT position (MBO level 3/4)** in IT Support / System Administration.

## What this toolkit does

The scripts in this repository help with basic first-line support checks such as:

- Viewing computer and Windows information
- Checking disk space
- Viewing network configuration
- Testing internet/DNS connectivity
- Collecting a simple support report

## Project structure

```text
windows-support-toolkit/
├─ scripts/
│  ├─ Get-SystemInfo.ps1
│  ├─ Get-DiskSpace.ps1
│  ├─ Get-NetworkInfo.ps1
│  ├─ Test-Network.ps1
│  └─ New-SupportReport.ps1
└─ README.md
```

## Scripts

### Get-SystemInfo.ps1
Shows basic system information such as computer name, Windows version, manufacturer, model, CPU and installed memory.

### Get-DiskSpace.ps1
Shows local disks with total, used and free storage in GB.

### Get-NetworkInfo.ps1
Shows active network adapters, IPv4 addresses, default gateway and DNS servers.

### Test-Network.ps1
Runs a simple troubleshooting flow: default gateway check, internet IP check and DNS/name-resolution check.

### New-SupportReport.ps1
Collects system, disk and network information and saves it to a text report on the Desktop.

## How to run

Open PowerShell, go to the repository folder and run a script, for example:

```powershell
.\scripts\Get-SystemInfo.ps1
```

If Windows blocks local scripts, you can run PowerShell for the current session with:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

Only change execution policy when you understand and trust the script you are running.

## What I am learning

With this project I practise:

- PowerShell basics
- Windows troubleshooting
- Reading system information
- Networking fundamentals
- Writing reusable support tools
- Documenting technical work on GitHub

## Next steps

I plan to expand the toolkit with additional safe support checks and improve the reporting output as I learn more.

---

Built as a learning project by **Bahadir Talha Yalaniz**.

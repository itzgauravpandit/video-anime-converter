Write-Host "🚀 Starting Minimal Installer..."

# --- Install PowerShell 7 ---
Write-Host "📥 Installing PowerShell 7..."
$pwshInstaller = "$env:USERPROFILE\Downloads\pwsh.msi"
Invoke-WebRequest -Uri "https://github.com/PowerShell/PowerShell/releases/latest/download/PowerShell-7.4.2-win-x64.msi" -OutFile $pwshInstaller
Start-Process msiexec.exe -Wait -ArgumentList "/i $pwshInstaller /quiet"
Write-Host "✔️ PowerShell 7 installed!"

# --- Install Python 3.10 ---
Write-Host "📥 Installing Python 3.10..."
$pythonInstaller = "$env:USERPROFILE\Downloads\python310.exe"
Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.10.11/python-3.10.11-amd64.exe" -OutFile $pythonInstaller
Start-Process $pythonInstaller -Wait -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1"
Write-Host "✔️ Python installed!"

Write-Host "🎉 Minimal setup complete!"


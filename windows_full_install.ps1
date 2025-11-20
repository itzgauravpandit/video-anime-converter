Write-Host "🚀 Starting Minimal Installer..."

# --- Install PowerShell 7 ---
Write-Host "📥 Installing PowerShell 7..."
$pwshInstaller = "$env:USERPROFILE\Downloads\pwsh.msi"
Invoke-WebRequest -Uri "https://github.com/PowerShell/PowerShell/releases/latest/download/PowerShell-7.4.2-win-x64.msi" -OutFile $pwshInstaller
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$pwshInstaller`" /quiet" -Wait
Write-Host "✔️ PowerShell 7 installed!"

# --- Install Python 3.10 ---
Write-Host "📥 Installing Python 3.10..."
$pythonInstaller = "$env:USERPROFILE\Downloads\python310.exe"
Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.10.11/python-3.10.11-amd64.exe" -OutFile $pythonInstaller
Start-Process -FilePath $pythonInstaller -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
Write-Host "✔️ Python installed!"

Write-Host "🎉 Minimal Setup Complete!"

Write-Host "🚀 Starting Anime Converter Installer (v2)..."

# -------------------------------
# 1. Install PowerShell 7
# -------------------------------
Write-Host "📥 Installing PowerShell 7..."
$pwshInstaller = "$env:USERPROFILE\Downloads\pwsh.msi"
Invoke-WebRequest -Uri "https://github.com/PowerShell/PowerShell/releases/latest/download/PowerShell-7.4.2-win-x64.msi" -OutFile $pwshInstaller
Start-Process msiexec.exe -ArgumentList "/i `"$pwshInstaller`" /quiet" -Wait
Write-Host "✔ PowerShell 7 installed!"

# -------------------------------
# 2. Install Python 3.10
# -------------------------------
Write-Host "📥 Installing Python 3.10..."
$pythonInstaller = "$env:USERPROFILE\Downloads\python310.exe"
Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.10.11/python-3.10.11-amd64.exe" -OutFile $pythonInstaller
Start-Process $pythonInstaller -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
Write-Host "✔ Python installed!"

# -------------------------------
# 3. Install Git
# -------------------------------
Write-Host "📥 Installing Git..."
$gitInstaller = "$env:USERPROFILE\Downloads\git.exe"
Invoke-WebRequest -Uri "https://github.com/git-for-windows/git/releases/latest/download/Git-2.45.1-64-bit.exe" -OutFile $gitInstaller
Start-Process $gitInstaller -ArgumentList "/VERYSILENT /NORESTART" -Wait
Write-Host "✔ Git installed!"

# -------------------------------
# 4. Install FFmpeg
# -------------------------------
Write-Host "📥 Installing FFmpeg..."

$ffmpegZip = "$env:USERPROFILE\Downloads\ffmpeg.zip"
Invoke-WebRequest -Uri "https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-full.7z" -OutFile $ffmpegZip

# 7-zip path (Windows 10+ has internal extractor)
Write-Host "📦 Extracting FFmpeg..."
$ffmpegDir = "$env:ProgramFiles\FFmpeg"
New-Item -ItemType Directory -Path $ffmpegDir -Force | Out-Null

tar -xf $ffmpegZip -C $ffmpegDir

# Add to PATH
$ffmpegBin = (Get-ChildItem -Path $ffmpegDir -Recurse -Directory | Where-Object { $_.Name -eq "bin" }).FullName
[Environment]::SetEnvironmentVariable("Path", "$($env:Path);$ffmpegBin", [EnvironmentVariableTarget]::Machine)

Write-Host "✔ FFmpeg installed!"

# -------------------------------
# 5. Create Project Folder
# -------------------------------
Write-Host "📁 Creating project folder..."
$projectRoot = "$env:USERPROFILE\AnimeConverter"
New-Item -ItemType Directory -Path $projectRoot -Force | Out-Null
Write-Host "✔ Project folder: $projectRoot"

# -------------------------------
# 6. Clone Project Repo
# -------------------------------
Write-Host "⬇ Cloning project files..."
git clone "https://github.com/itzgauravpandit/video-anime-converter.git" "$projectRoot\app"
Write-Host "✔ Repo cloned!"

# -------------------------------
# 7. Setup Python Virtual Env
# -------------------------------
Write-Host "📦 Creating Python venv..."
$envPath = "$projectRoot\venv"
python -m venv $envPath

Write-Host "📍 Activating venv..."
& "$envPath\Scripts\activate"

# -------------------------------
# 8. Install Requirements
# -------------------------------
Write-Host "📥 Installing Python dependencies..."
pip install --upgrade pip
pip install -r "$projectRoot\app\requirements.txt"

Write-Host "🎉 Setup Complete!"

Write-Host "🚀 Starting Anime Converter Installer (v3)..."

# -------------------------------
# 1. Install PowerShell 7
# -------------------------------
Write-Host "📥 Installing PowerShell 7..."
$pwshInstaller = "$env:USERPROFILE\Downloads\pwsh.msi"
Invoke-WebRequest -Uri "https://github.com/PowerShell/PowerShell/releases/latest/download/PowerShell-7.4.2-win-x64.msi" -OutFile $pwshInstaller
Start-Process msiexec.exe -ArgumentList "/i `"$pwshInstaller`" /quiet" -Wait
Write-Host "✔ PowerShell 7 installed!"

# -------------------------------
# 2. Install Python 3.10
# -------------------------------
Write-Host "📥 Installing Python 3.10..."
$pythonInstaller = "$env:USERPROFILE\Downloads\python310.exe"
Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.10.11/python-3.10.11-amd64.exe" -OutFile $pythonInstaller
Start-Process $pythonInstaller -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
Write-Host "✔ Python installed!"

# -------------------------------
# 3. Install Git
# -------------------------------
Write-Host "📥 Installing Git..."
$gitInstaller = "$env:USERPROFILE\Downloads\git.exe"
Invoke-WebRequest -Uri "https://github.com/git-for-windows/git/releases/latest/download/Git-2.45.1-64-bit.exe" -OutFile $gitInstaller
Start-Process $gitInstaller -ArgumentList "/VERYSILENT /NORESTART" -Wait
Write-Host "✔ Git installed!"

# -------------------------------
# 4. Install FFmpeg
# -------------------------------
Write-Host "📥 Installing FFmpeg..."
$ffmpegZip = "$env:USERPROFILE\Downloads\ffmpeg.7z"
Invoke-WebRequest -Uri "https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-full.7z" -OutFile $ffmpegZip

$ffmpegDir = "$env:ProgramFiles\FFmpeg"
New-Item -ItemType Directory -Path $ffmpegDir -Force | Out-Null

tar -xf $ffmpegZip -C $ffmpegDir

$ffmpegBin = (Get-ChildItem -Path $ffmpegDir -Recurse -Directory | Where-Object { $_.Name -eq "bin" }).FullName
[Environment]::SetEnvironmentVariable("Path", "$($env:Path);$ffmpegBin", [EnvironmentVariableTarget]::Machine)

Write-Host "✔ FFmpeg installed!"

# -------------------------------
# 5. Create Project Folder
# -------------------------------
$projectRoot = "$env:USERPROFILE\AnimeConverter"
New-Item -ItemType Directory -Path $projectRoot -Force | Out-Null
Write-Host "📁 Project root: $projectRoot"

# -------------------------------
# 6. Clone Repo
# -------------------------------
Write-Host "⬇ Cloning project repo..."
git clone "https://github.com/itzgauravpandit/video-anime-converter.git" "$projectRoot\app"
Write-Host "✔ Repo cloned!"

# -------------------------------
# 7. Virtual Environment
# -------------------------------
Write-Host "📦 Creating venv..."
$envPath = "$projectRoot\venv"
python -m venv $envPath
Write-Host "✔ venv created!"

# -------------------------------
# 8. Install Python Dependencies
# -------------------------------
Write-Host "📦 Installing dependencies..."

& "$envPath\Scripts\activate"
pip install --upgrade pip
pip install -r "$projectRoot\app\requirements.txt"

Write-Host "✔ Dependencies installed!"

# -------------------------------
# 9. Download Models
# -------------------------------
Write-Host "📥 Downloading AI Models..."

$modelsPath = "$projectRoot\models"
New-Item -ItemType Directory -Path $modelsPath -Force | Out-Null

# Example: AnimeGAN model
Invoke-WebRequest -Uri "https://github.com/TachibanaYoshino/AnimeGANv2/releases/download/1.0/face_paint_512_v2.pt" `
    -OutFile "$modelsPath\animegan.pt"

Write-Host "✔ Models downloaded!"

# -------------------------------
# 10. Create Desktop Launcher (BAT)
# -------------------------------
Write-Host "🖥 Creating Desktop Launcher..."

$batPath = "$env:USERPROFILE\Desktop\Run_Anime_Converter.bat"

$batContent = @"
@echo off
cd "$projectRoot"
call venv\Scripts\activate
python app\main.py
pause
"@

Set-Content -Path $batPath -Value $batContent -Encoding ASCII

Write-Host "✔ Desktop Launcher Created: $batPath"

# -------------------------------
# 11. Create Start Script (PowerShell)
# -------------------------------
$startScript = @"
Write-Host 'Starting Anime Converter...'
cd "$projectRoot"
& "$projectRoot\venv\Scripts\python.exe" "$projectRoot\app\main.py"
"@

Set-Content -Path "$projectRoot\start.ps1" -Value $startScript -Encoding UTF8

Write-Host "🎉 Installation Complete!"
Write-Host "➡ Run using Desktop Launcher: 'Run_Anime_Converter.bat'"

# ============================
#  FULL PROJECT AUTO-INSTALLER
#  PowerShell 7 + Python + FFmpeg + Anime Converter Project
# ============================

Write-Host "🚀 Starting Full Installer..."

# ---------------------------
# 1. Install PowerShell 7
# ---------------------------
Write-Host "📥 Installing PowerShell 7..."

$pwshInstaller = "$env:USERPROFILE\Downloads\pwsh.msi"
Invoke-WebRequest -Uri "https://github.com/PowerShell/PowerShell/releases/latest/download/PowerShell-7.4.2-win-x64.msi" -OutFile $pwshInstaller
Start-Process msiexec.exe -Wait -ArgumentList "/i $pwshInstaller /quiet"

Write-Host "✔️ PowerShell 7 installed!"

# ---------------------------
# 2. Install Python 3.10
# ---------------------------
Write-Host "📥 Installing Python 3.10..."

$pythonInstaller = "$env:USERPROFILE\Downloads\python310.exe"
Invoke-WebRequest "https://www.python.org/ftp/python/3.10.11/python-3.10.11-amd64.exe" -OutFile $pythonInstaller
Start-Process $pythonInstaller -Wait -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1"

Write-Host "✔️ Python installed!"

# ---------------------------
# 3. Install FFmpeg
# ---------------------------
Write-Host "📥 Installing FFmpeg..."

$ffmpegZip = "$env:USERPROFILE\Downloads\ffmpeg.zip"
Invoke-WebRequest "https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip" -OutFile $ffmpegZip

Expand-Archive -Path $ffmpegZip -DestinationPath "C:\ffmpeg" -Force

setx /M PATH "%PATH%;C:\ffmpeg\ffmpeg-*/bin"

Write-Host "✔️ FFmpeg installed!"

# ---------------------------
# 4. Create project folder
# ---------------------------
Write-Host "📁 Creating project folder..."

$project = "C:\video_anime_converter"
New-Item -ItemType Directory -Force -Path $project

Write-Host "✔️ Folder created!"

# ---------------------------
# 5. Install dependencies (for AnimateDiff / Anime conversion)
# ---------------------------
Write-Host "📦 Installing AI dependencies..."

Start-Process pwsh -Wait -ArgumentList "-Command", "pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121"
Start-Process pwsh -Wait -ArgumentList "-Command", "pip install opencv-python moviepy fastapi uvicorn pillow numpy"
Start-Process pwsh -Wait -ArgumentList "-Command", "pip install diffusers transformers accelerate"

Write-Host "✔️ Dependencies installed!"

# ---------------------------
# 6. Create FastAPI Web App
# ---------------------------
Write-Host "🌐 Setting up your local website..."

@"
from fastapi import FastAPI, UploadFile
import uvicorn
import moviepy.editor as mp
import os

app = FastAPI()

@app.post("/convert")
async def convert(file: UploadFile):
    input_path = f"input.mp4"
    output_path = f"output_anime.mp4"

    with open(input_path, "wb") as f:
        f.write(await file.read())

    # Dummy effect (placeholder for AI model)
    clip = mp.VideoFileClip(input_path).fx(mp.vfx.colorx, 1.5)
    clip.write_videofile(output_path)

    return {"status": "done", "result": output_path}

uvicorn.run(app, host="0.0.0.0", port=8000)
"@ | Out-File "$project\app.py"

Write-Host "✔️ Web app created!"

# ---------------------------
# 7. Create launcher
# ---------------------------
Write-Host "⚡ Creating run script..."

@"
@echo off
cd C:\video_anime_converter
pwsh -Command "uvicorn app:app --host 0.0.0.0 --port 8000"
"@ | Out-File "$project\Run_Anime_Converter.bat"

Write-Host "✔️ Launcher created!"

Write-Host "`n🎉 INSTALLATION COMPLETE!"
Write-Host "➡️ Run the converter anytime using: C:\video_anime_converter\Run_Anime_Converter.bat"

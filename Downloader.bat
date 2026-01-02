@echo off
cd /d "%~dp0"
title YouTube Playlist Downloader (Akbyte)

echo ===============================
echo  YouTube Playlist Downloader
echo ===============================
echo.

:: Check yt-dlp
if not exist yt-dlp.exe (
  echo ❌ yt-dlp.exe not found!
  echo Download it from:
  echo https://github.com/yt-dlp/yt-dlp/releases/latest
  pause
  exit
)

:: Check ffmpeg
if not exist ffmpeg.exe (
  echo.
  echo FFmpeg not found.
  echo Downloading FFmpeg automatically...
  echo.

  powershell -Command ^
   "Invoke-WebRequest https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip -OutFile ffmpeg.zip"

  powershell -Command "Expand-Archive ffmpeg.zip ffmpeg-temp -Force"

  for /r ffmpeg-temp %%f in (ffmpeg.exe) do copy "%%f" ffmpeg.exe >nul
  for /r ffmpeg-temp %%f in (ffprobe.exe) do copy "%%f" ffprobe.exe >nul

  del ffmpeg.zip
  rmdir /s /q ffmpeg-temp
)

echo.
set /p url=Paste YouTube Playlist URL: 

echo.
echo Downloading playlist...
echo.

yt-dlp.exe -f "bv*+ba/b" --merge-output-format mp4 ^
-o "Downloads/%(playlist_title)s/%(playlist_index)s - %(title)s.%(ext)s" "%url%"

echo.
echo ===============================
echo Done! Files saved in Downloads folder
echo ===============================
pause

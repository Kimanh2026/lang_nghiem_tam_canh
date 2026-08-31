@echo off
cd /d "c:\Users\nkima\OneDrive\Documents\Edit Video\lang_nghiem_tam_canh\build\web"
start "App Lang Nghiem" /MIN python -m http.server 8088
timeout /t 1 /nobreak >nul
start "" "http://localhost:8088"

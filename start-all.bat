@echo off
cd /d "C:\Users\MINIOS\Desktop\caminatas-tribu"

echo Iniciando servidor local en puerto 8020...
start "Servidor Agendatribu" python -m http.server 8020 --bind 0.0.0.0

timeout /t 3 /nobreak >nul

echo Iniciando Tailscale Funnel...
start "Tailscale Funnel" tailscale funnel 8020

echo.
echo Procesos iniciados. Cerrá estas ventanas cuando quieras detenerlos.
pause

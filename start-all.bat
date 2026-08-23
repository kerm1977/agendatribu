@echo off
cd /d "C:\Users\MINIOS\Desktop\caminatas-tribu"

echo Matando procesos anteriores...
taskkill /F /FI "WINDOWTITLE eq Servidor Agendatribu" >nul 2>&1
taskkill /F /FI "WINDOWTITLE eq Tailscale Funnel" >nul 2>&1

timeout /t 2 /nobreak >nul

echo Iniciando servidor local en puerto 8020...
start "Servidor Agendatribu" python -m http.server 8020 --bind 0.0.0.0

timeout /t 3 /nobreak >nul

echo Iniciando Tailscale Funnel...
start "Tailscale Funnel" tailscale funnel 8020

echo.
echo Todo reiniciado desde cero. Cerrá esta ventana cuando quieras.
pause

@echo off
cd /d "C:\Users\MINIOS\Desktop\caminatas-tribu"

echo.
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
echo Watchdog iniciado. Revisando conexion cada 10 segundos...
echo Cerrá esta ventana para detener todo.

:loop
ping -n 1 -w 5000 8.8.8.8 >nul 2>&1
if %errorlevel%==0 (
    tasklist | find /I "tailscale.exe" >nul 2>&1
    if %errorlevel%==1 (
        echo %date% %time% - Internet OK pero Funnel caido. Reiniciando...
        taskkill /F /FI "WINDOWTITLE eq Tailscale Funnel" >nul 2>&1
        timeout /t 2 /nobreak >nul
        start "Tailscale Funnel" tailscale funnel 8020
    ) else (
        echo %date% %time% - Internet OK, Funnel activo.
    )
) else (
    echo %date% %time% - Sin internet. Deteniendo Funnel...
    taskkill /F /FI "WINDOWTITLE eq Tailscale Funnel" >nul 2>&1
)

timeout /t 10 /nobreak >nul
goto loop

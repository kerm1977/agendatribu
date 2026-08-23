@echo off
cd /d "C:\Users\MINIOS\Desktop\caminatas-tribu"
python -m http.server 8020 --bind 0.0.0.0
pause

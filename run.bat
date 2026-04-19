@echo off
REM 분석 실행 스크립트
REM 사용: scripts 폴더에서 run.bat 더블클릭

if not exist "venv\" (
    echo [!] venv가 없습니다. 먼저 install.bat를 실행하세요.
    pause
    exit /b 1
)

chcp 65001 >nul
set PYTHONUTF8=1
set PYTHONIOENCODING=utf-8

call venv\Scripts\activate.bat
python trading_system.py
pause

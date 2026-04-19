@echo off
REM Windows Python 자동 설치/세팅 스크립트
REM 사용: scripts 폴더에서 install.bat 더블클릭

echo ============================================================
echo  DW-Dashboard Trading System - Python Setup
echo ============================================================

REM Python 설치 여부 확인
where python >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [!] Python이 설치되어 있지 않습니다.
    echo.
    echo 다음 중 하나를 선택:
    echo   1^) https://www.python.org/downloads/  에서 Python 3.11+ 다운로드
    echo      설치 시 "Add Python to PATH" 체크 필수
    echo   2^) Microsoft Store에서 "Python 3.11" 검색 후 설치
    echo.
    pause
    exit /b 1
)

echo [OK] Python 발견
python --version

REM pip 업그레이드
echo.
echo [1/3] pip 업그레이드...
python -m pip install --upgrade pip

REM 가상환경 생성 (선택)
if not exist "venv\" (
    echo.
    echo [2/3] 가상환경 생성...
    python -m venv venv
)

REM 가상환경 활성화 + 패키지 설치
echo.
echo [3/3] 패키지 설치...
call venv\Scripts\activate.bat
pip install -r requirements.txt

echo.
echo ============================================================
echo  설치 완료!
echo ============================================================
echo.
echo 실행 방법:
echo   venv\Scripts\activate.bat
echo   python trading_system.py
echo.
pause

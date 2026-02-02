@echo off
REM Quick Start Script for VERITAS-MED Full Stack
REM Windows PowerShell version

cls
echo.
echo ====================================================
echo    VERITAS-MED - Full Stack Quick Start
echo ====================================================
echo.
echo Prerequisites:
echo   - Python 3.10+ installed
echo   - Node.js 18+ installed
echo   - Ollama running on http://localhost:11434
echo.
echo Steps to get started:
echo.
echo 1. Install Ollama (if not done):
echo    https://ollama.ai
echo    Then run: ollama pull llama3:8b
echo.
echo 2. Start Ollama server:
echo    ollama serve
echo.
echo 3. In a NEW terminal window, start Backend:
echo    cd project
echo    pip install -r requirements.txt
echo    cd src\project
echo    python main.py
echo.
echo 4. In ANOTHER NEW terminal, start Frontend:
echo    cd ui\ui
echo    npm install
echo    npm run dev
echo.
echo 5. Open http://localhost:5173 in your browser
echo.
echo ====================================================
echo Frontend: http://localhost:5173
echo Backend API: http://localhost:8000
echo API Docs: http://localhost:8000/docs
echo ====================================================
echo.
pause

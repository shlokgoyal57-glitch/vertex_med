# Quick Start Script for VERITAS-MED Full Stack
# PowerShell version

Clear-Host

Write-Host ""
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "   VERITAS-MED - Full Stack Quick Start" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Prerequisites:" -ForegroundColor Yellow
Write-Host "  - Python 3.10+ installed"
Write-Host "  - Node.js 18+ installed"
Write-Host "  - Ollama running on http://localhost:11434"
Write-Host ""

Write-Host "Steps to get started:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Install Ollama (if not done):" -ForegroundColor White
Write-Host "   https://ollama.ai"
Write-Host "   Then run: ollama pull llama3:8b"
Write-Host ""

Write-Host "2. Start Ollama server:" -ForegroundColor White
Write-Host "   ollama serve"
Write-Host ""

Write-Host "3. In a NEW PowerShell window, start Backend:" -ForegroundColor White
Write-Host "   cd project"
Write-Host "   pip install -r requirements.txt"
Write-Host "   cd src\project"
Write-Host "   python main.py"
Write-Host ""

Write-Host "4. In ANOTHER NEW PowerShell window, start Frontend:" -ForegroundColor White
Write-Host "   cd ui\ui"
Write-Host "   npm install"
Write-Host "   npm run dev"
Write-Host ""

Write-Host "5. Open http://localhost:5173 in your browser" -ForegroundColor White
Write-Host ""

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "Frontend: http://localhost:5173" -ForegroundColor Green
Write-Host "Backend API: http://localhost:8000" -ForegroundColor Green
Write-Host "API Docs: http://localhost:8000/docs" -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Press any key to continue..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

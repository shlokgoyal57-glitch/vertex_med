# 🚀 Complete Command Reference - VERITAS-MED Integration

All commands needed to run the complete VERITAS-MED system.

---

## 📋 Prerequisites Check

Verify everything is installed:

```bash
# Check Python version
python --version
# Should be 3.10+

# Check Node.js version  
node --version
npm --version
# Should be 18+

# Check Ollama
ollama --version
ollama list
# Should show llama3:8b

# Check if ports are available
netstat -ano | findstr :8000  # Windows
lsof -i :8000                  # Mac/Linux
# Should return: no results (port is free)
```

---

## 🔧 Initial Setup (One-Time Only)

### Install Ollama
```bash
# Download from https://ollama.ai
# Or Windows: winget install Ollama

# After installation, pull the model
ollama pull llama3:8b

# Verify installation
ollama list
# You should see: llama3:8b
```

### Setup Backend
```bash
cd project

# Create virtual environment (optional but recommended)
python -m venv venv
venv\Scripts\activate  # Windows
source venv/bin/activate  # Mac/Linux

# Install dependencies
pip install -r requirements.txt
# This installs: crewai, fastapi, uvicorn, pydantic, etc.
```

### Setup Frontend
```bash
cd ui/ui

# Install Node dependencies
npm install
# This creates node_modules/ with all dependencies

# Verify installation
npm list react
npm list vite
# Should show installed versions
```

---

## ▶️ Running the System

### Terminal 1: Ollama
```bash
# Start Ollama server
ollama serve

# Expected output:
# Listening on 127.0.0.1:11434
# [Keep this running]
```

### Terminal 2: Backend
```bash
cd project/src/project

# Start FastAPI server
python main.py

# Expected output:
# 🏥  MEDIGUARD AI - API Server
# 🚀 Starting API server...
# 📡 API Running at: http://localhost:8000
# [Keep this running]
```

### Terminal 3: Frontend
```bash
cd ui/ui

# Start Vite dev server
npm run dev

# Expected output:
# ➜  Local:   http://localhost:5173/
# ➜  Press h to show help
# [Keep this running]
```

### Terminal 4: Open Browser
```bash
# Option 1: Manual
# Open: http://localhost:5173

# Option 2: Command line
# Windows
start http://localhost:5173

# Mac
open http://localhost:5173

# Linux
xdg-open http://localhost:5173
```

---

## 🧪 Testing Commands

### Test Backend Health
```bash
# Check if backend is running
curl http://localhost:8000/api/health

# Expected response:
# {
#   "status": "healthy",
#   "service": "Mediguard AI",
#   "provider": "Ollama (Local)",
#   "timestamp": "2024-01-31T..."
# }
```

### Test Medical Query Endpoint
```bash
curl -X POST http://localhost:8000/api/query \
  -H "Content-Type: application/json" \
  -d '{"query":"I have a headache"}'

# Expected response:
# {
#   "messages": [...],
#   "emergency": false,
#   "confidence_score": 88.0,
#   "response_time": 3.45
# }
```

### Test Agents Endpoint
```bash
curl http://localhost:8000/api/agents

# Expected response:
# {
#   "agents": [
#     {"name": "Triage Agent", "role": "Medical Triage Specialist", ...},
#     ...
#   ],
#   "total": 4,
#   "timestamp": "..."
# }
```

### Test Trust Report Endpoint
```bash
curl http://localhost:8000/api/trust-report

# Expected response:
# {
#   "overall_score": 88.0,
#   "timestamp": "...",
#   "agents": [...],
#   "confidence_level": "HIGH"
# }
```

### View API Documentation
```bash
# Open in browser:
http://localhost:8000/docs

# This shows interactive API explorer with:
# - All endpoints
# - Request/response examples
# - Schema documentation
# - Try it out feature
```

---

## 🛠️ Build & Deployment Commands

### Build Frontend for Production
```bash
cd ui/ui

# Build optimized bundle
npm run build

# Output: dist/ folder with optimized files
# Deploy dist/ folder to web server

# Preview build locally
npm run preview
# Visit: http://localhost:5000
```

### Run Backend in Production Mode
```bash
cd project/src/project

# Run with production settings
python main.py

# Or with custom settings:
# python -m uvicorn project.main:app --host 0.0.0.0 --port 8000 --workers 4
```

### Run Backend in CLI Mode
```bash
cd project/src/project

# Run original CLI interface
python main.py cli

# This starts the interactive CLI version
```

---

## 🧹 Cleanup & Maintenance Commands

### Clear Browser Cache (Frontend)
```javascript
// In browser console
localStorage.clear()
sessionStorage.clear()
location.reload()
```

### Restart Fresh

#### Windows
```bash
# Kill all Python processes
taskkill /F /IM python.exe

# Kill Node processes
taskkill /F /IM node.exe

# Then restart following "Running the System" section
```

#### Mac/Linux
```bash
# Kill Python processes
pkill -f python

# Kill Node processes  
pkill node

# Then restart following "Running the System" section
```

### Clean Installation

#### Backend
```bash
cd project

# Remove virtual environment
rm -rf venv  # or rmdir /s venv on Windows

# Remove Python cache
rm -rf src/project/__pycache__
rm -rf src/project/**/__pycache__

# Start fresh install (see "Setup Backend" section)
```

#### Frontend
```bash
cd ui/ui

# Remove node_modules
rm -rf node_modules  # or rmdir /s node_modules on Windows

# Remove lock file
rm package-lock.json

# Start fresh install
npm install
```

---

## 🐛 Troubleshooting Commands

### Check if Ports are In Use

```bash
# Windows - Check port 8000
netstat -ano | findstr :8000

# Windows - Check port 5173
netstat -ano | findstr :5173

# Mac/Linux - Check all ports
lsof -i :8000
lsof -i :5173
lsof -i :11434

# If port is in use, kill the process
# Windows
taskkill /PID <PID> /F

# Mac/Linux
kill -9 <PID>
```

### Check If Backend is Responding

```bash
# Simple health check
curl http://localhost:8000/api/health

# Verbose output
curl -v http://localhost:8000/api/health

# Check if server is listening
# Windows
netstat -ano | findstr LISTENING

# Mac/Linux
netstat -tlnp | grep 8000
```

### Check If Frontend is Running

```bash
# Visit in browser
http://localhost:5173

# Check Vite dev server logs
# Look at terminal 3 output for errors

# Check browser console for errors
# F12 → Console tab
```

### Check Ollama Connection

```bash
# Test Ollama endpoint
curl http://localhost:11434/api/tags

# Should show installed models
# {"models": [{"name": "llama3:8b", ...}]}

# If not working, restart Ollama
# Windows: Close and run "ollama serve" again
# Mac: brew services restart ollama
# Linux: systemctl restart ollama
```

### View Backend Logs

```bash
# Terminal 2 should show:
# 🏥  MEDIGUARD AI - API Server
# 🚀 Starting API server...
# [Log messages from requests]

# If not showing, check for Python errors
# Run: python main.py 2>&1

# Check Python version
python --version
```

### View Frontend Logs

```bash
# Terminal 3 should show:
# ➜  Local:   http://localhost:5173/

# Check Vite output for errors
# Should show successful module loads

# Open browser console (F12 → Console)
# Should show no red errors
```

---

## 📊 Monitoring Commands

### Monitor Backend Performance

```bash
# While making requests, observe:
# - Response times in terminal 2
# - CPU usage in system monitor
# - Memory usage

# In Windows Task Manager:
# - Ctrl+Shift+Esc
# - Find "python.exe"
# - Monitor CPU and Memory columns
```

### Monitor Frontend Performance

```bash
# In browser (F12)
# - Network tab: See request times
# - Performance tab: Record runtime performance
# - Console: Check for JavaScript errors

# Check response times in Network tab
# POST /api/query should be 2-4 seconds
```

### Check API Response Times

```bash
# Use curl with timing
curl -w "@curl-format.txt" http://localhost:8000/api/health

# Or use simple timer
# Frontend console:
console.time('query');
// make query
console.timeEnd('query');
```

---

## 🚀 Quick Start Scripts

### Windows Batch Script
```batch
@echo off
REM Copy content from QUICK_START.bat
REM Or just run: QUICK_START.bat
```

### PowerShell Script
```powershell
# Copy content from QUICK_START.ps1
# Or run: powershell -ExecutionPolicy Bypass -File QUICK_START.ps1
```

### Bash Script (Mac/Linux)
```bash
#!/bin/bash

echo "Starting VERITAS-MED..."

# Terminal 1: Ollama
osascript -e 'tell app "Terminal" to do script "ollama serve"'

# Wait for Ollama
sleep 3

# Terminal 2: Backend
osascript -e 'tell app "Terminal" to do script "cd project/src/project && python main.py"'

# Wait for Backend
sleep 2

# Terminal 3: Frontend
osascript -e 'tell app "Terminal" to do script "cd ui/ui && npm run dev"'

# Wait for Frontend
sleep 2

# Terminal 4: Open Browser
open http://localhost:5173

echo "VERITAS-MED started!"
echo "Frontend: http://localhost:5173"
echo "Backend: http://localhost:8000"
echo "API Docs: http://localhost:8000/docs"
```

---

## 📋 Command Checklist

### Daily Startup
- [ ] Open Terminal 1: `ollama serve`
- [ ] Open Terminal 2: `cd project/src/project && python main.py`
- [ ] Open Terminal 3: `cd ui/ui && npm run dev`
- [ ] Wait 5 seconds for all to start
- [ ] Open http://localhost:5173 in browser
- [ ] Check green "Connected" badge in app
- [ ] Test with a medical query
- [ ] Verify trust panel shows data

### Daily Shutdown
- [ ] Type Ctrl+C in Terminal 3 (Frontend)
- [ ] Type Ctrl+C in Terminal 2 (Backend)
- [ ] Type Ctrl+C in Terminal 1 (Ollama)
- [ ] Close all terminals

### Weekly Maintenance
- [ ] Clear browser cache
- [ ] Check Ollama model is loaded: `ollama list`
- [ ] Review application logs for errors
- [ ] Update dependencies: `npm update` and `pip install --upgrade -r requirements.txt`

---

## 📚 Quick Reference

**Frontend**: http://localhost:5173
**Backend API**: http://localhost:8000
**API Docs**: http://localhost:8000/docs
**Ollama**: http://localhost:11434

**Start Ollama**: `ollama serve`
**Start Backend**: `cd project/src/project && python main.py`
**Start Frontend**: `cd ui/ui && npm run dev`

**Test Backend**: `curl http://localhost:8000/api/health`
**Test Query**: `curl -X POST http://localhost:8000/api/query -H "Content-Type: application/json" -d '{"query":"headache"}'`

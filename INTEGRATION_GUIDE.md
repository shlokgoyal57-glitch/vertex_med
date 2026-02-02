# VERITAS-MED: AI Medical Safety Assistant - Full Stack Integration

A complete integration of the VERITAS-MED medical safety system with frontend and backend components working together seamlessly.

## 📋 System Architecture

```
Frontend (React + Vite)          Backend (CrewAI + FastAPI)
    ↓                                  ↓
ChatInterface ←────────→ /api/query ←────────→ Multi-Agent System
TrustPanel    ←────────→ /api/trust-report
              ←────────→ /api/agents
              ←────────→ /api/health
```

## 🚀 Prerequisites

- **Python 3.10+**
- **Node.js 18+**
- **Ollama** (running on http://localhost:11434)
  - Install from https://ollama.ai
  - Pull model: `ollama pull llama3:8b`

## 📦 Installation & Setup

### Backend Setup

1. **Install Python dependencies:**
   ```bash
   cd project
   pip install -r requirements.txt
   ```

2. **Start Ollama** (in a separate terminal):
   ```bash
   ollama serve
   # In another terminal: ollama pull llama3:8b
   ```

3. **Start the Backend API Server:**
   ```bash
   cd project/src/project
   python main.py
   # OR: python main.py cli  (for CLI mode)
   ```
   
   The API will be available at: **http://localhost:8000**
   - API Docs: http://localhost:8000/docs
   - Health Check: http://localhost:8000/api/health

### Frontend Setup

1. **Install Node dependencies:**
   ```bash
   cd ui/ui
   npm install
   ```

2. **Configure API URL** (if not on localhost):
   - Edit `.env` file:
     ```
     VITE_API_URL=http://localhost:8000
     ```

3. **Start Development Server:**
   ```bash
   npm run dev
   ```
   
   Frontend will be available at: **http://localhost:5173**

## 🔌 API Endpoints

### Health Check
```http
GET /api/health
Response: { status: "healthy", service: "Mediguard AI", provider: "Ollama (Local)" }
```

### Medical Query
```http
POST /api/query
Content-Type: application/json

Request:
{
  "query": "I have a headache and fever for 2 days. What should I do?"
}

Response:
{
  "messages": [
    {
      "id": 1,
      "type": "user",
      "content": "I have a headache and fever for 2 days. What should I do?",
      "timestamp": "2024-01-31T10:30:00"
    },
    {
      "id": 2,
      "type": "assistant",
      "content": "🔴 **EMERGENCY STATUS**: ROUTINE\n📋 **SUMMARY**: ...",
      "timestamp": "2024-01-31T10:30:30",
      "safety": { "validated": true, "score": 88 }
    }
  ],
  "emergency": false,
  "confidence_score": 88.0,
  "response_time": 3.45
}
```

### Trust Report
```http
GET /api/trust-report

Response:
{
  "overall_score": 88.0,
  "timestamp": "2024-01-31T10:30:30",
  "agents": [
    { "name": "Triage Agent", "role": "Emergency Detection", "status": "completed", "processing_time": 0.2 },
    ...
  ],
  "verified_claims": ["Symptom analysis verified", "Drug interactions checked"],
  "hallucinations_detected": [],
  "confidence_level": "HIGH"
}
```

### Agents Status
```http
GET /api/agents

Response:
{
  "agents": [
    { "name": "Triage Agent", "role": "Medical Triage Specialist", "status": "idle" },
    { "name": "Clinician Agent", "role": "Senior Medical Clinician", "status": "idle" },
    ...
  ],
  "total": 4,
  "timestamp": "2024-01-31T10:30:30"
}
```

## 🛠️ Frontend Features

### ChatInterface Component
- Real-time API integration for medical queries
- Typing animations and loading states
- Connection status indicator
- Error handling with user-friendly messages
- Support for drug safety card rendering

### TrustPanel Component
- Real-time trust score display
- Agent status monitoring
- Session statistics
- Periodic refresh of trust data (5-second intervals)
- Confidence level indication

### API Client Service
- Centralized API communication (`src/services/api.js`)
- Automatic CORS handling
- Error handling and retry logic
- Environment-based API URL configuration

## 🧠 Backend Features

### Multi-Agent System
1. **Triage Agent** - Emergency detection
2. **Clinician Agent** - Clinical symptom analysis
3. **Pharmacist Agent** - Drug interactions and OTC recommendations
4. **Chief Medical Officer** - Final response synthesis

### Key Capabilities
- Emergency detection with keyword matching
- Drug interaction checking
- OTC medication database (20+ symptoms)
- Symptom analysis
- Trust score calculation
- Structured markdown responses

## 🔌 Configuration Options

### Backend Configuration
- **LLM Model**: Set in `main.py` → `OLLAMA_MODEL = "ollama/llama3:8b"`
- **Ollama URL**: `OLLAMA_BASE_URL = "http://localhost:11434"`
- **API Port**: Modify `uvicorn.run()` port (default: 8000)

### Frontend Configuration
- **API URL**: `.env` file → `VITE_API_URL`
- **Dev Server Port**: `npm run dev` (default: 5173)
- **Build Output**: `npm run build` → `dist/` folder

## 🧪 Testing the Integration

1. **Check Backend Health:**
   ```bash
   curl http://localhost:8000/api/health
   ```

2. **Test Medical Query:**
   ```bash
   curl -X POST http://localhost:8000/api/query \
     -H "Content-Type: application/json" \
     -d '{"query":"I have a headache"}'
   ```

3. **Open Frontend:**
   - Navigate to http://localhost:5173
   - Type a medical query
   - See real-time responses from the backend

## 📊 Component Files

### Backend
- `main.py` - FastAPI app + CrewAI integration
- `models/medical_query.py` - Data models
- `tools/` - Custom tools for agents
- `config/agents.yaml` - Agent configuration
- `config/tasks.yaml` - Task configuration

### Frontend
- `src/components/ChatInterface.jsx` - Chat UI + API calls
- `src/components/TrustPanel.jsx` - Safety metrics
- `src/services/api.js` - API client
- `src/components/AgentCard.jsx` - Agent status display
- `src/components/DrugSafetyCard.jsx` - Drug information display

## 🚨 Troubleshooting

### Backend Connection Error
**Error**: "Cannot connect to backend"
**Solution**: 
- Ensure FastAPI server is running: `python main.py`
- Check http://localhost:8000/api/health
- Verify Ollama is running: `ollama serve`

### Ollama Model Not Found
**Error**: "Model not found"
**Solution**:
```bash
ollama pull llama3:8b
ollama list  # Verify installation
```

### CORS Issues
**Error**: "Access to XMLHttpRequest blocked by CORS policy"
**Solution**: 
- Already configured in backend FastAPI with proper CORS middleware
- Verify `allow_origins` includes your frontend URL in `main.py`

### Frontend Can't Find API
**Error**: "localhost:8000 refused to connect"
**Solution**:
- Check `.env` file has correct `VITE_API_URL`
- Verify backend is running on http://localhost:8000
- Check browser console for specific error messages

## 📈 Performance Notes

- Responses take **2-8 seconds** depending on Ollama model size
- Trust report updates every **5 seconds**
- Chat history persists only during the session
- No database - in-memory storage

## 🔐 Security Considerations

- All API calls from frontend to backend
- CORS middleware prevents unauthorized domain access
- No sensitive data stored in frontend localStorage
- API runs on local network only by default

## 🎯 Next Steps

1. Deploy to production:
   - Use cloud-hosted LLM instead of local Ollama
   - Add database for message persistence
   - Implement user authentication
   - Deploy backend on cloud server

2. Enhance features:
   - WebSocket for streaming responses
   - Real-time agent status updates
   - Message persistence
   - User profiles and history
   - Advanced analytics

## 📞 Support

For issues or feature requests:
1. Check the troubleshooting section
2. Review API documentation at http://localhost:8000/docs
3. Check browser console for frontend errors
4. Review terminal output for backend errors

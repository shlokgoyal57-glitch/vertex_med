# 🔌 Frontend-Backend Integration - Technical Reference

## API Contracts & Data Flow

### 1. Medical Query Submission

**Frontend → Backend**
```
POST /api/query
{
  "query": "I have a headache and fever"
}
```

**Backend Processing Flow**
```
Query Input
    ↓
[TRIAGE AGENT] → Emergency detection → Is it urgent?
    ↓
[CLINICIAN AGENT] → Symptom analysis → Medical assessment
    ↓
[PHARMACIST AGENT] → Drug interactions → OTC recommendations
    ↓
[ETHICIST AGENT] → Privacy check → Ethics validated
    ↓
[VALIDATOR AGENT] → Fact checking → Hallucinations detected
    ↓
[CONSENSUS AGENT] → Synthesize → Final formatted response
```

**Backend → Frontend**
```json
{
  "messages": [
    {
      "id": 1,
      "type": "user",
      "content": "I have a headache and fever",
      "timestamp": "2024-01-31T10:30:00",
      "subtype": null,
      "drugData": null,
      "safety": null
    },
    {
      "id": 2,
      "type": "assistant",
      "content": "🔴 **EMERGENCY STATUS**: ROUTINE\n📋 **SUMMARY**: Based on your symptoms...",
      "timestamp": "2024-01-31T10:30:30",
      "subtype": null,
      "drugData": null,
      "safety": {
        "validated": true,
        "score": 88
      }
    },
    {
      "id": 3,
      "type": "assistant",
      "subtype": "drug-info",
      "content": null,
      "timestamp": "2024-01-31T10:30:30",
      "drugData": {
        "name": "Ibuprofen",
        "category": "OTC",
        "indications": "Pain relief, fever reduction",
        "maxDose": "3200mg/day",
        "contraindications": "Stomach ulcers, allergies"
      },
      "safety": {
        "validated": true,
        "score": 92
      }
    }
  ],
  "emergency": false,
  "confidence_score": 88.0,
  "response_time": 3.45
}
```

---

## Component Communication Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                         FRONTEND (React)                        │
│                                                                 │
│  ┌──────────────────────┐  ┌──────────────────────┐            │
│  │  ChatInterface.jsx   │  │  TrustPanel.jsx      │            │
│  │                      │  │                      │            │
│  │ - User input capture │  │ - Trust score       │            │
│  │ - Message display    │  │ - Agent status      │            │
│  │ - API calls          │  │ - Statistics        │            │
│  └──────────────────────┘  └──────────────────────┘            │
│          ↓                          ↓                           │
│  ┌──────────────────────────────────────────────────┐          │
│  │        API Client Service (api.js)               │          │
│  │  ┌────────────────────────────────────────────┐ │          │
│  │  │ • api.query(query)                         │ │          │
│  │  │ • api.getTrustReport()                     │ │          │
│  │  │ • api.getAgents()                          │ │          │
│  │  │ • api.health()                             │ │          │
│  │  └────────────────────────────────────────────┘ │          │
│  └──────────────────────────────────────────────────┘          │
│          ↓                                                      │
│  HTTP Requests over CORS                                       │
└─────────────────────────────────────────────────────────────────┘
                          ↓ ↑
                  (VITE DEV PROXY)
                          ↓ ↑
┌─────────────────────────────────────────────────────────────────┐
│                    BACKEND (FastAPI)                            │
│                                                                 │
│  ┌────────────────────────────────────────────────┐            │
│  │  REST API Endpoints                            │            │
│  │  ┌──────────────────────────────────────────┐ │            │
│  │  │ GET  /api/health                        │ │            │
│  │  │ POST /api/query                         │ │            │
│  │  │ GET  /api/agents                        │ │            │
│  │  │ GET  /api/trust-report                  │ │            │
│  │  └──────────────────────────────────────────┘ │            │
│  └────────────────────────────────────────────────┘            │
│          ↓                                                      │
│  ┌────────────────────────────────────────────────┐            │
│  │  CrewAI Multi-Agent System                     │            │
│  │  ┌──────────────────────────────────────────┐ │            │
│  │  │ • MediguardSystem class                  │ │            │
│  │  │ • create_agents()                        │ │            │
│  │  │ • create_tasks()                         │ │            │
│  │  │ • run_crew_query()                       │ │            │
│  │  └──────────────────────────────────────────┘ │            │
│  └────────────────────────────────────────────────┘            │
│          ↓                                                      │
│  ┌────────────────────────────────────────────────┐            │
│  │  Tools & Knowledge Bases                       │            │
│  │  ┌──────────────────────────────────────────┐ │            │
│  │  │ • Emergency Detector                    │ │            │
│  │  │ • Drug Interaction Checker              │ │            │
│  │  │ • Symptom Analyzer                      │ │            │
│  │  │ • Trust Calculator                      │ │            │
│  │  │ • Medication Database                   │ │            │
│  │  └──────────────────────────────────────────┘ │            │
│  └────────────────────────────────────────────────┘            │
│          ↓                                                      │
│  ┌────────────────────────────────────────────────┐            │
│  │  Ollama LLM                                    │            │
│  │  (llama3:8b running on http://localhost:11434)│            │
│  └────────────────────────────────────────────────┘            │
└─────────────────────────────────────────────────────────────────┘
```

---

## State Management Flow

### Frontend State Management

```
ChatInterface State:
  ├─ messages: Message[]
  │   └─ Each message has: id, type, content, timestamp, safety
  ├─ inputValue: string
  ├─ isTyping: boolean
  ├─ isConnected: boolean
  ├─ error: string | null

TrustPanel State:
  ├─ trustReport: TrustReport
  │   ├─ overall_score: number
  │   ├─ agents: AgentStatus[]
  │   └─ verified_claims: string[]
  ├─ agents: AgentStatus[]
  ├─ loading: boolean
  ├─ stats: Statistics
```

### Backend State Management

```
FastAPI App State:
  ├─ mediguard_system: MediguardSystem instance
  │   ├─ llm: LLM configuration
  │   └─ provider: string ("Ollama (Local)")
  ├─ executor: ThreadPoolExecutor (for async operations)
  └─ agents: Agent[] (created per request)

CrewAI Crew State:
  ├─ agents: Agent[] (6 agents)
  ├─ tasks: Task[] (tasks for current query)
  └─ process: Process (sequential execution)
```

---

## Error Handling Flow

### Frontend Error Handling

```
User Input
    ↓
Validate (not empty, connected)
    ├─ PASS → Send API request
    ├─ FAIL → Show error message to user
    │
    └─→ API Request
            ├─ SUCCESS → Parse response
            │   ├─ Add assistant message
            │   └─ Add drug info card if present
            │
            └─ FAILURE → Error handling
                ├─ Log to console
                ├─ Show error in UI
                ├─ Add error message to chat
                └─ Set error state

Connection Status:
  ├─ Check on mount
  ├─ Refresh every 5 seconds
  ├─ Connected (green) → Enable input
  └─ Disconnected (red) → Disable input + show warning
```

### Backend Error Handling

```
Request Received
    ↓
Validate Query (not empty)
    ├─ PASS → Process
    ├─ FAIL → HTTPException(400)
    │
    └─→ Run CrewAI
            ├─ SUCCESS → Format response
            │
            └─ FAILURE → Fallback response
                └─ Return structured response with "cannot provide" handling
```

---

## API Response Models

### TypeScript/JavaScript Types (Frontend)

```typescript
interface Message {
  id: number;
  type: 'user' | 'assistant';
  content: string;
  timestamp: string;
  subtype?: 'drug-info';
  drugData?: DrugInfo;
  safety?: { validated: boolean; score: number };
}

interface DrugInfo {
  name: string;
  category: string;
  indications: string;
  maxDose: string;
  contraindications: string;
}

interface ConsultationResponse {
  messages: Message[];
  emergency: boolean;
  confidence_score: number;
  response_time: number;
}

interface AgentStatus {
  name: string;
  role: string;
  status: 'processing' | 'completed' | 'idle';
  processing_time?: number;
}

interface TrustReport {
  overall_score: number;
  timestamp: string;
  agents: AgentStatus[];
  verified_claims: string[];
  hallucinations_detected: string[];
  confidence_level: 'LOW' | 'MEDIUM' | 'HIGH';
}
```

### Python Pydantic Models (Backend)

```python
class DrugInfo(BaseModel):
    name: str
    category: str
    indications: str
    maxDose: str
    contraindications: str

class MessageResponse(BaseModel):
    id: int
    type: str  # "user" or "assistant"
    content: str
    timestamp: str
    subtype: str = None
    drugData: DrugInfo = None
    safety: dict = None

class ConsultationResponse(BaseModel):
    messages: list[MessageResponse]
    emergency: bool
    confidence_score: float
    response_time: float

class AgentStatus(BaseModel):
    name: str
    role: str
    status: str
    processing_time: float = 0.0

class TrustReport(BaseModel):
    overall_score: float
    timestamp: str
    agents: list[AgentStatus]
    verified_claims: list[str]
    hallucinations_detected: list[str]
    confidence_level: str
```

---

## Request/Response Timing

```
Timeline:
  0.0s  → User submits query
  0.0s  → Frontend sends HTTP POST /api/query
  0.05s → Backend FastAPI receives request
  0.1s  → CrewAI creates 6 agents
  0.2s  → Triage Agent processes (async)
  0.3s  → Clinician Agent processes (async)
  0.4s  → Pharmacist Agent processes (async)
  0.4s  → Ethicist Agent processes (idle)
  0.5s  → Validator Agent processes (idle)
  0.5s  → Consensus Agent synthesizes results
  2.5s  → CrewAI returns full response
  2.6s  → FastAPI formats response
  2.7s  → HTTP response sent to frontend
  2.75s → Frontend receives response
  2.8s  → Messages rendered + animations
  3.0s  → TrustPanel updates with real data
```

**Total Response Time: ~2.7-3.5 seconds** (depends on Ollama model load)

---

## Environment Configuration

### Backend Environment Variables
```python
# In main.py (hardcoded for now)
OLLAMA_MODEL = "ollama/llama3:8b"
OLLAMA_BASE_URL = "http://localhost:11434"

# Change these for different deployments:
API_HOST = "0.0.0.0"  # Change to 127.0.0.1 for localhost only
API_PORT = 8000       # Change to different port
```

### Frontend Environment Variables
```env
# In .env
VITE_API_URL=http://localhost:8000

# For production:
# VITE_API_URL=https://api.mediguard.com
```

---

## Security Considerations

### CORS Configuration
```python
# Backend allows requests from:
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:5173",      # Vite dev
        "http://localhost:3000",      # Alternative dev
        "http://127.0.0.1:5173",     # Local IP
    ],
    allow_credentials=True,
    allow_methods=["*"],              # Allow all methods
    allow_headers=["*"],              # Allow all headers
)
```

### Frontend Request Headers
```javascript
{
  'Content-Type': 'application/json',
  // Additional headers can be added here
}
```

### No Authentication
⚠️ **Current setup has NO authentication**
- Anyone with access to the backend can use it
- **For production**, add:
  - JWT token authentication
  - Rate limiting
  - API keys
  - User authentication

---

## Performance Optimization Tips

### Frontend
1. **Lazy load** TrustPanel component
2. **Debounce** trust report refresh
3. **Memoize** expensive components
4. **Virtualize** long message lists

### Backend
1. **Cache** agent creation (currently created per request)
2. **Connection pooling** for Ollama
3. **Background tasks** for heavy computations
4. **Load balancing** for multiple instances

### Network
1. **Gzip** responses
2. **HTTP/2** for multiplexing
3. **WebSocket** for streaming responses
4. **Message compression** for large payloads

---

## Debugging & Monitoring

### Frontend Console Logs
```javascript
// API client logs
console.log('API Error:', error);

// Component state
console.log('Chat messages:', messages);
console.log('Trust report:', trustReport);
```

### Backend Console Output
```
🏥  MEDIGUARD AI - API Server
🚀 Starting API server...
📡 API Running at: http://localhost:8000
📊 API Docs: http://localhost:8000/docs
🔌 LLM Provider: Ollama (Local)
```

### API Documentation
Visit http://localhost:8000/docs while backend is running
- Interactive API explorer
- Request/response examples
- Schema documentation

---

## Production Deployment Checklist

- [ ] Replace local Ollama with cloud LLM API (OpenAI, Anthropic, etc.)
- [ ] Add user authentication (JWT, OAuth)
- [ ] Add rate limiting per user
- [ ] Add request/response logging
- [ ] Set up error monitoring (Sentry)
- [ ] Add message persistence (database)
- [ ] Enable HTTPS/TLS
- [ ] Add API request signing
- [ ] Set up CI/CD pipeline
- [ ] Add automated tests
- [ ] Configure production environment variables
- [ ] Set up monitoring dashboards
- [ ] Add backup/disaster recovery

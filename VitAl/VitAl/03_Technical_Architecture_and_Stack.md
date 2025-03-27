# 03_Technical_Architecture_and_Stack.md

## III. Technical Architecture & Data Flow Breakdown

### 1. Programming Languages & Frameworks
- **Swift 5+** (iOS & watchOS development)
- **SwiftUI** for unified UI
- **Combine / Swift Concurrency** for reactive data
- **Core ML** for local analytics
- **OpenAI GPT** integration via user-supplied API key

### 2. Local Data Persistence
- **CoreData or SQLite** for health metrics, logs, user preferences
- **Keychain** for storing API keys securely
- **UserDefaults** for lightweight settings

### 3. HealthKit Integration
- **Read Permissions**:
  - Steps, HR, sleep, etc.
- **Write Permissions** (optional):
  - Only if needed (mood logs or custom metrics)
- **Background Delivery**:
  - HealthKit observer queries to pull updates when new data arrives

### 4. External Data API Usage
- **Weather & AQI**:
  - If user opts in, minimal fetch intervals
- **Location Services**:
  - Minimal usage, event-driven or background fetch if relevant

### 5. AI & Specialized Agents
- **OpenAI GPT-3.5/4**:
  - Invoked for complex conversation
  - User-provided API key
- **On-Device Model**:
  - Basic correlation (sleep vs. steps, etc.) for cost efficiency
- **Specialized Agent Architecture**:
  - Modular approach: Sleep coach, fitness coach, etc.

### 6. Security & Privacy
- **Encryption**:
  - iOS Data Protection for sensitive data
- **Disclaimers**:
  - Managed as UI overlays (not chatbot text)
- **Periodic Consent**:
  - Subtle prompts every ~90 days or user-defined frequency

### 7. Network & Battery Considerations
- **Scheduling**:
  - Batching background tasks for data sync
- **Optimizations**:
  - On-device inference where possible
  - Offload heavier tasks to times when device is idle or charging

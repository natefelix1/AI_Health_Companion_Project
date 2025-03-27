# 04_Data_Flows_and_Privacy.md

## Data Flows & Privacy Model

### 1. Data Flow Diagram (Conceptual)
1. **HealthKit → Local Database**  
   - Pull authorized Apple Health data (steps, sleep, HR)  
   - Store securely in CoreData
2. **Local Analytics**  
   - On-device ML or custom logic processes new data for insights
3. **AI Integration**  
   - For complex queries, send relevant data (or summary) to OpenAI endpoint, user’s API key required
4. **UI Displays**  
   - Render results in SwiftUI dashboards, watchOS glances
5. **Periodic Sync**  
   - Sleep or background tasks overnight to run more in-depth correlations
6. **Optional External Data**  
   - Weather & AQI queries if toggled on
7. **Location Data**  
   - Minimally fetched if user opts in

### 2. Privacy Approach
- **Local-First Principle**  
  - Most analysis happens on device  
  - Only minimal or summary data sent to OpenAI
- **Consent Mechanisms**  
  - Onboarding disclaimers & periodic reminders  
  - Separate toggles for location, external data
- **Data Retention**  
  - Configurable retention periods (by user)  
  - Secure erase if user revokes consent

### 3. Regulatory & Compliance Considerations
- **Apple’s HealthKit Policies**  
  - Data usage restricted to user benefit  
  - Clear disclaimers about usage
- **HIPAA / GDPR**  
  - For personal (non-public) usage initially  
  - Potentially relevant if app goes commercial

### 4. Minimizing Disclaimers
- **App UI**  
  - Embedded disclaimers triggered contextually  
- **No Chatbot Disclaimers**  
  - Chatbot never presents disclaimers  
  - Only the app’s UI does so to maintain user flow

# Phase_1_Foundation.md

## Phase 1: Foundational App, Early AI Companion, and watchOS Parity

### Goal
Deliver a **fully functional** iOS and watchOS app with:
- HealthKit integration
- Basic AI insights
- Customizable dashboards
- Minimal disclaimers
- Immediate usability

---

### 1. Onboarding & Permissions
1. **User Data Capture**  
   - Collect user name, age, health goals, daily routine preferences, notification preferences, etc.
   - Gather broader preferences (sleep focus, nutrition, mental health) for potential future expansions.

2. **Apple HealthKit Authorization**  
   - Request read permissions for relevant data (activity, steps, sleep, heart rate, etc.).

3. **Location & External Data Permissions (Optional)**  
   - User toggles for location services, screen time data, weather/AQI integration.

4. **OpenAI API Key Input**  
   - Securely store user-provided API key in Keychain.

5. **User Consent & Disclaimers**  
   - Single onboarding screen with minimal disclaimers.
   - Action-based disclaimers embedded within the app (not in chatbot).

---

### 2. Core UI & Navigation (iOS + watchOS)
- **Tabs**: Home, Dashboard, Chat (AI Companion), and Settings.
- **watchOS Parallel**:
  - Mirror critical features (daily summary, basic AI chat, quick event marking).

---

### 3. Data Handling & Storage
- **Local Storage**:
  - CoreData / SQLite for analytics and logs
  - Keychain for API keys
- **HealthKit Data Retrieval**:
  - Collect raw (or nearly raw) steps, heart rate, sleep data
  - Schedule periodic fetch (hourly or user-defined)
- **External Data Sources**:
  - Weather, AQI, location if toggled on
  - Minimal usage to avoid battery drain
- **On-Device Analytics**:
  - Basic correlation / anomaly detection
  - Summaries stored locally

---

### 4. Basic AI Companion
- **Initial AI Integration**:
  - GPT-3.5/4 calls using user-supplied OpenAI key
  - Maintain conversation context locally
- **Proactive Suggestions**:
  - 1–2 daily push notifications with basic trend reminders
  - Toggle frequency in settings

---

### 5. Customizable Dashboards
- **Pre-built Templates**:
  - Vital Stats (steps, heart rate, etc.)
  - Sleep & Activity Correlation
  - Mood & HR Trend (if user logs mood or mental health)
- **Drag-and-Drop**:
  - SwiftUI’s built-in reorder capabilities
  - Resizable tiles (small, medium, large)
- **VisionOS-Style Charts**:
  - Translucent backgrounds, minimal grid lines, consistent color theme

---

### 6. Disclaimers & Trigger Logic
- **Persistent Minimal Disclaimer**:
  - Footer or small banner on main screens
- **Action-based Disclaimers**:
  - Appear on data-sharing changes or export attempts
- **Periodic Consent Reminders**:
  - Subtle banner or prompt every ~90 days

---

**End of Phase 1 Deliverable**:
- Usable iOS & watchOS app with:
  - Health dashboards
  - Basic AI insights
  - On-device data handling
  - Minimal disclaimers & friction
  - Real-time Apple Health data
  

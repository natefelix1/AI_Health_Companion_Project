
# AI Health Companion App - Phase 1 Wireframe Specifications

## Device Reference
**Device:** iPhone 16 Pro Max  
**Screen Dimensions:** 1290 x 2796 pixels (~460 ppi)

---

## Screen 1: Onboarding & User Information Capture
- **Header:** "Welcome to AI Health Companion" (SF Semi-Bold, 36pt, centered; margin-top: 100px)
- **Subheader:** "Let's personalize your health journey." (SF Regular, 22pt; margin-top: 20px below header)
- **Inputs:**
  - Full Name (Translucent input, 80% width, height 70px; margin-top: 50px)
  - Age (Numeric input, same dimensions; margin-top: 25px)
- **Health Goals:** Multi-select toggles (220px x 60px each, grid of 2 columns; margin-top: 25px)
- **Routine Preferences:** Dropdown selector (80% width, 70px height; margin-top: 30px)
- **Next Button:** Teal accent (85% width, 75px height; margin-bottom: 50px)

---

## Screen 2: HealthKit Authorization
- **Header:** "Connect Apple Health" (SF Semi-Bold, 36pt; margin-top: 100px)
- **HealthKit Icon:** SF Symbol (120px square; margin-top: 50px below header)
- **Data Categories:** Activity, Steps, Sleep, Heart Rate (SF Regular, 22pt; margin-top: 50px)
- **Authorize Button:** Teal accent (85% width, 75px height; margin-bottom: 50px)

---

## Screen 3: Optional External Data Integration
- **Header:** "Enhance Your Experience" (SF Semi-Bold, 36pt; margin-top: 100px)
- **Description:** SF Regular, 22pt (margin-top: 25px below header)
- **Toggles:** Location, Weather/AQI, Screen Time (70px height, 85% width each; margin-top: 50px)
- **Continue Button:** Teal accent (85% width, 75px height; margin-bottom: 50px)

---

## Screen 4: OpenAI API Key Integration
- **Header:** "Activate AI Companion" (SF Semi-Bold, 36pt; margin-top: 100px)
- **Description:** SF Regular, 22pt (margin-top: 25px below header)
- **Secure Input:** Keychain integration, 80% width, 70px height (margin-top: 50px)
- **Clipboard Button:** Minimal action (opacity 60%; margin-top: 15px)
- **Continue Button:** Teal accent (85% width, 75px height; margin-bottom: 50px)

---

## Screen 5: Consent & Minimal Disclaimer
- **Header:** "Your Privacy & Data" (SF Semi-Bold, 36pt; margin-top: 100px)
- **Description:** "Your data stays securely on-device." (SF Regular, 22pt; margin-top: 25px)
- **Disclaimer:** Persistent footer (SF Regular, 18pt; margin-top: 15px above button)
- **Accept & Continue Button:** Teal accent (85% width, 75px height; margin-bottom: 50px)

---

## Screen 6: Dashboard - Customizable Widgets
- **Header:** "Your Dashboard" (SF Semi-Bold, 32pt; margin-top: 90px)
- **Widgets:** Drag-and-drop, resizable (small: 280px x 400px, medium: 600px x 400px, large: 90% width x 500px; spacing: 30px)
- **Add Widget Button:** Floating teal button, 80px diameter (bottom-right corner, margin: 90px)

---

## Screen 7: AI Companion Chat Screen (Expanded View)
- **Dynamic Island Expansion:** Bubble (90px diameter, expands downward)
- **Chat Area:** Translucent, rounded corners 16pt (90% screen height, blur 25%)
- **Chat History:** User bubbles (right, teal), AI bubbles (left, gray)
- **Chat Input:** 90% width, 70px height, translucent white; send button teal

---

## Screen 8: Settings Screen
- **Header:** "Settings" (SF Semi-Bold, 32pt; margin-top: 90px)
- **Settings List:** Data Permissions, AI Integration, Notifications (translucent cards, 85% opacity, blur 25%, rounded corners 16pt)
- **Persistent Disclaimer:** Bottom footer (SF Regular, 18pt)

---

## Screen 9: watchOS Daily Summary (Glance Screen)
- **Compact Metrics:** Steps, HR, Calories (SF Regular, 16pt, icons 18px)
- **AI Chat Prompt:** Bottom "Ask AI" with microphone icon

---

## Screen 10: watchOS Quick AI Chat Interaction
- **Voice Dictation Screen:** Microphone icon (40px), "Listening..." (SF Regular, 16pt)
- **Chat Response Display:** Short AI response in text bubbles

---

## Technical Notes:
- **Dynamic Island integration** explicitly included for AI chat.
- **VisionOS-inspired aesthetics**: Translucent backgrounds, blur effects, teal accent for interactions.
- Data storage and security via CoreData, Keychain.
- Minimal disclaimers clearly integrated.

---


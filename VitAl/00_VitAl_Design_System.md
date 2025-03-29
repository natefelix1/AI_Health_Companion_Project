// VitAl Design System: Shared Components, UX Philosophy & iPhone-Specific Modules

// TABLE OF CONTENTS:
// 1. Shared Philosophy
// 2. Foundation Tokens & Standards
// 3. Core Components (Shared)
// 4. Interactions & UX Patterns
// 5. Data Visualization Baseline
// 6. iPhone-Specific Components
// 7. Apple Watch Components
// 8. Shared Prototype Flows
// 9. SwiftUI Code Snippets
// 10. AI Chat Design System
// 11. Brand Identity & Theming
// 12. State Management & Edge Cases
// 13. Accessibility Enhancements
// 14. Watch Complication Designs
// 15. Notifications & Alerts
// 16. Advanced Animations & Micro-Interactions
// 17. Privacy & Data Use Modalities
// 18. User Settings & Profile Management
// 19. Additional Light/Dark Mode Snippet


// SECTION 1: SHARED PHILOSOPHY
// -----------------------------
// Rooted in VisionOS and anticipating iOS 19, the VitAl design system emphasizes:
// - Translucency and layering (glassy UI)
// - Depth through spatial hierarchy (ZStack, shadows, gradients)
// - Adaptive interfaces (contextual, environment-aware, anticipatory AI)
// - Seamless cross-device interactions (iPhone ↔ Apple Watch)
// - High accessibility and legibility (VoiceOver, Dynamic Type, contrast ratios)


// SECTION 2: FOUNDATION TOKENS & STANDARDS
// ----------------------------------------
export const colors = {
  backgroundGlassLight: 'rgba(255, 255, 255, 0.2)',
  backgroundGlassDark: 'rgba(18, 18, 18, 0.2)',
  primary: '#5AC8FA', // align with health and vitality
  secondary: '#FF9500',
  success: '#34C759',
  warning: '#FFCC00',
  error: '#FF3B30',
  textPrimaryLight: '#FFFFFF',
  textPrimaryDark: '#000000',
};

export const typography = {
  fontFamily: 'SF Pro Display',
  headingWeight: 700,
  bodyWeight: 400,
  headingSize: '24px',
  bodySize: '17px',
  captionSize: '13px',
};

export const spacing = {
  xs: '4px',
  sm: '8px',
  md: '16px',
  lg: '24px',
  xl: '32px',
};


// SECTION 3: CORE COMPONENTS (SHARED)
// -----------------------------------
export const cardStyle = {
  background: colors.backgroundGlassLight,
  backdropFilter: 'blur(20px)',
  borderRadius: '20px',
  boxShadow: '0 8px 24px rgba(0,0,0,0.15)',
  padding: spacing.md,
  color: colors.textPrimaryLight,
};

export const buttonPrimary = {
  backgroundColor: colors.primary,
  borderRadius: '100px',
  padding: `${spacing.sm} ${spacing.lg}`,
  fontWeight: typography.headingWeight,
  color: colors.textPrimaryLight,
};

export const dynamicIslandAI = {
  container: {
    background: colors.backgroundGlassDark,
    borderRadius: '28px',
    padding: spacing.sm,
    fontSize: typography.bodySize,
    animation: 'fadeInUp 0.3s ease-in-out',
  },
  states: ['idle', 'listening', 'processing', 'responding'],
  transitions: {
    idleToListening: 'scale(1.05)',
    listeningToProcessing: 'pulse',
    processingToResponding: 'fadeSwap',
  },
};


// SECTION 4: INTERACTIONS & UX PATTERNS
// --------------------------------------
export const interactions = {
  gestures: ['tap', 'longPress', 'swipeUp', 'dragToReorder'],
  feedback: {
    haptics: true,
    animations: true,
  },
  accessibility: {
    dynamicType: true,
    voiceOverLabels: true,
    highContrastSupport: true,
  },
};


// SECTION 5: DATA VISUALIZATION BASELINE
// --------------------------------------
export const chartDefaults = {
  lineWidth: 3,
  dotRadius: 4,
  useGradient: true,
  animateOnUpdate: true,
  tooltipStyle: {
    background: colors.backgroundGlassDark,
    padding: spacing.sm,
    borderRadius: spacing.sm,
    fontSize: typography.captionSize,
  },
};


// SECTION 6: IPHONE-SPECIFIC COMPONENTS
// --------------------------------------
export const iPhoneComponents = {
  dashboardGrid: {
    columns: 2,
    spacing: spacing.md,
    aspectRatio: '1.5',
    alignment: 'topLeading',
  },
  aiInteractionPanel: {
    height: '80px',
    position: 'sticky',
    offsetFromTop: spacing.md,
    style: {
      background: colors.backgroundGlassDark,
      borderRadius: '24px',
      padding: spacing.sm,
      fontSize: typography.bodySize,
      boxShadow: '0 6px 18px rgba(0,0,0,0.25)',
    },
  },
  healthMetricCard: {
    size: 'fullWidth',
    minHeight: '140px',
    rounded: true,
    style: {
      background: colors.backgroundGlassLight,
      padding: spacing.md,
      borderRadius: '16px',
      color: colors.textPrimaryLight,
      backdropFilter: 'blur(10px)',
    },
  },
  notificationPill: {
    background: colors.primary,
    borderRadius: '100px',
    paddingHorizontal: spacing.md,
    paddingVertical: spacing.sm,
    textColor: colors.textPrimaryLight,
    elevation: 'light',
  },
  modalOverlay: {
    background: 'rgba(0,0,0,0.4)',
    blurEffect: true,
    zIndex: 1000,
    transition: 'fadeIn 0.25s ease-in',
  },
};


// SECTION 7: APPLE WATCH COMPONENTS
// ----------------------------------
export const watchComponents = {
  glanceTile: {
    size: 'compact',
    background: colors.backgroundGlassDark,
    borderRadius: '16px',
    fontSize: typography.captionSize,
    padding: spacing.sm,
    hapticFeedback: true,
  },
  quickMetricBadge: {
    shape: 'circular',
    border: `2px solid ${colors.primary}`,
    textColor: colors.textPrimaryLight,
    fontSize: typography.captionSize,
    background: colors.backgroundGlassLight,
  },
  notificationCard: {
    background: colors.primary,
    borderRadius: '12px',
    padding: spacing.sm,
    fontSize: typography.bodySize,
    textColor: colors.textPrimaryLight,
    alignment: 'center',
  },
  tapActionTile: {
    size: 'full',
    padding: spacing.md,
    borderRadius: '20px',
    style: {
      background: colors.secondary,
      color: colors.textPrimaryLight,
      fontWeight: typography.headingWeight,
    },
    haptics: true,
  },
};


// SECTION 8: SHARED PROTOTYPE FLOWS
// ----------------------------------
export const flows = {
  onboarding: {
    steps: [
      'Welcome screen with VitAl purpose and value proposition',
      'Permission prompts for HealthKit, notifications, motion tracking, location',
      'User baseline setup: age, goals, areas of interest',
      'Intro to AI assistant and sample health insights',
      'Dashboard customization (drag/drop cards)',
    ],
    style: {
      background: colors.backgroundGlassLight,
      overlay: colors.backgroundGlassDark,
      font: typography.bodySize,
      button: buttonPrimary,
    },
  },

  healthInsightCycle: {
    trigger: ['daily notification', 'AI prompt in Dynamic Island'],
    flow: [
      'User taps AI prompt → context window expands',
      'Real-time insight displayed (e.g., “your HRV dropped after poor sleep”)',
      'Option to explore dashboard or ask AI follow-up',
      'Quick action suggestions (e.g., start meditation)',
    ],
  },

  interactiveVisualization: {
    flow: [
      'User taps a metric card on dashboard',
      'Expanded chart with overlay appears using ZStack + blur',
      'AI highlights correlation (e.g., low sleep = higher resting HR)',
      'Swipe down to minimize / double tap for deep dive',
    ],
    animation: 'fluidExpandCollapse',
    chartOptions: chartDefaults,
  },

  watchSyncInteraction: {
    flow: [
      'Apple Watch detects elevated stress',
      'Pushes micro alert to iPhone AI assistant',
      'AI recommends check-in + breathing exercise',
      'Follow-up log appears on iPhone dashboard',
    ],
    continuity: true,
  },
};


// SECTION 9: SWIFTUI CODE SNIPPETS
// ----------------------------------
/* Example 1: Translucent Glass Card */
import SwiftUI

struct GlassCard: View {
  var body: some View {
    VStack(alignment: .leading) {
      Text("Heart Rate")
        .font(.headline)
        .foregroundColor(.white)
      Text("78 BPM")
        .font(.title)
        .bold()
        .foregroundColor(.white)
    }
    .padding()
    .background(.ultraThinMaterial)
    .cornerRadius(20)
    .shadow(radius: 10)
  }
}

/* Example 2: Dynamic Island AI Prompt */
struct AIPromptIsland: View {
  @State private var aiText = "Analyzing data..."
  var body: some View {
    HStack {
      Image(systemName: "waveform")
        .foregroundColor(.white)
      Text(aiText)
        .foregroundColor(.white)
        .font(.body)
    }
    .padding()
    .background(.ultraThinMaterial)
    .cornerRadius(28)
    .frame(height: 60)
    .shadow(radius: 5)
    .transition(.move(edge: .top))
  }
}

/* Example 3: Metric Card with Chart */
import Charts

struct MetricChartCard: View {
  var data: [Double]

  var body: some View {
    VStack(alignment: .leading) {
      Text("Sleep Trend")
        .font(.headline)
        .foregroundColor(.white)
      Chart(data, id: \".self\") { value in
        LineMark(
          x: .value("Day", value),
          y: .value("Sleep", value)
        )
      }
      .frame(height: 100)
    }
    .padding()
    .background(.ultraThinMaterial)
    .cornerRadius(16)
  }
}

// SECTION 10: AI CHAT DESIGN SYSTEM
// ----------------------------------
export const aiChatDesign = {
  chatThreadContainer: {
    background: colors.backgroundGlassDark,
    cornerRadius: '24px',
    padding: spacing.md,
    spacingVertical: spacing.sm,
  },
  userBubble: {
    background: colors.primary,
    borderRadius: '20px',
    textColor: colors.textPrimaryLight,
    fontSize: typography.bodySize,
    maxWidth: '70%',
    padding: spacing.sm,
    alignment: 'trailing',
  },
  aiBubble: {
    background: colors.backgroundGlassLight,
    borderRadius: '20px',
    textColor: colors.textPrimaryLight,
    fontSize: typography.bodySize,
    maxWidth: '70%',
    padding: spacing.sm,
    alignment: 'leading',
    blurEffect: true,
  },
  inputField: {
    background: colors.backgroundGlassLight,
    cornerRadius: '16px',
    fontSize: typography.bodySize,
    textColor: colors.textPrimaryLight,
    paddingHorizontal: spacing.sm,
    paddingVertical: spacing.xs,
    placeholderColor: 'rgba(255,255,255,0.6)',
  },
  dynamicIslandIntegration: {
    // Option for tapping the island to open chat thread
    tapToOpen: true,
    // Or the user can see a preview bubble in the island
    previewBubble: {
      background: colors.backgroundGlassDark,
      borderRadius: '16px',
      fontSize: typography.captionSize,
      color: colors.textPrimaryLight,
      padding: spacing.xs,
    }
  },
};


// SECTION 11: BRAND IDENTITY & THEMING
// -------------------------------------
// This section defines the brand presence and aesthetic coherence.

export const branding = {
  // Basic brand info
  appName: "VitAl",
  logoUsage: {
    // guidelines for app icon usage, splash screens, marketing banners, etc.
    safeArea: 16, // in pixels or points around the logo
    recommendedSizes: [
      { device: 'iPhone App Icon', dimension: '1024x1024 px' },
      { device: 'Apple Watch App Icon', dimension: '196x196 px' },
    ],
    backgroundRules: {
      lightMode: colors.backgroundGlassLight,
      darkMode: colors.backgroundGlassDark,
    },
  },
  appIconStyle: {
    shape: 'roundedSquare',
    cornerRadius: 24,
    gradient: {
      start: colors.primary,
      end: colors.secondary,
    },
  },
  marketingCollateral: {
    splashScreen: {
      backgroundColor: colors.primary,
      logoPosition: 'center',
      fadeInAnimation: true,
    },
    storeListing: {
      tagline: "Your personal AI-driven health companion.",
      highlightColor: colors.success,
    },
  },
};


// SECTION 12: STATE MANAGEMENT & EDGE CASES
// ------------------------------------------
export const stateManagement = {
  errorStates: {
    noData: {
      title: "No Data Available",
      message: "It looks like we can’t find your recent health metrics.",
      ctaLabel: "Refresh",
      style: {
        icon: 'exclamationmark.triangle',
        color: colors.error,
        background: colors.backgroundGlassDark,
      },
    },
    serverIssue: {
      title: "Server Unreachable",
      message: "We’re having trouble connecting to VitAl’s servers.",
      ctaLabel: "Try Again",
      style: {
        icon: 'wifi.exclamationmark',
        color: colors.warning,
        background: colors.backgroundGlassDark,
      },
    },
    invalidApiKey: {
      title: "Invalid AI Key",
      message: "Your AI provider key appears invalid or expired.",
      ctaLabel: "Update Key",
      style: {
        icon: 'key.fill',
        color: colors.warning,
        background: colors.backgroundGlassDark,
      },
    },
  },

  emptyStates: {
    noTrackedMetrics: {
      title: "No Tracked Metrics",
      message: "Add metrics to your dashboard to see insights.",
      style: {
        icon: 'plus.circle',
        color: colors.primary,
        background: colors.backgroundGlassLight,
      },
    },
    noAIHistory: {
      title: "No Chat History",
      message: "Ask something or let AI check your health data.",
      style: {
        icon: 'bubble.left.and.bubble.right',
        color: colors.primary,
        background: colors.backgroundGlassLight,
      },
    },
  },

  offlineMode: {
    bannerMessage: "Limited Connectivity",
    detail: "Some features may be unavailable until you’re back online.",
    style: {
      background: colors.warning,
      textColor: colors.textPrimaryDark,
      icon: 'icloud.slash',
    },
  },

  fallbackHandlers: {
    // Functions or guidelines for how to gracefully degrade
    onRetry: () => { /* logic to attempt data refresh */ },
    onOfflineReconnect: () => { /* logic for re-establishing connectivity */ },
  },
};


// SECTION 13: ACCESSIBILITY ENHANCEMENTS
// ---------------------------------------
export const accessibilityEnhancements = {
  colorBlindPalettes: {
    // Provide fallback or alternative color sets
    protanopia: {
      primary: '#7CB9F2',
      secondary: '#F2A045',
      success: '#A3DD8E',
      warning: '#F2D700',
      error: '#F26B5E',
    },
    deuteranopia: {
      primary: '#73B5F0',
      secondary: '#F29B49',
      success: '#97DB84',
      warning: '#F2D137',
      error: '#F26452',
    },
  },

  voiceOverFlow: {
    // Guidance on how each screen or flow is read by VoiceOver
    onboarding: {
      labelOrder: ['Welcome Title', 'Welcome Body', 'CTA Buttons'],
      hints: "Tap to continue setup.",
    },
    healthInsightCycle: {
      labelOrder: ['Notification Title', 'Insight Summary', 'Suggested Actions'],
      hints: "Swipe right to see actions.",
    },
  },

  fontScalingExamples: {
    small: '85%', // below default
    medium: '100%', // default
    large: '115%',
    xLarge: '130%',
  },

  guidelines: {
    // Additional instructions for devs
    minimumTapSize: {
      width: 44,
      height: 44,
      explanation: "Apple HIG minimum touch target.",
    },
    focusAreas: {
      useFocusRing: true,
      color: '#FFFFFF',
    },
  },
};


// SECTION 14: WATCH COMPLICATION DESIGNS
// ---------------------------------------
export const watchComplications = {
  families: {
    modularSmall: {
      layout: 'square',
      guidelines: {
        recommendedIconSize: 20,
        maxTextLength: 5,
        backgroundColor: colors.backgroundGlassDark,
      },
    },
    modularLarge: {
      layout: 'rectangular',
      guidelines: {
        recommendedIconSize: 24,
        maxTextLines: 3,
        backgroundColor: colors.backgroundGlassDark,
      },
    },
    circularSmall: {
      layout: 'circular',
      guidelines: {
        diameter: 42,
        strokeColor: colors.primary,
        backgroundColor: colors.backgroundGlassLight,
      },
    },
    corner: {
      layout: 'cornerCurve',
      guidelines: {
        recommendedIconSize: 18,
        accentColor: colors.success,
        backgroundColor: colors.backgroundGlassDark,
      },
    },
    graphicRectangular: {
      layout: 'rectangularFull',
      guidelines: {
        recommendedIconSize: 32,
        backgroundColor: colors.backgroundGlassDark,
        highlightColor: colors.secondary,
      },
    },
  },
  designRules: {
    // Shared watch complication styling hints
    useTranslucency: true,
    alignment: 'center',
    cornerRadius: 8,
    textStyle: typography.captionSize,
    textColorLight: colors.textPrimaryLight,
    textColorDark: colors.textPrimaryDark,
  },
  dataExamples: {
    stepsCount: {
      placeholder: "10k",
      label: "Steps",
    },
    heartRate: {
      placeholder: "78",
      label: "BPM",
    },
  },
  notes: "Ensure complications adhere to watchOS guidelines for safe margins and legibility. Prioritize glanceable data and minimal text."
};

// SECTION 15: NOTIFICATIONS & ALERTS
// -----------------------------------
export const notificationsDesign = {
  categories: {
    critical: {
      // e.g. dangerously low heart rate, or medication overdose risk
      backgroundColor: colors.error,
      icon: 'exclamationmark.octagon',
      textColor: colors.textPrimaryLight,
      vibrationPattern: 'critical',
      sound: 'alertCritical',
      descriptiveText: "Immediate attention required.",
    },
    routine: {
      // e.g. daily summary, normal medication reminder
      backgroundColor: colors.primary,
      icon: 'bell.badge',
      textColor: colors.textPrimaryLight,
      vibrationPattern: 'default',
      sound: 'alertRoutine',
      descriptiveText: "Routine notification.",
    },
    motivational: {
      // e.g. AI-based encouraging or healthy habit suggestions
      backgroundColor: colors.success,
      icon: 'hand.thumbsup',
      textColor: colors.textPrimaryLight,
      vibrationPattern: 'light',
      sound: 'alertPositive',
      descriptiveText: "Stay motivated!",
    },
  },
  deviceIntegration: {
    // For iPhone & Watch synergy
    mirrorOnWatch: true,
    watchHaptics: {
      critical: 'notificationCritical',
      routine: 'notificationDefault',
      motivational: 'notificationSuccess',
    },
    dynamicIslandActions: {
      // For AI-based notifications or expansions
      showInsight: true,
      quickReply: true,
    },
  },
  actionHandling: {
    // Ties into Siri and watch actions
    supportsSiriIntents: true,
    sampleIntents: [
      {
        name: 'MarkMedicationTaken',
        phrases: ["Mark my meds as taken", "I took my medication"],
      },
      {
        name: 'OpenAIChat',
        phrases: ["Ask VitAl assistant about my heart rate"],
      },
    ],
  },
  inAppAlerts: {
    // Banner or modal style for in-app alerts
    banner: {
      background: colors.backgroundGlassDark,
      textColor: colors.textPrimaryLight,
      animation: 'slideDown',
      duration: 4, // in seconds
    },
    modal: {
      background: colors.backgroundGlassLight,
      cornerRadius: 20,
      textColor: colors.textPrimaryLight,
      overlayDismiss: false,
    },
  },
  textRecommendations: {
    // single language (English)
    maxTitleLength: 50,
    maxBodyLength: 120,
    toneOfVoice: 'supportive',
  },
  notes: "Differentiate critical vs. routine with color & haptics. Provide quick actions via AI. Mirror notifications on Watch for consistent user experience."
};

// SECTION 16: ADVANCED ANIMATIONS & MICRO-INTERACTIONS
// ------------------------------------------------------
export const advancedAnimations = {
  guidelines: {
    purposeDriven: "All animations serve a functional purpose—enhance understanding, reduce cognitive load.",
    fluidDurations: "Use short, fluid transitions (0.2-0.4s) for ephemeral actions, up to 0.8s for major transitions.",
    reduceMotionSupport: "Honor iOS reduce-motion settings and provide less animated alternatives.",
  },
  microInteractionExamples: {
    cardHover: {
      trigger: "hover or slight finger hold",
      effect: "slight scale-up (1.02) + subtle shadow",
      duration: 0.2,
      haptic: false,
    },
    tabSwitch: {
      trigger: "tap on tab bar icon",
      effect: "icon bounce (spring) and fade between screens",
      duration: 0.3,
      haptic: true,
    },
    dataRefresh: {
      trigger: "pull-to-refresh or AI update",
      effect: "circular spin on icon, subtle confetti if new achievements",
      duration: 0.6,
      haptic: true,
    },
  },
  transitions: {
    pageTransition: {
      style: "slide or fade",
      recommendedDuration: 0.3,
      curve: "easeInOut",
    },
    overlayAppear: {
      style: "fade + scale",
      recommendedDuration: 0.25,
      curve: "easeOut",
    },
    dynamicIslandExpand: {
      style: "spring",
      recommendedDuration: 0.35,
      curve: "spring(damping: 0.7, stiffness: 100)",
    },
  },
  bestPractices: {
    minimalEasing: "Prefer iOS default spring or easeInOut for continuity with Apple ecosystem.",
    highlightUserAction: "Use short pulses or color flickers to confirm user input.",
    limitConcurrentAnimations: "Avoid running multiple complex animations simultaneously.",
    performanceCheck: "Profile animation performance on older devices to ensure fluidity.",
  },
  notes: "Keep animations subtle, purposeful, and brand-aligned. Focus on delight while respecting device performance and user accessibility preferences."
};


// SECTION 17: PRIVACY & DATA USE MODALITIES
// -------------------------------------------
export const privacyAndDataUse = {
  permissionFlows: {
    healthKit: {
      promptTitle: "Access Your Health Data?",
      promptMessage: "VitAl uses metrics like heart rate, steps, and sleep data to provide personalized insights.",
      ctaAllow: "Allow",
      ctaDeny: "Not Now",
      notes: "Comply with Apple guidelines for HealthKit. Provide rationale for data usage, and respect user’s choice.",
    },
    notifications: {
      promptTitle: "Stay Informed?",
      promptMessage: "Enable notifications for real-time AI insights and health alerts.",
      ctaAllow: "Allow",
      ctaDeny: "No Thanks",
      notes: "Clearly outline the benefits of enabling notifications.",
    },
    location: {
      promptTitle: "Access Your Location?",
      promptMessage: "VitAl correlates location-based factors (air quality, environment noise) with health metrics.",
      ctaAllow: "Allow",
      ctaDeny: "Maybe Later",
      notes: "Show location usage rationale. Provide privacy disclaimers re. storing or processing location.",
    },
  },
  dataSecurity: {
    encryption: "All user health data is encrypted at rest (AES-256) and in transit (TLS 1.2+).",
    localProcessing: "Perform AI-driven data analysis primarily on-device, with minimal server calls.",
    anonymizedUsage: "Aggregate usage metrics anonymized for product improvement.",
  },
  disclaimers: {
    medicalDisclaimer: "VitAl is not a substitute for professional medical advice. Always consult your healthcare provider.",
    userConsent: "Users must agree to Terms & Conditions, clarifying data usage scope.",
  },
  userControls: {
    revokeAccess: "Users can revoke HealthKit, notifications, or location permissions in iOS Settings.",
    dataExportDelete: "Offer in-app method to export or delete personal health data.",
    aiInsightsToggle: "Allow users to toggle AI-based recommendations on/off.",
  },
  hipaaConsiderations: {
    statement: "For US users, any data that could be considered PHI is handled per HIPAA guidelines.",
    recommendedSteps: "Maintain strict logging of data access, implement robust authentication.",
  },
  notes: "Be transparent with data usage and limitations. Provide granular controls. Respect platform privacy frameworks like Apple’s HealthKit & AppTrackingTransparency."
};


// SECTION 18: USER SETTINGS & PROFILE MANAGEMENT
// -----------------------------------------------
export const userSettingsProfile = {
  profileScreen: {
    layout: {
      sections: ["Profile Info", "AI Settings", "Permissions", "Data Management"],
      background: colors.backgroundGlassDark,
      textColor: colors.textPrimaryLight,
    },
    avatarStyle: {
      shape: 'circle',
      size: 80,
      borderWidth: 2,
      borderColor: colors.primary,
    },
    displayName: {
      fontSize: typography.headingSize,
      weight: typography.headingWeight,
    },
    editButtonStyle: {
      background: colors.primary,
      textColor: colors.textPrimaryLight,
      cornerRadius: '16px',
      padding: spacing.sm,
    },
  },

  aiIntegration: {
    apiKeyField: {
      label: "API Key",
      placeholder: "Enter your OpenAI / LLM provider key",
      secureEntry: true,
      style: {
        background: colors.backgroundGlassLight,
        textColor: colors.textPrimaryLight,
        cornerRadius: '12px',
        padding: spacing.sm,
      },
      notes: "Store securely in Keychain. Provide instructions for obtaining/updating from the AI provider.",
    },
    modelConfig: {
      // Additional advanced toggles for controlling the AI’s behavior
      temperature: {
        label: "Creative Level",
        min: 0,
        max: 1,
        default: 0.5,
      },
      systemPrompt: {
        label: "System Prompt",
        placeholder: "Customize AI tone/behavior",
        multiline: true,
      },
    },
    usageInfo: {
      text: "Usage fees are billed by your AI provider. VitAl does not charge for AI usage.",
      style: {
        fontSize: typography.captionSize,
        color: colors.warning,
      },
    },
    updateButton: {
      label: "Update AI Key",
      background: colors.success,
      textColor: colors.textPrimaryLight,
      cornerRadius: '16px',
      padding: spacing.sm,
    },
  },

  permissionsSection: {
    // Quick shortcuts to system settings or toggles
    healthAccessToggle: {
      label: "HealthKit Access",
      note: "Tap to manage Health permissions",
    },
    notificationsToggle: {
      label: "Notifications",
      note: "Tap to manage notification settings",
    },
    locationToggle: {
      label: "Location",
      note: "Tap to manage location permissions",
    },
  },

  dataManagement: {
    exportButton: {
      label: "Export Data",
      icon: 'square.and.arrow.up',
      style: {
        background: colors.primary,
        textColor: colors.textPrimaryLight,
        cornerRadius: '16px',
        padding: spacing.sm,
      },
    },
    deleteAccountButton: {
      label: "Delete All Data",
      icon: 'trash',
      style: {
        background: colors.error,
        textColor: colors.textPrimaryLight,
        cornerRadius: '16px',
        padding: spacing.sm,
      },
      confirmationFlow: {
        title: "Are you sure?",
        message: "This will delete all personal health data and AI settings.",
        confirmLabel: "Yes, Delete",
        cancelLabel: "Cancel",
      },
    },
  },

  notes: "Allow users to easily manage profile info, AI API keys, system permissions (including location), and personal data. Keep advanced AI settings in one place, with disclaimers about usage fees.",
};


// SECTION 19: ADDITIONAL LIGHT/DARK MODE SNIPPET
// -----------------------------------------------
/* Example snippet to demonstrate how background can adapt for light vs. dark mode
   using SwiftUI’s colorScheme or an Environment variable. */
import SwiftUI

struct AdaptiveBackgroundView: View {
  @Environment(\.colorScheme) var colorScheme

  var body: some View {
    ZStack {
      if colorScheme == .dark {
        Color.black
      } else {
        Color.white
      }
      // content here
      Text("Adaptive Light/Dark")
        .font(.title)
        .foregroundColor(colorScheme == .dark ? .white : .black)
    }
    .edgesIgnoringSafeArea(.all)
  }
}

// Completed recommended revisions:
// 1. Added Table of Contents.
// 2. Light/Dark usage snippet.
// 3. Invalid API key error scenario.
// 4. Added location permission.
// 5. Minor references to location toggles in flows, permissions.


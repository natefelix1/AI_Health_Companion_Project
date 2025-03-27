import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userPreferences: UserPreferences
    @EnvironmentObject var healthKitManager: HealthKitManager
    
    @State private var apiKey: String = ""
    @State private var useLocationServices: Bool = UserDefaults.standard.bool(forKey: "useLocationServices")
    @State private var useWeatherData: Bool = UserDefaults.standard.bool(forKey: "useWeatherData")
    @State private var useScreenTimeData: Bool = UserDefaults.standard.bool(forKey: "useScreenTimeData")
    @State private var notificationsEnabled: Bool = true
    @State private var notificationFrequency: Int = 2
    @State private var showResetConfirmation: Bool = false
    
    let notificationOptions = ["None", "1 per day", "2 per day", "3 per day"]
    
    var body: some View {
        NavigationView {
            Form {
                // User Profile Section
                Section(header: Text("Profile")) {
                    HStack {
                        Text("Name")
                        Spacer()
                        Text(userPreferences.name)
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("Age")
                        Spacer()
                        Text("\(userPreferences.age)")
                            .foregroundColor(.gray)
                    }
                    
                    NavigationLink(destination: HealthGoalsView()) {
                        HStack {
                            Text("Health Goals")
                            Spacer()
                            Text("\(userPreferences.healthGoals.count) selected")
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                // API Key Section
                Section(header: Text("AI Integration")) {
                    SecureField("OpenAI API Key", text: $apiKey)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onAppear {
                            // In a real app, retrieve from Keychain
                            apiKey = userPreferences.apiKey
                        }
                    
                    Button("Save API Key") {
                        userPreferences.saveAPIKey(key: apiKey)
                    }
                    .disabled(apiKey.isEmpty || apiKey == userPreferences.apiKey)
                    
                    Link("Get an API Key", destination: URL(string: "https://platform.openai.com/api-keys")!)
                }
                
                // Data Permissions Section
                Section(header: Text("Data Permissions")) {
                    Toggle("HealthKit Access", isOn: .constant(healthKitManager.isAuthorized))
                        .disabled(true) // This is managed by HealthKit
                    
                    Button("Manage Health Permissions") {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                    }
                    
                    Toggle("Location Services", isOn: $useLocationServices)
                        .onChange(of: useLocationServices) { newValue in
                            UserDefaults.standard.set(newValue, forKey: "useLocationServices")
                        }
                    
                    Toggle("Weather & Air Quality", isOn: $useWeatherData)
                        .onChange(of: useWeatherData) { newValue in
                            UserDefaults.standard.set(newValue, forKey: "useWeatherData")
                        }
                    
                    Toggle("Screen Time Data", isOn: $useScreenTimeData)
                        .onChange(of: useScreenTimeData) { newValue in
                            UserDefaults.standard.set(newValue, forKey: "useScreenTimeData")
                        }
                }
                
                // Notifications Section
                Section(header: Text("Notifications")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    
                    if notificationsEnabled {
                        Picker("Daily Insights", selection: $notificationFrequency) {
                            ForEach(0..<notificationOptions.count, id: \.self) { index in
                                Text(notificationOptions[index])
                            }
                        }
                    }
                }
                
                // About & Legal Section
                Section(header: Text("About & Legal")) {
                    NavigationLink(destination: DisclaimerView()) {
                        Text("Disclaimers & Privacy Policy")
                    }
                    
                    HStack {
                        Text("App Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.gray)
                    }
                }
                
                // Reset Section
                Section {
                    Button("Reset All Settings") {
                        showResetConfirmation = true
                    }
                    .foregroundColor(.red)
                }
                
                // Persistent Disclaimer
                Section {
                    Text("This app is not a medical device and should not be used for diagnosis or treatment of medical conditions.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Settings")
            .alert(isPresented: $showResetConfirmation) {
                Alert(
                    title: Text("Reset All Settings?"),
                    message: Text("This will reset all your preferences and remove your API key. Your health data will not be affected."),
                    primaryButton: .destructive(Text("Reset")) {
                        resetAllSettings()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
    
    // Reset all settings
    func resetAllSettings() {
        // Clear UserDefaults
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        
        // Reset state variables
        apiKey = ""
        useLocationServices = false
        useWeatherData = false
        useScreenTimeData = false
        notificationsEnabled = true
        notificationFrequency = 2
        
        // In a real app, we would also clear the Keychain
        
        // Reset user preferences
        userPreferences.saveUserInfo(name: "", age: 0, healthGoals: [])
        userPreferences.saveAPIKey(key: "")
    }
}

// Health Goals View
struct HealthGoalsView: View {
    @EnvironmentObject var userPreferences: UserPreferences
    @State private var selectedGoals: Set<String> = []
    
    let availableGoals = [
        "Weight Management",
        "Improved Sleep",
        "Stress Reduction",
        "Fitness",
        "Heart Health",
        "Mental Wellbeing",
        "Nutrition",
        "Hydration",
        "Posture",
        "Screen Time Balance"
    ]
    
    var body: some View {
        List {
            ForEach(availableGoals, id: \.self) { goal in
                Button(action: {
                    if selectedGoals.contains(goal) {
                        selectedGoals.remove(goal)
                    } else {
                        selectedGoals.insert(goal)
                    }
                }) {
                    HStack {
                        Text(goal)
                        Spacer()
                        if selectedGoals.contains(goal) {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color("AccentColor"))
                        }
                    }
                }
                .foregroundColor(.primary)
            }
        }
        .navigationTitle("Health Goals")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    userPreferences.saveUserInfo(
                        name: userPreferences.name,
                        age: userPreferences.age,
                        healthGoals: Array(selectedGoals)
                    )
                }
            }
        }
        .onAppear {
            selectedGoals = Set(userPreferences.healthGoals)
        }
    }
}

// Disclaimer View
struct DisclaimerView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Disclaimers & Privacy Policy")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                Group {
                    Text("Not a Medical Device")
                        .font(.headline)
                    
                    Text("AI Health Companion is not a medical device and is not intended to diagnose, treat, cure, or prevent any disease or health condition. The app should not be used as a substitute for professional medical advice, diagnosis, or treatment.")
                        .font(.body)
                }
                
                Group {
                    Text("Health Data Privacy")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    Text("Your health data remains on your device and is processed locally. When using AI features, data is sent to OpenAI using your personal API key. We do not store or have access to your health information.")
                        .font(.body)
                }
                
                Group {
                    Text("AI Limitations")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    Text("The AI companion provides general insights based on patterns in your health data. These insights are not personalized medical advice and may not account for your specific health conditions or circumstances.")
                        .font(.body)
                }
                
                Group {
                    Text("Data Collection")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    Text("We collect anonymous usage data to improve the app experience. This does not include your personal health information. You can opt out of analytics in your device settings.")
                        .font(.body)
                }
                
                Group {
                    Text("Third-Party Services")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    Text("When you use your OpenAI API key, you are subject to OpenAI's terms of service and privacy policy. Please review their policies for information on how they handle your data.")
                        .font(.body)
                }
                
                Text("Last Updated: March 26, 2025")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 20)
            }
            .padding()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(UserPreferences())
            .environmentObject(HealthKitManager())
    }
}

import SwiftUI
import HealthKit

struct OnboardingView: View {
    @EnvironmentObject var userPreferences: UserPreferences
    @EnvironmentObject var healthKitManager: HealthKitManager
    
    @State private var currentPage = 0
    @State private var userName = ""
    @State private var userAge = ""
    @State private var selectedHealthGoals: Set<String> = []
    @State private var routinePreference = "Morning"
    @State private var useLocationServices = false
    @State private var useWeatherData = false
    @State private var useScreenTimeData = false
    @State private var apiKey = ""
    @State private var acceptedTerms = false
    
    // Available health goals
    let healthGoals = ["Weight Management", "Improved Sleep", "Stress Reduction", "Fitness", "Heart Health", "Mental Wellbeing"]
    let routineOptions = ["Morning", "Afternoon", "Evening", "Variable"]
    
    var body: some View {
        VStack {
            // Progress indicator
            HStack {
                ForEach(0..<5) { index in
                    Circle()
                        .fill(currentPage >= index ? Color("AccentColor") : Color.gray.opacity(0.3))
                        .frame(width: 10, height: 10)
                }
            }
            .padding(.top, 20)
            
            // Page content
            ZStack {
                // Page 1: User Information
                if currentPage == 0 {
                    userInfoView
                }
                // Page 2: HealthKit Authorization
                else if currentPage == 1 {
                    healthKitAuthView
                }
                // Page 3: External Data Integration
                else if currentPage == 2 {
                    externalDataView
                }
                // Page 4: OpenAI API Key
                else if currentPage == 3 {
                    apiKeyView
                }
                // Page 5: Consent & Disclaimer
                else if currentPage == 4 {
                    consentView
                }
            }
            
            Spacer()
            
            // Navigation buttons
            HStack {
                if currentPage > 0 {
                    Button("Back") {
                        withAnimation {
                            currentPage -= 1
                        }
                    }
                    .padding()
                    .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button(currentPage == 4 ? "Get Started" : "Next") {
                    if currentPage == 4 {
                        // Save all user preferences and complete onboarding
                        completeOnboarding()
                    } else {
                        withAnimation {
                            currentPage += 1
                        }
                    }
                }
                .padding()
                .padding(.horizontal, 20)
                .background(Color("AccentColor"))
                .foregroundColor(.white)
                .clipShape(Capsule())
                .disabled(currentPage == 0 && (userName.isEmpty || userAge.isEmpty))
                .disabled(currentPage == 4 && !acceptedTerms)
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
        .padding()
    }
    
    // Page 1: User Information View
    var userInfoView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Welcome to AI Health Companion")
                .font(.system(size: 36, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.top, 50)
            
            Text("Let's personalize your health journey.")
                .font(.system(size: 22))
                .padding(.bottom, 30)
            
            TextField("Full Name", text: $userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("Age", text: $userAge)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding(.horizontal)
            
            Text("Health Goals (Select all that apply)")
                .font(.headline)
                .padding(.top)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(healthGoals, id: \.self) { goal in
                    Button(action: {
                        if selectedHealthGoals.contains(goal) {
                            selectedHealthGoals.remove(goal)
                        } else {
                            selectedHealthGoals.insert(goal)
                        }
                    }) {
                        Text(goal)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedHealthGoals.contains(goal) ? Color("AccentColor") : Color.gray.opacity(0.2))
                            .foregroundColor(selectedHealthGoals.contains(goal) ? .white : .primary)
                            .cornerRadius(10)
                    }
                }
            }
            
            Text("Routine Preference")
                .font(.headline)
                .padding(.top)
            
            Picker("Routine", selection: $routinePreference) {
                ForEach(routineOptions, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
        }
        .padding()
    }
    
    // Page 2: HealthKit Authorization View
    var healthKitAuthView: some View {
        VStack(spacing: 20) {
            Text("Connect Apple Health")
                .font(.system(size: 36, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.top, 50)
            
            Image(systemName: "heart.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .foregroundColor(Color("AccentColor"))
                .padding()
            
            Text("We'll need access to your health data to provide personalized insights.")
                .font(.system(size: 22))
                .multilineTextAlignment(.center)
                .padding()
            
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Image(systemName: "figure.walk")
                    Text("Activity & Steps")
                }
                
                HStack {
                    Image(systemName: "heart.circle")
                    Text("Heart Rate")
                }
                
                HStack {
                    Image(systemName: "bed.double")
                    Text("Sleep Data")
                }
                
                HStack {
                    Image(systemName: "flame")
                    Text("Calories & Workouts")
                }
            }
            .font(.system(size: 22))
            .padding()
            
            Button("Authorize HealthKit") {
                healthKitManager.requestAuthorization()
            }
            .padding()
            .padding(.horizontal, 40)
            .background(Color("AccentColor"))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding(.top, 20)
        }
        .padding()
    }
    
    // Page 3: External Data Integration View
    var externalDataView: some View {
        VStack(spacing: 20) {
            Text("Enhance Your Experience")
                .font(.system(size: 36, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.top, 50)
            
            Text("Optional integrations to provide more context for your health data.")
                .font(.system(size: 22))
                .multilineTextAlignment(.center)
                .padding()
            
            Toggle("Location Services", isOn: $useLocationServices)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
            
            Text("Provides context based on where you are throughout the day")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            Toggle("Weather & Air Quality", isOn: $useWeatherData)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
            
            Text("Correlates weather and air quality with your health metrics")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            Toggle("Screen Time Data", isOn: $useScreenTimeData)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
            
            Text("Analyzes how screen time affects your sleep and activity")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal)
        }
        .padding()
    }
    
    // Page 4: OpenAI API Key View
    var apiKeyView: some View {
        VStack(spacing: 20) {
            Text("Activate AI Companion")
                .font(.system(size: 36, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.top, 50)
            
            Text("Enter your OpenAI API key to enable the AI companion features.")
                .font(.system(size: 22))
                .multilineTextAlignment(.center)
                .padding()
            
            SecureField("OpenAI API Key", text: $apiKey)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button("Paste from Clipboard") {
                if let clipboardString = UIPasteboard.general.string {
                    apiKey = clipboardString
                }
            }
            .foregroundColor(Color("AccentColor"))
            .padding(.top, 5)
            
            Text("Your API key is stored securely on your device and is never shared.")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal)
                .padding(.top, 20)
            
            Text("Don't have an API key?")
                .font(.headline)
                .padding(.top, 30)
            
            Link("Get one from OpenAI", destination: URL(string: "https://platform.openai.com/api-keys")!)
                .foregroundColor(Color("AccentColor"))
        }
        .padding()
    }
    
    // Page 5: Consent & Disclaimer View
    var consentView: some View {
        VStack(spacing: 20) {
            Text("Your Privacy & Data")
                .font(.system(size: 36, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.top, 50)
            
            Text("Your data stays securely on-device.")
                .font(.system(size: 22))
                .multilineTextAlignment(.center)
                .padding()
            
            VStack(alignment: .leading, spacing: 15) {
                Text("• Health data is processed locally on your device")
                Text("• AI processing uses your personal API key")
                Text("• You can delete your data at any time")
                Text("• We do not store or share your personal information")
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            
            Toggle("I understand and accept the terms", isOn: $acceptedTerms)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.top, 20)
            
            Text("This app is not a medical device and should not be used for diagnosis or treatment of medical conditions.")
                .font(.caption)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top, 20)
        }
        .padding()
    }
    
    // Function to complete onboarding and save user preferences
    func completeOnboarding() {
        // Convert age string to integer
        let ageInt = Int(userAge) ?? 0
        
        // Save user information
        userPreferences.saveUserInfo(
            name: userName,
            age: ageInt,
            healthGoals: Array(selectedHealthGoals)
        )
        
        // Save API key
        userPreferences.saveAPIKey(key: apiKey)
        
        // Save other preferences to UserDefaults
        UserDefaults.standard.set(routinePreference, forKey: "routinePreference")
        UserDefaults.standard.set(useLocationServices, forKey: "useLocationServices")
        UserDefaults.standard.set(useWeatherData, forKey: "useWeatherData")
        UserDefaults.standard.set(useScreenTimeData, forKey: "useScreenTimeData")
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(UserPreferences())
            .environmentObject(HealthKitManager())
    }
}

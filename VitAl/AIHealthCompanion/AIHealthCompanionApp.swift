import SwiftUI
import HealthKit

@main
struct AIHealthCompanionApp: App {
    @StateObject private var healthKitManager = HealthKitManager()
    @StateObject private var userPreferences = UserPreferences()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(healthKitManager)
                .environmentObject(userPreferences)
                .onAppear {
                    healthKitManager.requestAuthorization()
                }
        }
    }
}

// Health Kit Manager to handle all health-related data access
class HealthKitManager: ObservableObject {
    let healthStore = HKHealthStore()
    @Published var isAuthorized = false
    
    // Types of health data we want to read
    let typesToRead: Set<HKObjectType> = [
        HKObjectType.quantityType(forIdentifier: .stepCount)!,
        HKObjectType.quantityType(forIdentifier: .heartRate)!,
        HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!,
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
    ]
    
    func requestAuthorization() {
        // Request authorization to access HealthKit data
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { success, error in
            DispatchQueue.main.async {
                self.isAuthorized = success
                if let error = error {
                    print("HealthKit authorization error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // Additional methods for fetching specific health data will be added here
}

// User preferences for app customization
class UserPreferences: ObservableObject {
    @Published var name: String = UserDefaults.standard.string(forKey: "userName") ?? ""
    @Published var age: Int = UserDefaults.standard.integer(forKey: "userAge")
    @Published var healthGoals: [String] = UserDefaults.standard.stringArray(forKey: "healthGoals") ?? []
    @Published var apiKey: String = ""
    
    // Save user preferences
    func saveUserInfo(name: String, age: Int, healthGoals: [String]) {
        self.name = name
        self.age = age
        self.healthGoals = healthGoals
        
        UserDefaults.standard.set(name, forKey: "userName")
        UserDefaults.standard.set(age, forKey: "userAge")
        UserDefaults.standard.set(healthGoals, forKey: "healthGoals")
    }
    
    // Save API key securely (in a real app, use Keychain)
    func saveAPIKey(key: String) {
        self.apiKey = key
        // In a real implementation, save to Keychain instead of UserDefaults
        UserDefaults.standard.set(key, forKey: "openAIKey")
    }
}

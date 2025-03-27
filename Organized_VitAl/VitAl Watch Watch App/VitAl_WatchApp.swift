import SwiftUI
import HealthKit

@main
struct VitAl_WatchApp: App {
    @StateObject private var healthKitManager = WatchHealthKitManager()
    
    var body: some Scene {
        WindowGroup {
            WatchContentView()
                .environmentObject(healthKitManager)
        }
    }
}

// Health Kit Manager for watchOS
class WatchHealthKitManager: ObservableObject {
    let healthStore = HKHealthStore()
    @Published var isAuthorized = false
    @Published var steps: Int = 0
    @Published var heartRate: Double = 0
    @Published var activeCalories: Double = 0
    
    // Types of health data we want to read
    let typesToRead: Set<HKObjectType> = [
        HKObjectType.quantityType(forIdentifier: .stepCount)!,
        HKObjectType.quantityType(forIdentifier: .heartRate)!,
        HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!,
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
    ]
    
    init() {
        requestAuthorization()
    }
    
    func requestAuthorization() {
        // Request authorization to access HealthKit data
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { success, error in
            DispatchQueue.main.async {
                self.isAuthorized = success
                if success {
                    self.fetchTodaysData()
                } else if let error = error {
                    print("HealthKit authorization error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // Fetch today's health data
    func fetchTodaysData() {
        fetchSteps()
        fetchHeartRate()
        fetchActiveCalories()
    }
    
    // Fetch step count
    private func fetchSteps() {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(
            quantityType: stepType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                if let error = error {
                    print("Error fetching steps: \(error.localizedDescription)")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.steps = Int(sum.doubleValue(for: HKUnit.count()))
            }
        }
        
        healthStore.execute(query)
    }
    
    // Fetch heart rate
    private func fetchHeartRate() {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else { return }
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(
            quantityType: heartRateType,
            quantitySamplePredicate: predicate,
            options: .discreteAverage
        ) { _, result, error in
            guard let result = result, let average = result.averageQuantity() else {
                if let error = error {
                    print("Error fetching heart rate: \(error.localizedDescription)")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.heartRate = average.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
            }
        }
        
        healthStore.execute(query)
    }
    
    // Fetch active calories
    private func fetchActiveCalories() {
        guard let caloriesType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else { return }
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(
            quantityType: caloriesType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                if let error = error {
                    print("Error fetching calories: \(error.localizedDescription)")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.activeCalories = sum.doubleValue(for: HKUnit.kilocalorie())
            }
        }
        
        healthStore.execute(query)
    }
}

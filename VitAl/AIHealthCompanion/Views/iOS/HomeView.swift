import SwiftUI
import HealthKit

struct HomeView: View {
    @EnvironmentObject var healthKitManager: HealthKitManager
    @EnvironmentObject var userPreferences: UserPreferences
    
    @State private var todaysSteps: Int = 0
    @State private var heartRate: Double = 0
    @State private var sleepHours: Double = 0
    @State private var activeCalories: Double = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Welcome header
                    welcomeHeader
                    
                    // Daily summary card
                    dailySummaryCard
                    
                    // AI Insights
                    aiInsightsCard
                    
                    // Quick actions
                    quickActionsSection
                }
                .padding()
            }
            .navigationTitle("Home")
            .onAppear {
                // Fetch latest health data when view appears
                fetchHealthData()
            }
        }
    }
    
    // Welcome header with personalized greeting
    var welcomeHeader: some View {
        VStack(alignment: .leading) {
            Text("Hello, \(userPreferences.name)")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(formattedDate())
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.bottom, 10)
    }
    
    // Daily summary card with health metrics
    var dailySummaryCard: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Today's Summary")
                .font(.headline)
                .padding(.bottom, 5)
            
            HStack(spacing: 20) {
                // Steps
                metricView(
                    icon: "figure.walk",
                    value: "\(todaysSteps)",
                    label: "Steps"
                )
                
                // Heart rate
                metricView(
                    icon: "heart.fill",
                    value: String(format: "%.0f", heartRate),
                    label: "BPM"
                )
            }
            
            HStack(spacing: 20) {
                // Sleep
                metricView(
                    icon: "bed.double.fill",
                    value: String(format: "%.1f", sleepHours),
                    label: "Hours"
                )
                
                // Active calories
                metricView(
                    icon: "flame.fill",
                    value: String(format: "%.0f", activeCalories),
                    label: "Cal"
                )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.1))
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
    }
    
    // AI Insights card
    var aiInsightsCard: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("AI Insights")
                .font(.headline)
                .padding(.bottom, 5)
            
            Text("Based on your recent activity patterns, you might benefit from taking more short walks throughout your day.")
                .font(.body)
                .foregroundColor(.secondary)
            
            Button(action: {
                // Navigate to AI chat with this context
            }) {
                Text("Tell me more")
                    .font(.subheadline)
                    .foregroundColor(Color("AccentColor"))
            }
            .padding(.top, 5)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.1))
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
    }
    
    // Quick actions section
    var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Quick Actions")
                .font(.headline)
                .padding(.bottom, 5)
            
            HStack(spacing: 15) {
                quickActionButton(icon: "plus.circle.fill", label: "Log Activity")
                quickActionButton(icon: "moon.fill", label: "Log Sleep")
                quickActionButton(icon: "heart.text.square.fill", label: "Log Mood")
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.1))
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
    }
    
    // Helper function for metric display
    func metricView(icon: String, value: String, label: String) -> some View {
        VStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(Color("AccentColor"))
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
    
    // Helper function for quick action buttons
    func quickActionButton(icon: String, label: String) -> some View {
        Button(action: {
            // Action for the button
        }) {
            VStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(Color("AccentColor"))
                
                Text(label)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.8))
                    .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
            )
        }
    }
    
    // Helper function to format today's date
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: Date())
    }
    
    // Fetch health data from HealthKit
    func fetchHealthData() {
        // This is a placeholder. In a real implementation, we would use the HealthKitManager
        // to fetch actual data from HealthKit.
        
        // For now, let's use sample data
        todaysSteps = 7543
        heartRate = 72
        sleepHours = 7.5
        activeCalories = 320
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HealthKitManager())
            .environmentObject(UserPreferences())
    }
}

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var healthKitManager: HealthKitManager
    @EnvironmentObject var userPreferences: UserPreferences
    @State private var selectedTab = 0
    
    var body: some View {
        if userPreferences.name.isEmpty {
            // Show onboarding if user hasn't completed it
            OnboardingView()
        } else {
            // Main app interface with tabs
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(0)
                
                DashboardView()
                    .tabItem {
                        Label("Dashboard", systemImage: "chart.bar.fill")
                    }
                    .tag(1)
                
                ChatView()
                    .tabItem {
                        Label("AI Chat", systemImage: "message.fill")
                    }
                    .tag(2)
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                    .tag(3)
            }
            .accentColor(Color("AccentColor")) // We'll define this in Assets
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(HealthKitManager())
            .environmentObject(UserPreferences())
    }
}

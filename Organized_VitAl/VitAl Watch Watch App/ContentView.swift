import SwiftUI
import HealthKit

struct WatchContentView: View {
    @EnvironmentObject var healthKitManager: WatchHealthKitManager
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Summary View
            WatchSummaryView()
                .tag(0)
            
            // AI Chat View
            WatchChatView()
                .tag(1)
            
            // Activity View
            WatchActivityView()
                .tag(2)
        }
        .tabViewStyle(PageTabViewStyle())
        .onAppear {
            healthKitManager.fetchTodaysData()
        }
    }
}

// Summary View for watchOS
struct WatchSummaryView: View {
    @EnvironmentObject var healthKitManager: WatchHealthKitManager
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                Text("Daily Summary")
                    .font(.headline)
                
                HStack(spacing: 15) {
                    // Steps
                    VStack {
                        Image(systemName: "figure.walk")
                            .font(.system(size: 20))
                        Text("\(healthKitManager.steps)")
                            .font(.system(size: 16, weight: .semibold))
                        Text("Steps")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Heart Rate
                    VStack {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.red)
                        Text("\(Int(healthKitManager.heartRate))")
                            .font(.system(size: 16, weight: .semibold))
                        Text("BPM")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                }
                
                HStack(spacing: 15) {
                    // Calories
                    VStack {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.orange)
                        Text("\(Int(healthKitManager.activeCalories))")
                            .font(.system(size: 16, weight: .semibold))
                        Text("Cal")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Progress
                    VStack {
                        ZStack {
                            Circle()
                                .stroke(Color.gray.opacity(0.3), lineWidth: 4)
                                .frame(width: 30, height: 30)
                            
                            Circle()
                                .trim(from: 0, to: CGFloat(min(healthKitManager.steps, 10000)) / 10000)
                                .stroke(Color.green, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                                .frame(width: 30, height: 30)
                                .rotationEffect(.degrees(-90))
                        }
                        
                        Text("\(Int(min(Double(healthKitManager.steps) / 10000, 1.0) * 100))%")
                            .font(.system(size: 16, weight: .semibold))
                        
                        Text("Goal")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                }
                
                // AI Insight
                VStack(alignment: .leading, spacing: 5) {
                    Text("AI Insight")
                        .font(.headline)
                        .padding(.top, 5)
                    
                    Text("You're 25% more active today compared to yesterday.")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, 5)
                .padding(.top, 10)
                
                // Ask AI Button
                Button(action: {
                    // Switch to chat tab
                    withAnimation {
                        selectedTab = 1
                    }
                }) {
                    HStack {
                        Image(systemName: "bubble.left.fill")
                        Text("Ask AI")
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(20)
                }
                .padding(.top, 10)
            }
            .padding()
        }
    }
}

// Chat View for watchOS
struct WatchChatView: View {
    @State private var messages: [WatchChatMessage] = []
    @State private var isRecording = false
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            if messages.isEmpty {
                VStack(spacing: 10) {
                    Image(systemName: "bubble.left.and.bubble.right")
                        .font(.system(size: 30))
                        .foregroundColor(.blue)
                    
                    Text("AI Assistant")
                        .font(.headline)
                    
                    Text("Tap to ask a question")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .padding()
            } else {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(messages) { message in
                            HStack {
                                if message.isUser {
                                    Spacer()
                                }
                                
                                Text(message.text)
                                    .padding(8)
                                    .background(message.isUser ? Color.blue : Color.gray.opacity(0.3))
                                    .foregroundColor(message.isUser ? .white : .primary)
                                    .cornerRadius(12)
                                    .fixedSize(horizontal: false, vertical: true)
                                
                                if !message.isUser {
                                    Spacer()
                                }
                            }
                            .padding(.horizontal, 5)
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            
            // Voice input button
            Button(action: {
                if isRecording {
                    // End recording and process
                    isRecording = false
                    processVoiceInput()
                } else {
                    // Start recording
                    isRecording = true
                }
            }) {
                ZStack {
                    Circle()
                        .fill(isRecording ? Color.red : Color.blue)
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: isRecording ? "stop.fill" : "mic.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
            }
            .padding(.bottom, 5)
        }
    }
    
    // Process voice input (simulated)
    func processVoiceInput() {
        // In a real app, we would process actual voice input
        // For now, we'll simulate with a predefined question
        
        let userQuestion = "How am I doing today?"
        
        // Add user message
        let userMessage = WatchChatMessage(id: UUID().uuidString, text: userQuestion, isUser: true)
        messages.append(userMessage)
        
        // Simulate AI response after a brief delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let aiResponse = "You're doing well! You've taken 7,543 steps and burned 320 calories so far today. Your heart rate is normal at 72 BPM."
            let aiMessage = WatchChatMessage(id: UUID().uuidString, text: aiResponse, isUser: false)
            messages.append(aiMessage)
        }
    }
}

// Activity View for watchOS
struct WatchActivityView: View {
    @EnvironmentObject var healthKitManager: WatchHealthKitManager
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                Text("Activity Rings")
                    .font(.headline)
                
                // Activity rings visualization
                ZStack {
                    // Move ring (outer)
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                        .frame(width: 100, height: 100)
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(min(healthKitManager.activeCalories, 500)) / 500)
                        .stroke(Color.red, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .frame(width: 100, height: 100)
                        .rotationEffect(.degrees(-90))
                    
                    // Exercise ring (middle)
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                        .frame(width: 80, height: 80)
                    
                    Circle()
                        .trim(from: 0, to: 0.5) // 50% of exercise goal
                        .stroke(Color.green, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .frame(width: 80, height: 80)
                        .rotationEffect(.degrees(-90))
                    
                    // Stand ring (inner)
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                        .frame(width: 60, height: 60)
                    
                    Circle()
                        .trim(from: 0, to: 0.75) // 75% of stand goal
                        .stroke(Color.blue, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .frame(width: 60, height: 60)
                        .rotationEffect(.degrees(-90))
                }
                .padding(.vertical, 10)
                
                // Activity stats
                VStack(spacing: 10) {
                    HStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                        Text("Move")
                            .font(.system(size: 14))
                        Spacer()
                        Text("\(Int(healthKitManager.activeCalories))/500 Cal")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    
                    HStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 10, height: 10)
                        Text("Exercise")
                            .font(.system(size: 14))
                        Spacer()
                        Text("15/30 min")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    
                    HStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 10, height: 10)
                        Text("Stand")
                            .font(.system(size: 14))
                        Spacer()
                        Text("9/12 hr")
                            .font(.system(size: 14, weight: .semibold))
                    }
                }
                .padding(.horizontal, 10)
                
                // Log workout button
                Button(action: {
                    // Action to log workout
                }) {
                    Text("Log Workout")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .padding(.top, 10)
            }
            .padding()
        }
    }
}

// Chat message model for watchOS
struct WatchChatMessage: Identifiable {
    let id: String
    let text: String
    let isUser: Bool
}

struct WatchContentView_Previews: PreviewProvider {
    static var previews: some View {
        WatchContentView()
            .environmentObject(WatchHealthKitManager())
    }
}

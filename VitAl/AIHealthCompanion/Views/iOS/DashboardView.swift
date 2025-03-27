import SwiftUI
import HealthKit

struct DashboardView: View {
    @EnvironmentObject var healthKitManager: HealthKitManager
    @State private var widgets: [WidgetType] = [.steps, .heartRate, .sleep, .activity]
    @State private var isEditMode = false
    
    // Define widget types
    enum WidgetType: String, CaseIterable, Identifiable {
        case steps = "Steps"
        case heartRate = "Heart Rate"
        case sleep = "Sleep"
        case activity = "Activity"
        case mood = "Mood"
        case correlation = "Correlations"
        
        var id: String { self.rawValue }
        
        var icon: String {
            switch self {
            case .steps: return "figure.walk"
            case .heartRate: return "heart.fill"
            case .sleep: return "bed.double.fill"
            case .activity: return "flame.fill"
            case .mood: return "face.smiling"
            case .correlation: return "chart.bar.xaxis"
            }
        }
        
        var color: Color {
            switch self {
            case .steps: return .blue
            case .heartRate: return .red
            case .sleep: return .purple
            case .activity: return .orange
            case .mood: return .green
            case .correlation: return .teal
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Dashboard widgets
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 20) {
                        ForEach(widgets) { widget in
                            widgetView(for: widget)
                                .opacity(isEditMode ? 0.7 : 1.0)
                                .overlay(
                                    isEditMode ? editOverlay(for: widget) : nil
                                )
                        }
                    }
                    .padding()
                    
                    // Add widget button (only visible in edit mode)
                    if isEditMode {
                        Button(action: {
                            showAddWidgetSheet()
                        }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text("Add Widget")
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("AccentColor").opacity(0.2))
                            .foregroundColor(Color("AccentColor"))
                            .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditMode ? "Done" : "Edit") {
                        withAnimation {
                            isEditMode.toggle()
                        }
                    }
                }
            }
        }
    }
    
    // Widget view based on type
    @ViewBuilder
    func widgetView(for type: WidgetType) -> some View {
        switch type {
        case .steps:
            stepsWidget
        case .heartRate:
            heartRateWidget
        case .sleep:
            sleepWidget
        case .activity:
            activityWidget
        case .mood:
            moodWidget
        case .correlation:
            correlationWidget
        }
    }
    
    // Edit overlay for widgets in edit mode
    func editOverlay(for widget: WidgetType) -> some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: {
                    removeWidget(widget)
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.red)
                        .padding(8)
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                }
                .padding(8)
            }
            
            Spacer()
            
            // Drag handle
            Image(systemName: "line.3.horizontal")
                .font(.title)
                .foregroundColor(.gray)
                .padding(8)
                .background(Color.white.opacity(0.8))
                .clipShape(Circle())
                .padding(.bottom, 8)
        }
    }
    
    // Steps widget
    var stepsWidget: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: "figure.walk")
                    .font(.title2)
                    .foregroundColor(.blue)
                
                Text("Steps")
                    .font(.headline)
                
                Spacer()
                
                Text("Today")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Text("7,543")
                .font(.system(size: 36, weight: .bold))
                .padding(.vertical, 10)
            
            // Sample chart
            HStack(alignment: .bottom, spacing: 4) {
                ForEach(0..<7, id: \.self) { index in
                    let height = [0.4, 0.6, 0.3, 0.7, 0.5, 0.8, 0.6][index]
                    
                    VStack {
                        Rectangle()
                            .fill(Color.blue.opacity(0.7))
                            .frame(height: 100 * height)
                            .cornerRadius(4)
                        
                        Text(["M", "T", "W", "T", "F", "S", "S"][index])
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(height: 120)
            .padding(.top, 10)
            
            HStack {
                Text("Daily Goal: 10,000")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("75%")
                    .font(.caption)
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
            }
            .padding(.top, 5)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.8))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
    
    // Heart rate widget
    var heartRateWidget: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: "heart.fill")
                    .font(.title2)
                    .foregroundColor(.red)
                
                Text("Heart Rate")
                    .font(.headline)
                
                Spacer()
                
                Text("Last 24 hours")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Text("72")
                    .font(.system(size: 36, weight: .bold))
                
                Text("BPM")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.leading, 5)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Range")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("58-85 BPM")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
            .padding(.vertical, 10)
            
            // Sample heart rate chart
            Path { path in
                let width = UIScreen.main.bounds.width - 80
                let height: CGFloat = 80
                let points = [0.5, 0.4, 0.6, 0.5, 0.7, 0.6, 0.8, 0.7, 0.6, 0.5, 0.4, 0.5]
                
                path.move(to: CGPoint(x: 0, y: height * (1 - points[0])))
                
                for i in 1..<points.count {
                    let x = width * CGFloat(i) / CGFloat(points.count - 1)
                    let y = height * (1 - points[i])
                    
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            .stroke(Color.red, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .frame(height: 80)
            .padding(.top, 10)
            
            HStack {
                Text("Resting: 62 BPM")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("Normal")
                    .font(.caption)
                    .foregroundColor(.green)
                    .fontWeight(.bold)
            }
            .padding(.top, 5)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.8))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
    
    // Sleep widget
    var sleepWidget: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: "bed.double.fill")
                    .font(.title2)
                    .foregroundColor(.purple)
                
                Text("Sleep")
                    .font(.headline)
                
                Spacer()
                
                Text("Last Night")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Text("7.5")
                    .font(.system(size: 36, weight: .bold))
                
                Text("hours")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.leading, 5)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Bedtime")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("11:30 PM - 7:00 AM")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
            .padding(.vertical, 10)
            
            // Sleep stages
            VStack(alignment: .leading, spacing: 10) {
                Text("Sleep Stages")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.purple.opacity(0.8))
                        .frame(width: 100, height: 20)
                        .cornerRadius(4, corners: [.topLeft, .bottomLeft])
                    
                    Rectangle()
                        .fill(Color.blue.opacity(0.6))
                        .frame(width: 70, height: 20)
                    
                    Rectangle()
                        .fill(Color.indigo.opacity(0.4))
                        .frame(width: 50, height: 20)
                    
                    Rectangle()
                        .fill(Color.purple.opacity(0.3))
                        .frame(width: 30, height: 20)
                        .cornerRadius(4, corners: [.topRight, .bottomRight])
                }
                
                HStack {
                    HStack {
                        Circle()
                            .fill(Color.purple.opacity(0.8))
                            .frame(width: 8, height: 8)
                        Text("Deep")
                            .font(.caption2)
                    }
                    
                    HStack {
                        Circle()
                            .fill(Color.blue.opacity(0.6))
                            .frame(width: 8, height: 8)
                        Text("Core")
                            .font(.caption2)
                    }
                    
                    HStack {
                        Circle()
                            .fill(Color.indigo.opacity(0.4))
                            .frame(width: 8, height: 8)
                        Text("REM")
                            .font(.caption2)
                    }
                    
                    HStack {
                        Circle()
                            .fill(Color.purple.opacity(0.3))
                            .frame(width: 8, height: 8)
                        Text("Awake")
                            .font(.caption2)
                    }
                }
                .foregroundColor(.secondary)
            }
            .padding(.top, 5)
            
            HStack {
                Text("Weekly Average: 7.2 hrs")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("Good")
                    .font(.caption)
                    .foregroundColor(.green)
                    .fontWeight(.bold)
            }
            .padding(.top, 10)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.8))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
    
    // Activity widget
    var activityWidget: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: "flame.fill")
                    .font(.title2)
                    .foregroundColor(.orange)
                
                Text("Activity")
                    .font(.headline)
                
                Spacer()
                
                Text("Today")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Text("320")
                    .font(.system(size: 36, weight: .bold))
                
                Text("calories")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.leading, 5)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Goal")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("500 calories")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
            .padding(.vertical, 10)
            
            // Activity rings
            HStack(spacing: 20) {
                ZStack {
                    Circle()
                        .stroke(Color.orange.opacity(0.2), lineWidth: 10)
                    
                    Circle()
                        .trim(from: 0, to: 0.64)
                        .stroke(Color.orange, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    
                    VStack {
                        Text("64%")
                            .font(.system(size: 16, weight: .bold))
                        Text("Move")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(width: 80, height: 80)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Exercise")
                            .font(.subheadline)
                        
                        Spacer()
                        
                        Text("25 min")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    
                    ProgressView(value: 0.5)
                        .progressViewStyle(LinearProgressViewStyle(tint: .green))
                    
                    HStack {
                        Text("Stand")
                            .font(.subheadline)
                        
                        Spacer()
                        
                        Text("8 hours")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    
                    ProgressView(value: 0.67)
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                }
            }
            .padding(.top, 10)
            
            HStack {
                Text("Weekly Average: 450 cal")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("On Track")
                    .font(.caption)
                    .foregroundColor(.green)
                    .fontWeight(.bold)
            }
            .padding(.top, 10)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.8))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
    
    // Mood widget
    var moodWidget: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: "face.smiling")
                    .font(.title2)
                    .foregroundColor(.green)
                
                Text("Mood")
                    .font(.headline)
                
                Spacer()
                
                Text("This Week")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            HStack(spacing: 20) {
                Text("😊")
                    .font(.system(size: 48))
                
                VStack(alignment: .leading) {
                    Text("Good")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text("Your mood has been consistent this week")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 10)
            
            // Mood chart for the week
            HStack(alignment: .bottom, spacing: 10) {
                ForEach(0..<7, id: \.self) { index in
                    VStack {
                        Text(["😔", "😊", "😊", "😐", "😊", "😁", "😊"][index])
                            .font(.system(size: 24))
                        
                        Text(["M", "T", "W", "T", "F", "S", "S"][index])
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 10)
            
            Button(action: {
                // Action to log mood
            }) {
                Text("Log Today's Mood")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color.green)
                    .cornerRadius(20)
            }
            .padding(.top, 10)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.8))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
    
    // Correlation widget
    var correlationWidget: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: "chart.bar.xaxis")
                    .font(.title2)
                    .foregroundColor(.teal)
                
                Text("Sleep vs. Activity")
                    .font(.headline)
                
                Spacer()
                
                Text("Last 7 Days")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Text("AI has detected a correlation between your sleep quality and activity levels.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.vertical, 10)
            
            // Sample correlation chart
            HStack(alignment: .bottom, spacing: 8) {
                ForEach(0..<7, id: \.self) { index in
                    let sleepHeight = [0.6, 0.7, 0.8, 0.6, 0.5, 0.9, 0.7][index]
                    let activityHeight = [0.5, 0.6, 0.7, 0.5, 0.4, 0.8, 0.6][index]
                    
                    VStack(spacing: 0) {
                        // Sleep bar
                        Rectangle()
                            .fill(Color.purple.opacity(0.7))
                            .frame(height: 100 * sleepHeight)
                            .cornerRadius(4, corners: [.topLeft, .topRight])
                        
                        // Activity bar
                        Rectangle()
                            .fill(Color.orange.opacity(0.7))
                            .frame(height: 100 * activityHeight)
                            .cornerRadius(4, corners: [.bottomLeft, .bottomRight])
                        
                        Text(["M", "T", "W", "T", "F", "S", "S"][index])
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .padding(.top, 5)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(height: 200)
            .padding(.top, 10)
            
            // Legend
            HStack {
                HStack {
                    Rectangle()
                        .fill(Color.purple.opacity(0.7))
                        .frame(width: 12, height: 12)
                    
                    Text("Sleep")
                        .font(.caption)
                }
                
                Spacer()
                
                HStack {
                    Rectangle()
                        .fill(Color.orange.opacity(0.7))
                        .frame(width: 12, height: 12)
                    
                    Text("Activity")
                        .font(.caption)
                }
            }
            .foregroundColor(.secondary)
            .padding(.top, 5)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.8))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
    
    // Remove a widget
    func removeWidget(_ widget: WidgetType) {
        withAnimation {
            widgets.removeAll { $0 == widget }
        }
    }
    
    // Show sheet to add a new widget
    func showAddWidgetSheet() {
        // This would show a sheet with available widgets to add
        // For now, we'll just add a random widget that's not already on the dashboard
        let availableWidgets = WidgetType.allCases.filter { !widgets.contains($0) }
        
        if let widgetToAdd = availableWidgets.first {
            withAnimation {
                widgets.append(widgetToAdd)
            }
        }
    }
}

// Helper for rounded corners on specific sides
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(HealthKitManager())
    }
}

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var userPreferences: UserPreferences
    @State private var messages: [ChatMessage] = []
    @State private var newMessage: String = ""
    @State private var isTyping: Bool = false
    @State private var showAPIKeyAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if messages.isEmpty {
                    emptyStateView
                } else {
                    chatMessagesView
                }
                
                chatInputView
            }
            .navigationTitle("AI Companion")
            .onAppear {
                // Add initial greeting message if this is the first time
                if messages.isEmpty {
                    let initialMessage = ChatMessage(
                        id: UUID().uuidString,
                        content: "Hello \(userPreferences.name)! I'm your AI health companion. How can I help you today?",
                        isUser: false,
                        timestamp: Date()
                    )
                    messages.append(initialMessage)
                }
                
                // Check if API key is available
                if userPreferences.apiKey.isEmpty {
                    showAPIKeyAlert = true
                }
            }
            .alert(isPresented: $showAPIKeyAlert) {
                Alert(
                    title: Text("OpenAI API Key Required"),
                    message: Text("Please add your OpenAI API key in Settings to use the AI companion features."),
                    primaryButton: .default(Text("Go to Settings")) {
                        // Navigate to settings (in a real app, we'd use a coordinator or router)
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
    
    // Empty state view when no messages
    var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "bubble.left.and.bubble.right")
                .font(.system(size: 70))
                .foregroundColor(Color("AccentColor").opacity(0.7))
                .padding()
            
            Text("Your AI Health Companion")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Ask me about your health data, get personalized insights, or just chat about your wellness goals.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal, 40)
            
            VStack(alignment: .leading, spacing: 15) {
                suggestionButton("How did I sleep last night?")
                suggestionButton("What's my activity trend this week?")
                suggestionButton("Any patterns in my heart rate?")
                suggestionButton("Give me a health tip for today")
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
    }
    
    // Chat messages list view
    var chatMessagesView: some View {
        ScrollViewReader { scrollView in
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(messages) { message in
                        chatBubble(for: message)
                            .id(message.id)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .onChange(of: messages.count) { _ in
                    if let lastMessage = messages.last {
                        withAnimation {
                            scrollView.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
            }
        }
    }
    
    // Chat input view
    var chatInputView: some View {
        VStack {
            // Typing indicator
            if isTyping {
                HStack {
                    Text("AI is typing...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 5)
            }
            
            // Input field
            HStack {
                TextField("Type a message...", text: $newMessage)
                    .padding(12)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                
                Button(action: sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(newMessage.isEmpty ? Color.gray.opacity(0.5) : Color("AccentColor"))
                }
                .disabled(newMessage.isEmpty)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.05), radius: 5, y: -5)
        }
    }
    
    // Chat bubble for a message
    func chatBubble(for message: ChatMessage) -> some View {
        HStack {
            if message.isUser {
                Spacer()
            }
            
            VStack(alignment: message.isUser ? .trailing : .leading, spacing: 5) {
                Text(message.content)
                    .padding(12)
                    .background(message.isUser ? Color("AccentColor") : Color.gray.opacity(0.2))
                    .foregroundColor(message.isUser ? .white : .primary)
                    .cornerRadius(20)
                
                Text(formatTimestamp(message.timestamp))
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 12)
            }
            
            if !message.isUser {
                Spacer()
            }
        }
    }
    
    // Suggestion button for empty state
    func suggestionButton(_ text: String) -> some View {
        Button(action: {
            newMessage = text
            sendMessage()
        }) {
            Text(text)
                .padding(12)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
        .foregroundColor(.primary)
    }
    
    // Send a new message
    func sendMessage() {
        guard !newMessage.isEmpty else { return }
        
        // Create and add user message
        let userMessage = ChatMessage(
            id: UUID().uuidString,
            content: newMessage,
            isUser: true,
            timestamp: Date()
        )
        messages.append(userMessage)
        
        // Clear input field
        let userQuery = newMessage
        newMessage = ""
        
        // Show typing indicator
        isTyping = true
        
        // Simulate AI response (in a real app, we'd call the OpenAI API)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            // Generate AI response based on user query
            let aiResponse = generateAIResponse(to: userQuery)
            
            // Create and add AI message
            let aiMessage = ChatMessage(
                id: UUID().uuidString,
                content: aiResponse,
                isUser: false,
                timestamp: Date()
            )
            messages.append(aiMessage)
            
            // Hide typing indicator
            isTyping = false
        }
    }
    
    // Format timestamp for chat messages
    func formatTimestamp(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    // Simulate AI response (in a real app, we'd use the OpenAI API)
    func generateAIResponse(to query: String) -> String {
        // This is a placeholder. In a real implementation, we would call the OpenAI API
        // with the user's API key and handle the response.
        
        // For now, return canned responses based on keywords in the query
        let lowercasedQuery = query.lowercased()
        
        if lowercasedQuery.contains("sleep") {
            return "Based on your sleep data, you averaged 7.5 hours of sleep last night with 2 hours of deep sleep. This is slightly better than your weekly average of 7.2 hours. Would you like me to suggest ways to improve your sleep quality?"
        } else if lowercasedQuery.contains("activity") || lowercasedQuery.contains("exercise") {
            return "Looking at your activity this week, you've been consistently active with an average of 8,200 steps per day. Your most active day was Saturday with 12,500 steps. Is there a specific aspect of your activity you'd like to discuss?"
        } else if lowercasedQuery.contains("heart") {
            return "Your heart rate has been within normal ranges, averaging 72 BPM at rest. I've noticed that your heart rate tends to be elevated in the afternoons - this could be related to your caffeine intake or stress levels. Would you like to explore this pattern further?"
        } else if lowercasedQuery.contains("tip") || lowercasedQuery.contains("advice") {
            return "Here's a health tip for today: Try incorporating short 5-minute stretching breaks every hour if you're working at a desk. This can help improve circulation, reduce muscle tension, and give your eyes a break from screen time."
        } else {
            return "I'm here to help you understand your health data and provide personalized insights. You can ask me about your sleep, activity, heart rate, or request health tips. What would you like to know more about?"
        }
    }
}

// Chat message model
struct ChatMessage: Identifiable {
    let id: String
    let content: String
    let isUser: Bool
    let timestamp: Date
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
            .environmentObject(UserPreferences())
    }
}

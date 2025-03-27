import CoreData

struct PersistenceController {
    // Shared instance for app-wide access
    static let shared = PersistenceController()
    
    // Storage for Core Data
    let container: NSPersistentContainer
    
    // Test configuration for SwiftUI previews
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        
        // Create 10 example health metrics
        for dayOffset in 0..<10 {
            let viewContext = controller.container.viewContext
            let newMetrics = HealthMetricsEntity(context: viewContext)
            newMetrics.id = UUID()
            newMetrics.date = Calendar.current.date(byAdding: .day, value: -dayOffset, to: Date())!
            newMetrics.steps = Int32.random(in: 5000...12000)
            newMetrics.heartRate = Double.random(in: 60...100)
            newMetrics.sleepHours = Double.random(in: 6...9)
            newMetrics.activeCalories = Double.random(in: 200...500)
        }
        
        // Create example insights
        let insight = InsightEntity(context: controller.container.viewContext)
        insight.id = UUID()
        insight.title = "Sleep Pattern Detected"
        insight.content = "Your sleep quality improves when you exercise in the morning."
        insight.type = "sleep"
        insight.date = Date()
        
        // Create example chat messages
        let userMessage = MessageEntity(context: controller.container.viewContext)
        userMessage.id = UUID()
        userMessage.content = "How did I sleep last night?"
        userMessage.isUser = true
        userMessage.timestamp = Date().addingTimeInterval(-300)
        
        let aiMessage = MessageEntity(context: controller.container.viewContext)
        aiMessage.id = UUID()
        aiMessage.content = "You slept for 7.5 hours last night, which is better than your weekly average of 7.2 hours."
        aiMessage.isUser = false
        aiMessage.timestamp = Date()
        
        do {
            try controller.container.viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return controller
    }()
    
    // Initialize the Core Data stack
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "AIHealthCompanion")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        // Merge policy to handle conflicts
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    // Save the context if there are changes
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - Health Metrics Operations
    
    // Save health metrics to CoreData
    func saveHealthMetrics(_ metrics: HealthMetrics) {
        let context = container.viewContext
        
        // Check if we already have metrics for this date
        let fetchRequest: NSFetchRequest<HealthMetricsEntity> = HealthMetricsEntity.fetchRequest()
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: metrics.date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date < %@", startOfDay as NSDate, endOfDay as NSDate)
        
        do {
            let existingMetrics = try context.fetch(fetchRequest)
            
            if let existingMetric = existingMetrics.first {
                // Update existing metrics
                existingMetric.steps = Int32(metrics.steps)
                existingMetric.heartRate = metrics.heartRate
                existingMetric.sleepHours = metrics.sleepHours
                existingMetric.activeCalories = metrics.activeCalories
            } else {
                // Create new metrics
                let newMetrics = HealthMetricsEntity(context: context)
                newMetrics.id = UUID()
                newMetrics.date = metrics.date
                newMetrics.steps = Int32(metrics.steps)
                newMetrics.heartRate = metrics.heartRate
                newMetrics.sleepHours = metrics.sleepHours
                newMetrics.activeCalories = metrics.activeCalories
            }
            
            save()
        } catch {
            print("Error fetching health metrics: \(error)")
        }
    }
    
    // Fetch health metrics for a specific day
    func fetchHealthMetrics(for date: Date) -> HealthMetrics? {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<HealthMetricsEntity> = HealthMetricsEntity.fetchRequest()
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date < %@", startOfDay as NSDate, endOfDay as NSDate)
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if let entity = results.first {
                var metrics = HealthMetrics()
                metrics.date = entity.date ?? Date()
                metrics.steps = Int(entity.steps)
                metrics.heartRate = entity.heartRate
                metrics.sleepHours = entity.sleepHours
                metrics.activeCalories = entity.activeCalories
                
                return metrics
            }
        } catch {
            print("Error fetching health metrics: \(error)")
        }
        
        return nil
    }
    
    // Fetch health metrics for a date range
    func fetchHealthMetrics(from startDate: Date, to endDate: Date) -> [HealthMetrics] {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<HealthMetricsEntity> = HealthMetricsEntity.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startDate as NSDate, endDate as NSDate)
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \HealthMetricsEntity.date, ascending: true)]
        
        do {
            let results = try context.fetch(fetchRequest)
            
            return results.compactMap { entity in
                var metrics = HealthMetrics()
                metrics.date = entity.date ?? Date()
                metrics.steps = Int(entity.steps)
                metrics.heartRate = entity.heartRate
                metrics.sleepHours = entity.sleepHours
                metrics.activeCalories = entity.activeCalories
                
                return metrics
            }
        } catch {
            print("Error fetching health metrics: \(error)")
            return []
        }
    }
    
    // MARK: - Insights Operations
    
    // Save an AI insight
    func saveInsight(title: String, content: String, type: String) {
        let context = container.viewContext
        
        let insight = InsightEntity(context: context)
        insight.id = UUID()
        insight.title = title
        insight.content = content
        insight.type = type
        insight.date = Date()
        
        save()
    }
    
    // Fetch recent insights
    func fetchRecentInsights(limit: Int = 10) -> [InsightEntity] {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<InsightEntity> = InsightEntity.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \InsightEntity.date, ascending: false)]
        fetchRequest.fetchLimit = limit
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching insights: \(error)")
            return []
        }
    }
    
    // MARK: - Chat Messages Operations
    
    // Save a chat message
    func saveMessage(_ message: ChatMessage) {
        let context = container.viewContext
        
        let messageEntity = MessageEntity(context: context)
        messageEntity.id = UUID(uuidString: message.id) ?? UUID()
        messageEntity.content = message.content
        messageEntity.isUser = message.isUser
        messageEntity.timestamp = message.timestamp
        
        save()
    }
    
    // Fetch chat history
    func fetchChatHistory(limit: Int = 50) -> [ChatMessage] {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<MessageEntity> = MessageEntity.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \MessageEntity.timestamp, ascending: true)]
        fetchRequest.fetchLimit = limit
        
        do {
            let results = try context.fetch(fetchRequest)
            
            return results.map { entity in
                ChatMessage(
                    id: entity.id?.uuidString ?? UUID().uuidString,
                    content: entity.content ?? "",
                    isUser: entity.isUser,
                    timestamp: entity.timestamp ?? Date()
                )
            }
        } catch {
            print("Error fetching chat history: \(error)")
            return []
        }
    }
    
    // Delete all chat messages
    func clearChatHistory() {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = MessageEntity.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try container.persistentStoreCoordinator.execute(batchDeleteRequest, with: context)
            save()
        } catch {
            print("Error clearing chat history: \(error)")
        }
    }
}

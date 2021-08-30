import Foundation

struct Task {
    var id: String
    var title: String
    var dueDate: Date
    var notes: String
    var isComplete: Bool = false
}

extension Task {
    static var testData = [
        Task(id: UUID().uuidString, title: "Submit reimbursement report", dueDate: Date().addingTimeInterval(800.0),
                 notes: "Don't forget about taxi receipts"),
        Task(id: UUID().uuidString, title: "Code review", dueDate: Date().addingTimeInterval(14000.0),
                 notes: "Check tech specs in shared folder", isComplete: true),
        Task(id: UUID().uuidString, title: "Pick up new contacts", dueDate: Date().addingTimeInterval(24000.0),
                 notes: "Optometrist closes at 6:00PM"),
        Task(id: UUID().uuidString, title: "Add notes to retrospective", dueDate: Date().addingTimeInterval(3200.0),
                 notes: "Collaborate with project manager", isComplete: true),
        Task(id: UUID().uuidString, title: "Interview new project manager candidate", dueDate: Date().addingTimeInterval(60000.0),
                 notes: "Review portfolio"),
        Task(id: UUID().uuidString, title: "Mock up onboarding experience", dueDate: Date().addingTimeInterval(72000.0),
                 notes: "Think different"),
        Task(id: UUID().uuidString, title: "Review usage analytics", dueDate: Date().addingTimeInterval(83000.0),
                 notes: "Discuss trends with management"),
        Task(id: UUID().uuidString, title: "Confirm group reservation", dueDate: Date().addingTimeInterval(92500.0),
                 notes: "Ask about space heaters"),
        Task(id: UUID().uuidString, title: "Add beta testers to TestFlight", dueDate: Date().addingTimeInterval(101000.0),
                 notes: "v0.9 out on Friday")
    ]
}

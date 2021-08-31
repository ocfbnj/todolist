import UIKit

class TaskListDataSource: NSObject {
    typealias UpdateTodolist = () -> Void

    enum FilterLevel: Int {
        case today
        case all
    }
    
    let updateTodoList: UpdateTodolist

    var filterLevel: FilterLevel = .today
    var filteredTasks: [Task] {
        switch filterLevel {
        case .all:
            return Task.testData.sorted(by: { $0.dueDate < $1.dueDate })
        case .today:
            return Task.testData
                    .filter({ Locale.current.calendar.isDateInToday($0.dueDate) })
                    .sorted(by: { $0.dueDate < $1.dueDate })
        }
    }

    init(_ updateTodoList: @escaping UpdateTodolist) {
        self.updateTodoList = updateTodoList
    }
    
    func add(_ task: Task) -> Int? {
        Task.testData.append(task)
        return filteredTasks.firstIndex(where: {$0.id == task.id})
    }
    
    func delete(_ cellIndex: Int) {
        guard let index = indexOf(id: filteredTasks[cellIndex].id) else { return }
        Task.testData.remove(at: index)
    }
    
    func indexOf(id taskId: String) -> Int? {
        return Task.testData.firstIndex(where: {$0.id == taskId})
    }
}

extension TaskListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        let data = filteredTasks[indexPath.row]
        cell.configure(title: data.title,
                       dueDate: data.dueDate,
                       notes: data.notes,
                       isComplete: data.isComplete) {
            if let index = self.indexOf(id: self.filteredTasks[indexPath.row].id) {
                Task.testData[index].isComplete.toggle()
            }
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.reloadData() // TODO
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        delete(indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        updateTodoList()
    }
}

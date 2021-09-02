import UIKit

class TaskListDataSource: NSObject {
    enum FilterLevel: Int {
        case today
        case all
    }

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
    
    func add(_ task: Task) -> Int? {
        Task.testData.append(task)
        return tasksOfSections(0).firstIndex(where: {$0.id == task.id})
    }
    
    func delete(_ indexPath: IndexPath) {
        guard let index = rawIndexOf(id: tasksOfSections(indexPath.section)[indexPath.row].id) else { return }
        Task.testData.remove(at: index)
    }
    
    func indexPathOfTask(_ task: Task) -> IndexPath {
        let section = task.isComplete ? 1 : 0
        guard let row = self.tasksOfSections(section).firstIndex(where: { $0.id == task.id }) else {
            fatalError()
        }
        
        return IndexPath(row: row, section: section)
    }
    
    func rawIndexOf(id taskId: String) -> Int? {
        return Task.testData.firstIndex(where: {$0.id == taskId})
    }
}

extension TaskListDataSource {
    enum Section: Int, CaseIterable {
        case unfinished
        case finished
    }

    static let sectionsCount = TaskListDataSource.Section.allCases.count
    
    private func tasksOfSections(_ section: Int) -> [Task] {
        switch section {
        case 0:
            return filteredTasks.filter({ !$0.isComplete })
        case 1:
            return filteredTasks.filter({ $0.isComplete })
        default:
            return [Task]()
        }
    }
    
    private func titleOfSections(_ section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return tasksOfSections(1).count > 0 ? "已完成" : nil
        default:
            return nil
        }
    }
}

extension TaskListDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Self.sectionsCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksOfSections(section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        
        let data = tasksOfSections(indexPath.section)[indexPath.row]
        cell.configure(title: data.title,
                       dueDate: data.dueDate,
                       notes: data.notes,
                       isComplete: data.isComplete) {
            guard let rawIndex = self.rawIndexOf(id: data.id) else { return }
            
            let from = self.indexPathOfTask(Task.testData[rawIndex])
            Task.testData[rawIndex].isComplete.toggle()
            let to = self.indexPathOfTask(Task.testData[rawIndex])
            
            tableView.performBatchUpdates({
                tableView.moveRow(at: from, to: to)
            }) { done in
                if done {
                    tableView.reloadRows(at: [to], with: .automatic)
                }
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        delete(indexPath)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleOfSections(section)
    }
}

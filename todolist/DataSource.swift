import UIKit

class DataSource: NSObject {
    typealias UpdateTodolist = () -> Void
    let updateTodoList: UpdateTodolist
    
    init(_ updateTodoList: @escaping UpdateTodolist) {
        self.updateTodoList = updateTodoList
    }
}

extension DataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Task.testData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        let data = Task.testData[indexPath.row]
        cell.configure(title: data.title,
                       dueDate: data.dueDate,
                       notes: data.notes,
                       isComplete: data.isComplete) {
            Task.testData[indexPath.row].isComplete.toggle()
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.reloadData() // TODO
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        Task.testData.remove(at: indexPath.row)
        tableView.performBatchUpdates({tableView.deleteRows(at: [indexPath], with: .automatic)},
                                      completion: {_ in self.updateTodoList()})
    }
}

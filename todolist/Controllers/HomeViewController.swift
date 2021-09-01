import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapMenuButton()
    func didTapAddButton()
}

class HomeViewController: UITableViewController {
    private var taskListDataSource: TaskListDataSource?
    weak var homeViewControllerDelegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        title = "今天"
        view.backgroundColor = UIColor(red: 243/255.0, green: 245/255.0, blue: 254/255.0, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapMenuButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapAddButton))

        taskListDataSource = TaskListDataSource()
        tableView.dataSource = taskListDataSource
        tableView.separatorStyle = .none
        tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
    }
    
    @objc func didTapMenuButton() {
        homeViewControllerDelegate?.didTapMenuButton()
    }
    
    @objc func didTapAddButton() {
        homeViewControllerDelegate?.didTapAddButton()
    }
    
    func addTask(_ task: Task) {
        if let index = taskListDataSource?.add(task) {
            tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
    }
    
    func changeList(_ level: TaskListDataSource.FilterLevel) {
        taskListDataSource?.filterLevel = level
        switch level {
        case .all:
            title = "收集箱"
        case .today:
            title = "今天"
        }
        
        tableView.reloadSections(IndexSet(integersIn: 0..<TaskListDataSource.sectionsCount), with: .automatic)
    }
}

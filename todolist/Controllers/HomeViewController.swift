import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapMenuButton()
    func didTapAddButton()
}

class HomeViewController: UINavigationController {
    private let tableVC = UITableViewController()
    private let grayView = UIView()
    private var taskListDataSource: TaskListDataSource?
    weak var homeViewControllerDelegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        pushViewController(tableVC, animated: true)
        
        tableVC.title = "今天"
        tableVC.view.backgroundColor = UIColor(red: 243/255.0, green: 245/255.0, blue: 254/255.0, alpha: 1)
        tableVC.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                                   style: .done,
                                                                   target: self,
                                                                   action: #selector(didTapMenuButton))
        tableVC.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                                    style: .done,
                                                                    target: self,
                                                                    action: #selector(didTapAddButton))

        taskListDataSource = TaskListDataSource()
        tableVC.tableView.dataSource = taskListDataSource
        tableVC.tableView.separatorStyle = .none
        tableVC.tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        
        view.addSubview(grayView)
        
        grayView.backgroundColor = .black
        grayView.alpha = 0
        grayView.translatesAutoresizingMaskIntoConstraints = false
        grayView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        grayView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        grayView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        grayView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        grayView.isHidden = true
    }
    
    @objc func didTapMenuButton() {
        homeViewControllerDelegate?.didTapMenuButton()
    }
    
    @objc func didTapAddButton() {
        homeViewControllerDelegate?.didTapAddButton()
    }
    
    func addTask(_ task: Task) {
        if let index = taskListDataSource?.add(task) {
            tableVC.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
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
        
        tableVC.tableView.reloadSections(IndexSet(integersIn: 0..<TaskListDataSource.sectionsCount), with: .automatic)
    }
    
    func fadeInGrayView() {
        grayView.isHidden = false
        UIView.animate(withDuration: 0.33) {
            self.grayView.alpha = 0.5
        }
    }
    
    func fadeOutGrayView() {
        UIView.animate(withDuration: 0.33) {
            self.grayView.alpha = 0
        } completion: { done in
            if done {
                self.grayView.isHidden = true
            }
        }
    }
}

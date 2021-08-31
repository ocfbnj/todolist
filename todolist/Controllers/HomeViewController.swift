import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapMenuButton()
    func didTapAddButton()
}

class HomeViewController: UIViewController {
    private var todolist: UITableView = UITableView()
    private var scrollView: UIScrollView = UIScrollView()

    private var todolistDataSource: DataSource?
    private var heightConstraint: NSLayoutConstraint?
    
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

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.layer.cornerRadius = 5
        
        todolistDataSource = DataSource(updateTodolist)
        todolist.translatesAutoresizingMaskIntoConstraints = false
        todolist.separatorStyle = .none
        todolist.dataSource = todolistDataSource
        todolist.isScrollEnabled = false
        todolist.layer.cornerRadius = 5
        todolist.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")

        var constraints = [NSLayoutConstraint]()
        // scroll view
        constraints.append(scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8))
        constraints.append(scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8))
        constraints.append(scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8))
        constraints.append(scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8))
        
        // todo list
        constraints.append(todolist.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0))
        constraints.append(todolist.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0))
        constraints.append(todolist.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0))
        constraints.append(todolist.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0))
        constraints.append(todolist.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: 0))
        let constraint = todolist.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        constraints.append(constraint)
        heightConstraint = constraint

        view.addSubview(scrollView)
        scrollView.addSubview(todolist)
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateTodolist()
    }
    
    @objc func didTapMenuButton() {
        homeViewControllerDelegate?.didTapMenuButton()
    }
    
    @objc func didTapAddButton() {
        homeViewControllerDelegate?.didTapAddButton()
    }
    
    func addTask(_ task: Task) {
        todolistDataSource?.add(task)
        todolist.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        updateTodolist()
    }
    
    private func updateTodolist() {
        self.heightConstraint?.constant = todolist.contentSize.height
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: { self.scrollView.layoutIfNeeded() }) {
            _ in
            self.todolist.reloadData()
        }
    }
}

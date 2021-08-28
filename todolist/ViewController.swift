import UIKit

class ViewController: UIViewController {
    private var todolist: UITableView = UITableView()
    private var todolistDataSource: DataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemBackground
        
        todolist.translatesAutoresizingMaskIntoConstraints = false
        todolist.separatorStyle = .none
        todolist.dataSource = todolistDataSource
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(todolist.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        constraints.append(todolist.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        constraints.append(todolist.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8))
        constraints.append(todolist.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(todolist.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        
        view.addSubview(todolist)
        NSLayoutConstraint.activate(constraints)
    }


}


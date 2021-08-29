import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

class HomeViewController: UIViewController {
    private var todolist: UITableView = UITableView()
    private var todolistDataSource: DataSource = DataSource()
    weak var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        title = "今天"
        view.backgroundColor = UIColor(red: 243/255.0, green: 245/255.0, blue: 254/255.0, alpha: 1)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapMenuButton))

        todolist.translatesAutoresizingMaskIntoConstraints = false
        todolist.separatorStyle = .none
        todolist.dataSource = todolistDataSource
        todolist.isScrollEnabled = false

        var constraints = [NSLayoutConstraint]()
        constraints.append(todolist.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(todolist.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20))
        constraints.append(todolist.heightAnchor.constraint(greaterThanOrEqualToConstant: 400))
        constraints.append(todolist.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(todolist.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20))

        view.addSubview(todolist)
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
}

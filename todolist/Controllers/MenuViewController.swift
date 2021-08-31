import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func didTapMenuItem(_ itemIndex: Int)
}

class MenuViewController: UIViewController {
    let tableView = UITableView()
    let menuListDateSource = MenuListDataSource()
    weak var menuViewControllerDelegate: MenuViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MenuListDataSource.menuItemCellIdentifier)
        tableView.dataSource = menuListDateSource
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.delegate = self
                
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate(constraints)
    }

}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuViewControllerDelegate?.didTapMenuItem(indexPath.row)
    }
}

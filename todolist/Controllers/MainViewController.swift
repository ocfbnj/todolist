import UIKit

class MainViewController: UIViewController {
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    private var menuVC = MenuViewController()
    private var homeVC = HomeViewController()
    private var addItemVC = AddItemViewController()
    private var navVC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuVC.menuViewControllerDelegate = self
        homeVC.homeViewControllerDelegate = self
        addItemVC.addItemViewControllerDelegate = self
        
        let navVC = UINavigationController(rootViewController: homeVC)
        self.navVC = navVC
        
        addChild(menuVC)
        addChild(navVC)
        addChild(addItemVC)
        
        view.addSubview(menuVC.view)
        view.addSubview(navVC.view)
        view.addSubview(addItemVC.view)
        addItemVC.view.isHidden = true
    }
}

extension MainViewController {
    private func toggleSideMenu() {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
            } completion: { done in
                if done {
                    self.menuState = .opened
                }
            }
        case .opened:
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { done in
                if done {
                    self.menuState = .closed
                }
            }
        }
    }
}

extension MainViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        toggleSideMenu()
    }
    
    func didTapAddButton() {
        addItemVC.view.isHidden = false
    }
}

extension MainViewController: AddItemViewControllerDelegate {
    func didTapDoneButton(_ task: Task) {
        homeVC.addTask(task)
    }
}

extension MainViewController: MenuViewControllerDelegate {
    func didTapMenuItem(_ itemIndex: Int) {
        guard let level = TaskListDataSource.FilterLevel(rawValue: itemIndex) else { return }
        homeVC.changeList(level)
        toggleSideMenu()
    }
}

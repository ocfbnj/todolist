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
    
    static let sideMenuWidth = CGFloat(300)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuVC.menuViewControllerDelegate = self
        homeVC.homeViewControllerDelegate = self
        addItemVC.addItemViewControllerDelegate = self
        
        let navVC = UINavigationController(rootViewController: homeVC)
        self.navVC = navVC
        
        addChild(navVC)
        addChild(menuVC)
        addChild(addItemVC)
        
        view.addSubview(navVC.view)
        view.addSubview(menuVC.view)
        view.addSubview(addItemVC.view)
        
        menuVC.view.frame.size.width = Self.sideMenuWidth
        menuVC.view.isHidden = true
        addItemVC.view.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        menuVC.view.frame.size.width = Self.sideMenuWidth
    }
}

extension MainViewController {
    fileprivate func openMenu() {
        menuVC.view.isHidden = false
        menuVC.view.frame.origin.x = -menuVC.view.frame.size.width
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.menuVC.view.frame.origin.x = 0
        } completion: { done in
            if done {
                self.menuState = .opened
            }
        }
    }
    
    fileprivate func closeMenu() {
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.menuVC.view.frame.origin.x = -self.menuVC.view.frame.size.width
        } completion: { done in
            if done {
                self.menuVC.view.isHidden = true
                self.menuState = .closed
            }
        }
    }
    
    private func toggleSideMenu() {
        switch menuState {
        case .closed:
            openMenu()
        case .opened:
            closeMenu()
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

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
        
        // Menu
        addChild(menuVC)
        view.addSubview(menuVC.view)
        
        // Home
        homeVC.homeViewControllerDelegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        self.navVC = navVC
        
        // Add Item
        addChild(addItemVC)
        view.addSubview(addItemVC.view)
        addItemVC.view.isHidden = true
    }
}

extension MainViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
            } completion: { done in
                if done {
                    self.menuState = .opened
                }
            }
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { done in
                if done {
                    self.menuState = .closed
                }
            }
        }
    }
    
    func didTapAddButton() {
        addItemVC.view.isHidden = false
    }
}

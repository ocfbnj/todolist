import UIKit

class MenuListDataSource: NSObject {
    enum MenuItem: Int, CaseIterable {
        case today
        case collection
        
        func displayText() -> String {
            switch self {
            case .today:
                return "今天"
            case .collection:
                return "收集箱"
            }
        }
        
        func displayImage() -> String {
            switch self {
            case .today:
                return "calendar"
            case .collection:
                return "archivebox"
            }
        }
    }
}

extension MenuListDataSource: UITableViewDataSource {
    static let menuItemCellIdentifier = "MenuItemCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.menuItemCellIdentifier, for: indexPath)
        let menuItem = MenuItem(rawValue: indexPath.row)
        cell.textLabel?.text = menuItem?.displayText()
        cell.imageView?.image = UIImage(systemName: menuItem?.displayImage() ?? "")
        return cell
    }
}

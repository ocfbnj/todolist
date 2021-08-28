import UIKit

class TaskCell: UITableViewCell {
    var doneButton: UIButton = UIButton()
    var titleLabel: UILabel = UILabel()
    var dateLabel: UILabel = UILabel()
    
    func configure() {
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        doneButton.setImage(UIImage(systemName: "circle"), for: .normal)
        titleLabel.text = "标题"
        dateLabel.text = "今天"
        dateLabel.textColor = .gray
        dateLabel.font = dateLabel.font.withSize(13)
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(doneButton.centerYAnchor.constraint(equalTo: centerYAnchor))
        constraints.append(titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor))
        constraints.append(dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor))
        
        constraints.append(doneButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15))
        constraints.append(titleLabel.leadingAnchor.constraint(equalTo: doneButton.trailingAnchor, constant: 15))
        constraints.append(dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15))
        
        addSubview(doneButton)
        addSubview(titleLabel)
        addSubview(dateLabel)
        NSLayoutConstraint.activate(constraints)
    }
}

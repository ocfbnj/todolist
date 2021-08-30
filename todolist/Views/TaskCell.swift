import UIKit

class TaskCell: UITableViewCell {
    typealias DoneButtonAction = () -> Void
    
    private var doneButton: UIButton = UIButton()
    private var titleLabel: UILabel = UILabel()
    private var dateLabel: UILabel = UILabel()
    private var doneButtonAction: DoneButtonAction?
    
    func configure(title: String, dueDate: Date, notes: String, isComplete: Bool, _ action: @escaping DoneButtonAction) {
        doneButtonAction = action
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let image = isComplete ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
        doneButton.setImage(image, for: .normal)
        titleLabel.text = title
        
        dateLabel.text = "今天"
        dateLabel.textColor = .gray
        dateLabel.font = dateLabel.font.withSize(13)
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(doneButton.centerYAnchor.constraint(equalTo: centerYAnchor))
        constraints.append(titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor))
        constraints.append(dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor))
        
        constraints.append(doneButton.widthAnchor.constraint(equalToConstant: 20))
        constraints.append(dateLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 30))
        
        constraints.append(doneButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15))
        constraints.append(titleLabel.leadingAnchor.constraint(equalTo: doneButton.trailingAnchor, constant: 15))
        constraints.append(dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15))
        
        constraints.append(titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: dateLabel.leadingAnchor, constant: -10))
        
        addSubview(doneButton)
        addSubview(titleLabel)
        addSubview(dateLabel)
        NSLayoutConstraint.activate(constraints)
        
        doneButton.addTarget(self, action: #selector(didTapDoneButton(_:)), for: .touchUpInside)
    }
    
    @objc func didTapDoneButton(_ sender: UIButton) {
        doneButtonAction?()
    }
}

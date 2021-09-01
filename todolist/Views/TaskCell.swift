import UIKit

class TaskCell: UITableViewCell {
    typealias DoneButtonAction = () -> Void
    
    private var doneButton: UIButton = UIButton()
    private var titleLabel: UILabel = UILabel()
    private var dateLabel: UILabel = UILabel()
    private var doneButtonAction: DoneButtonAction?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(doneButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(doneButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        constraints.append(doneButton.widthAnchor.constraint(equalToConstant: 20))
        constraints.append(doneButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15))
        
        constraints.append(titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        constraints.append(titleLabel.leadingAnchor.constraint(equalTo: doneButton.trailingAnchor, constant: 15))
        constraints.append(titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: dateLabel.leadingAnchor, constant: -10))
        
        constraints.append(dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        constraints.append(dateLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 30))
        constraints.append(dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15))
        
        NSLayoutConstraint.activate(constraints)
        
        doneButton.addTarget(self, action: #selector(didTapDoneButton(_:)), for: .touchUpInside)
    }
    
    func configure(title: String, dueDate: Date, notes: String, isComplete: Bool, _ action: @escaping DoneButtonAction) {
        doneButtonAction = action
        
        let image = isComplete ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
        doneButton.setImage(image, for: .normal)
        titleLabel.text = title
        
        dateLabel.text = getDateString(dueDate)
        dateLabel.textColor = .gray
        dateLabel.font = dateLabel.font.withSize(13)
    }
    
    @objc func didTapDoneButton(_ sender: UIButton) {
        doneButtonAction?()
    }
}

extension TaskCell {
    static let thisYearDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M月d日"
        return dateFormatter
    }()
    
    static let defaultDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y年M月d日"
        return dateFormatter
    }()
    
    private func getDateString(_ date: Date) -> String {
        if Locale.current.calendar.isDateInToday(date) {
            return "今天"
        }
        
        if Locale.current.calendar.isDateInTomorrow(date) {
            return "明天"
        }
        
        if Locale.current.calendar.isDateInYesterday(date) {
            return "昨天"
        }
        
        let now = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        if calendar.component(.year, from: now) == year {
            return TaskCell.thisYearDateFormatter.string(from: date)
        }
        
        return TaskCell.defaultDateFormatter.string(from: date)
    }
}

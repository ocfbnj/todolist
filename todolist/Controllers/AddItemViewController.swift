import UIKit

class AddItemViewController: UIViewController {
    private var header = UIView()
    private var closeButton = UIButton()
    
    private var grayView = UIView()
    private var datePicker = UIDatePicker()

    private var footer = UIView()
    private var textField = UITextField()
    private var dateButton = UIButton()
    private var doneButton = UIButton()
    
//    private var footerHeightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        // header
        header.translatesAutoresizingMaskIntoConstraints = false
        header.backgroundColor = UIColor(red: 243/255.0, green: 245/255.0, blue: 254/255.0, alpha: 1)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.addTarget(self, action: #selector(didTapCloseButton(_:)), for: .touchUpInside)
        
        // gray view
//        let tapGestureReconzier = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
//        grayView.addGestureRecognizer(tapGestureReconzier)
        grayView.translatesAutoresizingMaskIntoConstraints = false
        grayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 50/255.0)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .inline
        datePicker.backgroundColor = .systemBackground
        datePicker.isHidden = true
        
        // footer
        footer.translatesAutoresizingMaskIntoConstraints = false
        footer.backgroundColor = .systemBackground
        footer.layer.cornerRadius = 20
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "准备做什么？"
        dateButton.setImage(UIImage(systemName: "calendar"), for: .normal)
        dateButton.translatesAutoresizingMaskIntoConstraints = false
        dateButton.addTarget(self, action: #selector(didTapDateButton(_:)), for: .touchUpInside)
        doneButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.addTarget(self, action: #selector(didTapDoneButton(_:)), for: .touchUpInside)
        
        var constraints = [NSLayoutConstraint]()

        // header
        constraints.append(header.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0))
        constraints.append(header.topAnchor.constraint(equalTo: view.topAnchor, constant: 0))
        constraints.append(header.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0))
        constraints.append(header.heightAnchor.constraint(equalToConstant: 100))
        constraints.append(closeButton.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 15))
        constraints.append(closeButton.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -15))
        
        // gray view
        constraints.append(grayView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0))
        constraints.append(grayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0))
        constraints.append(grayView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 0))
        constraints.append(grayView.bottomAnchor.constraint(equalTo: footer.topAnchor, constant: 0))
        constraints.append(datePicker.leadingAnchor.constraint(equalTo: grayView.leadingAnchor, constant: 20))
        constraints.append(datePicker.trailingAnchor.constraint(equalTo: grayView.trailingAnchor, constant: -20))
        constraints.append(datePicker.centerYAnchor.constraint(equalTo: grayView.centerYAnchor))
        
        // footer
        constraints.append(footer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0))
        constraints.append(footer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0))
        constraints.append(footer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0))
        let heightConstraint = footer.heightAnchor.constraint(equalToConstant: 135)
        constraints.append(heightConstraint)
//        footerHeightConstraint = heightConstraint
        constraints.append(textField.topAnchor.constraint(equalTo: footer.topAnchor, constant: 15))
        constraints.append(textField.leadingAnchor.constraint(equalTo: footer.leadingAnchor, constant: 15))
        constraints.append(textField.trailingAnchor.constraint(equalTo: footer.trailingAnchor, constant: -15))
        constraints.append(textField.heightAnchor.constraint(equalToConstant: 30))
        constraints.append(dateButton.leftAnchor.constraint(equalTo: footer.leftAnchor, constant: 18))
        constraints.append(dateButton.bottomAnchor.constraint(equalTo: footer.safeAreaLayoutGuide.bottomAnchor, constant: -15))
        constraints.append(doneButton.trailingAnchor.constraint(equalTo: footer.trailingAnchor, constant: -20))
        constraints.append(doneButton.bottomAnchor.constraint(equalTo: footer.safeAreaLayoutGuide.bottomAnchor, constant: -15))

        view.addSubview(header)
        header.addSubview(closeButton)
        
        view.addSubview(grayView)
        grayView.addSubview(datePicker)
        
        view.addSubview(footer)
        footer.addSubview(textField)
        footer.addSubview(dateButton)
        footer.addSubview(doneButton)

        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        hidden()
    }
    
    @objc func didTapCloseButton(_ sender: UIButton) {
        hidden()
    }
    
    @objc func didTapDateButton(_ sender: UIButton) {
        datePicker.isHidden = false
//        footerHeightConstraint?.constant = 0
//        UIView.animate(withDuration: 0.22,
//                       delay: 0,
//                       options: .curveEaseOut,
//                       animations: {
//                        self.view.layoutIfNeeded();
//                       },
//                       completion: nil)
    }
    
    @objc func didTapDoneButton(_ sender: UIButton) {
        guard let title = textField.text else {
            return
        }
        let date = datePicker.date
        print("title: ", title, ", date: ", date)
        
        hidden()
    }
    
    private func hidden() {
        view.isHidden = true
        textField.text = nil
        datePicker.isHidden = true
//        footerHeightConstraint?.constant = 135
    }
}
